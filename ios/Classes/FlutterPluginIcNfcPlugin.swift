import Flutter
import UIKit
import ICNFCCardReader

public class FlutterPluginIcNfcPlugin: NSObject, FlutterPlugin {
  private enum Channel {
    static let name = "flutter.sdk.ic.nfc/integrate"
  }

  private var pendingResult: FlutterResult?

  private var flutterViewController: UIViewController? {
    var keyWindow: UIWindow?
    if #available(iOS 13.0, *) {
      keyWindow = UIApplication.shared.connectedScenes
        .compactMap { $0 as? UIWindowScene }
        .flatMap { $0.windows }
        .first { $0.isKeyWindow }
    } else {
      keyWindow = UIApplication.shared.windows.first { $0.isKeyWindow }
    }

    guard let window = keyWindow,
          var topController = window.rootViewController else {
      return nil
    }

    while let presentedViewController = topController.presentedViewController {
      topController = presentedViewController
    }

    return topController
  }

  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: Channel.name, binaryMessenger: registrar.messenger())
    let instance = FlutterPluginIcNfcPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    guard let controller = flutterViewController else {
      result(FlutterError(code: "NO_VIEW_CONTROLLER",
                          message: "Unable to locate root view controller",
                          details: nil))
      return
    }

    pendingResult = result
    let args = call.arguments as? [String: Any] ?? [:]

    switch call.method {
    case "NFC_QR_CODE":
      actionOpenQRAndNFC(controller, args: args)
    case "NFC_MRZ_CODE":
      actionStartMRZNFC(controller, args: args)
    case "NFC_ONLY_UI":
      actionStartOnlyNFC(controller, args: args)
    case "NFC_ONLY_WITHOUT_UI":
      actionStartOnlyNFCWithoutUI(controller, args: args)
    case "getPlatformVersion":
      pendingResult?("iOS " + UIDevice.current.systemVersion)
      pendingResult = nil
    default:
      pendingResult?(FlutterMethodNotImplemented)
      pendingResult = nil
    }
  }

  // MARK: - QR + NFC

  private func actionOpenQRAndNFC(_ controller: UIViewController, args: [String: Any]) {
    guard #available(iOS 13.0, *) else {
      sendUnsupportedVersionError()
      return
    }
      
    let reader = ICMainNFCReaderRouter.createModule() as! ICMainNFCReaderViewController

    reader.icMainNFCDelegate = self

    configureAuthentication(for: reader, with: args)
    configureNFCCommonOptions(for: reader, args: args)
    configureUIOptions(for: reader, args: args)
    
    reader.modalPresentationStyle = .fullScreen
    reader.modalTransitionStyle = .coverVertical

    controller.present(reader, animated: true)
  }

  // MARK: - MRZ + NFC

  private func actionStartMRZNFC(_ controller: UIViewController, args: [String: Any]) {
    guard #available(iOS 13.0, *) else {
      sendUnsupportedVersionError()
      return
    }
    let reader = ICMainNFCReaderRouter.createModule() as! ICMainNFCReaderViewController

    reader.icMainNFCDelegate = self

    configureAuthentication(for: reader, with: args)
    configureNFCCommonOptions(for: reader, args: args)
    configureUIOptions(for: reader, args: args)
    
    reader.modalPresentationStyle = .fullScreen
    reader.modalTransitionStyle = .coverVertical

    controller.present(reader, animated: true)
  }

  // MARK: - Only NFC (UI)

  private func actionStartOnlyNFC(_ controller: UIViewController, args: [String: Any]) {
    guard validateNFCPersonalInfo(args) else {
      sendInvalidArgumentsError("You must provide idNumber (12 digits), birthday (YYMMDD) and expiredDate (YYMMDD).")
      return
    }

    guard #available(iOS 13.0, *) else {
      sendUnsupportedVersionError()
      return
    }

    let reader = ICMainNFCReaderRouter.createModule() as! ICMainNFCReaderViewController

    configureAuthentication(for: reader, with: args)
    configureNFCCommonOptions(for: reader, args: args)
    configureUIOptions(for: reader, args: args)
    
    reader.modalPresentationStyle = .fullScreen
    reader.modalTransitionStyle = .coverVertical

    controller.present(reader, animated: true)
  }

  // MARK: - Only NFC (Without UI)

  private func actionStartOnlyNFCWithoutUI(_ controller: UIViewController, args: [String: Any]) {
    guard validateNFCPersonalInfo(args) else {
      sendInvalidArgumentsError("You must provide idNumber (12 digits), birthday (YYMMDD) and expiredDate (YYMMDD).")
      return
    }

    guard #available(iOS 13.0, *) else {
      sendUnsupportedVersionError()
      return
    }

    let reader = ICMainNFCReaderRouter.createModule() as! ICMainNFCReaderViewController
    

    reader.icMainNFCDelegate = self
    configureAuthentication(for: reader, with: args)
    configureNFCCommonOptions(for: reader, args: args, includeLanguageAndTutorial: false)
    reader.idNumberCard = args["idNumber"] as? String ?? ""
    reader.birthdayCard = args["birthday"] as? String ?? ""
    reader.expiredDateCard = args["expiredDate"] as? String ?? ""
    reader.startNFCReaderOutSide()
  }

  // MARK: - Helpers
  private func convertReaderCardMode(from args: [String: Any]) -> ReaderCardMode {
    switch args["readerCardMode"] as? String ?? "" {
    case "QRCode":
        return QRCode
    case "MRZCode":
      return MRZCode
    case "NFCReader":
      return NFCReader
    case "NFCOutside":
      return NFCOutside
    default:
      return QRCode
    }
  }
  
  private func convertModeUploadFile(from value: String) -> ICNFCModeUploadFile {
    switch value {
    case "ICNFCCreateLink":
      return ICNFCCreateLink
    default:
      return ICNFCDefault
    }
  }
  
  private func convertFlowNFC(from value: String) -> ICNFCFlow {
    switch value {
    case "ICNFCETB":
      return ICNFCETB
    case "ICNFCVERIFY":
      return ICNFCVERIFY
    default:
      return ICNFCNTB
    }
  }

  // MARK: - Reader Configuration Helpers

  private func configureAuthentication(for reader: ICMainNFCReaderViewController, with args: [String: Any]) {
    reader.tokenId = args[KeyArgumentMethodChannel.tokenId] as? String ?? ""
    reader.tokenKey = args[KeyArgumentMethodChannel.tokenKey] as? String ?? ""
    reader.accessToken = args[KeyArgumentMethodChannel.accessToken] as? String ?? ""
    reader.tokenIdEKYC = args[KeyArgumentMethodChannel.tokenIdEKYC] as? String ?? ""
    reader.tokenKeyEKYC = args[KeyArgumentMethodChannel.tokenKeyEKYC] as? String ?? ""
    reader.accessTokenEKYC = args[KeyArgumentMethodChannel.accessTokenEKYC] as? String ?? ""
    reader.baseUrl = args[KeyArgumentMethodChannel.baseUrl] as? String ?? ""
  }

  private func configureNFCCommonOptions(for reader: ICMainNFCReaderViewController,
                                         args: [String: Any],
                                         includeLanguageAndTutorial: Bool = true) {
    if includeLanguageAndTutorial {
      reader.languageSdk = args[KeyArgumentMethodChannel.languageSdk] as? String ?? "icnfc_vi"
      reader.isShowTutorial = args[KeyArgumentMethodChannel.isShowTutorial] as? Bool ?? false
      reader.isEnableGotIt = args[KeyArgumentMethodChannel.isEnableGotIt] as? Bool ?? false
      reader.isDisableTutorial = args[KeyArgumentMethodChannel.isDisableTutorial] as? Bool ?? false
    }

    reader.readerCardMode = convertReaderCardMode(from: args)
    reader.isEnableUploadImage = args[KeyArgumentMethodChannel.isEnableUploadImage] as? Bool ?? true
    reader.isEnablePostcodeMatching = args[KeyArgumentMethodChannel.isEnablePostcodeMatching] as? Bool ?? false
    reader.inputClientSession = args[KeyArgumentMethodChannel.inputClientSession] as? String ?? ""
    reader.challengeCode = args[KeyArgumentMethodChannel.challengeCode] as? String ?? ""
    
    // Configure readingTagsNFC from args if provided
    if let readingTags = args[KeyArgumentMethodChannel.readingTagsNFC] as? [Int] {
      reader.readingTagsNFC = readingTags
    } else {
      reader.readingTagsNFC = defaultReadingTags()
    }
    
    reader.nameVideoHelpNFC = args[KeyArgumentMethodChannel.nameVideoHelpNFC] as? String ?? ""
    reader.textReadyNFC = args[KeyArgumentMethodChannel.textReadyNFC] as? String ?? ""
    reader.textScanningNFC = args[KeyArgumentMethodChannel.textScanningNFC] as? String ?? ""
    reader.textFinishNFC = args[KeyArgumentMethodChannel.textFinishNFC] as? String ?? ""
    reader.textDetectedNFC = args[KeyArgumentMethodChannel.textDetectedNFC] as? String ?? ""
    reader.publicKey = args[KeyArgumentMethodChannel.publicKey] as? String ?? ""
    reader.isEnableEncrypt = args[KeyArgumentMethodChannel.isEnableEncrypt] as? Bool ?? false
    
    // Configure modeUploadFile
    if let modeUploadFileStr = args[KeyArgumentMethodChannel.modeUploadFile] as? String {
      reader.modeUploadFile = convertModeUploadFile(from: modeUploadFileStr)
    }
    
    // Configure flowNFC
    if let flowNFCStr = args[KeyArgumentMethodChannel.flowNFC] as? String {
      reader.flowNFC = convertFlowNFC(from: flowNFCStr)
    }
    
    reader.numberTimesRetryScanNFC = NSNumber(value: args[KeyArgumentMethodChannel.numberTimesRetryScanNFC] as? Int ?? 3)
    reader.isEnableCheckSimulator = args[KeyArgumentMethodChannel.isEnableCheckSimulator] as? Bool ?? false
    reader.isEnableCheckJailbroken = args[KeyArgumentMethodChannel.isEnableCheckJailbroken] as? Bool ?? false
    reader.isAnimatedDismissed = args[KeyArgumentMethodChannel.isAnimatedDismissed] as? Bool ?? true
    
    // Environment URLs
    reader.urlUploadImage = args[KeyArgumentMethodChannel.urlUploadImage] as? String ?? ""
    reader.urlUploadDataNFC = args[KeyArgumentMethodChannel.urlUploadDataNFC] as? String ?? ""
    reader.urlUploadLogSDK = args[KeyArgumentMethodChannel.urlUploadLogSDK] as? String ?? ""
    reader.urlPostcodeMatching = args[KeyArgumentMethodChannel.urlPostcodeMatching] as? String ?? ""
    
    // Headers and transaction info
    if let headers = args[KeyArgumentMethodChannel.headersRequest] as? [String: String] {
      reader.headersRequest = NSMutableDictionary(dictionary: headers)
    }
    reader.transactionId = args[KeyArgumentMethodChannel.transactionId] as? String ?? ""
    reader.transactionPartnerId = args[KeyArgumentMethodChannel.transactionPartnerId] as? String ?? ""
    reader.nameSSLPinning = args[KeyArgumentMethodChannel.nameSSLPinning] as? String ?? ""
  }

  private func configureUIOptions(for reader: ICMainNFCReaderViewController, args: [String: Any]) {
    reader.contentColorHeaderBar = UIColorFromRGB(rgbValue: 0x142730, alpha: 1.0)
    reader.textColorContentMain = UIColorFromRGB(rgbValue: 0x142730, alpha: 1.0)
    reader.modeButtonHeaderBar = RightButton
    reader.backgroundColorButton = UIColorFromRGB(rgbValue: 0x184693, alpha: 1.0)
    reader.textColorTitleButton = UIColorFromRGB(rgbValue: 0xFFFFFF, alpha: 1.0)
    reader.backgroundColorMainScreen = UIColorFromRGB(rgbValue: 0xFFFFFF, alpha: 1.0)
    reader.isShowTutorial = args[KeyArgumentMethodChannel.isShowTutorial] as? Bool ?? false
//    reader.isShowLogo = args[KeyArgumentMethodChannel.isShowLogo] as? Bool ?? false
    reader.transactionPartnerIDUploadNFC = args[KeyArgumentMethodChannel.transactionPartnerIDUploadNFC] as? String ?? ""
    reader.transactionPartnerIDRecentLocation = args[KeyArgumentMethodChannel.transactionPartnerIDRecentLocation] as? String ?? ""
    reader.transactionPartnerIDOriginalLocation = args[KeyArgumentMethodChannel.transactionPartnerIDOriginalLocation] as? String ?? ""
    reader.isEnableCheckChipClone = args[KeyArgumentMethodChannel.isEnableCheckChipClone] as? Bool ?? false
    reader.isEnableWaterMark = args[KeyArgumentMethodChannel.isEnableWaterMark] as? Bool ?? true
    reader.isEnableAddIdCheckData = args[KeyArgumentMethodChannel.isEnableAddIdCheckData] as? Bool ?? false
    reader.isEnableUploadDG = args[KeyArgumentMethodChannel.isEnableUploadDG] as? Bool ?? false
  }

  private func validateNFCPersonalInfo(_ args: [String: Any]) -> Bool {
    guard let idNumber = args[KeyArgumentMethodChannel.idNumber] as? String,
          let birthday = args[KeyArgumentMethodChannel.birthday] as? String,
          let expiredDate = args[KeyArgumentMethodChannel.expiredDate] as? String else {
      return false
    }

    return idNumber.count == 12 && birthday.count == 6 && expiredDate.count == 6
  }

  private func defaultReadingTags() -> [Int] {
    return [
      CardReaderValues.VerifyDocumentInfo.rawValue,
      CardReaderValues.MRZInfo.rawValue,
      CardReaderValues.ImageAvatarInfo.rawValue,
      CardReaderValues.SecurityDataInfo.rawValue
    ]
  }

    func UIColorFromRGB(rgbValue: UInt, alpha: CGFloat) -> UIColor {
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(alpha)
        )
    }

  private func sendUnsupportedVersionError() {
    pendingResult?(FlutterError(code: "UNSUPPORTED_VERSION",
                                message: "This feature requires iOS 13.0 or higher.",
                                details: nil))
    pendingResult = nil
  }

  private func sendInvalidArgumentsError(_ message: String) {
    pendingResult?(FlutterError(code: "INVALID_ARGUMENTS",
                                message: message,
                                details: nil))
    pendingResult = nil
  }

  private func sendJSONEncodingError(_ error: Error) {
    pendingResult?(FlutterError(code: "JSON_ERROR",
                                message: error.localizedDescription,
                                details: nil))
    pendingResult = nil
  }
}

extension FlutterPluginIcNfcPlugin: ICMainNFCReaderDelegate {
  public func icNFCMainDismissed() {
    pendingResult?(FlutterError(code: "CANCELLED",
                                message: "User closed NFC SDK.",
                                details: nil))
    pendingResult = nil
  }

  public func icNFCCardReaderGetResult() {
    let saveData = ICNFCSaveData.shared()

    var dataNFCResultJSON = ""
    do {
      let jsonData = try JSONSerialization.data(withJSONObject: saveData.dataNFCResult, options: .prettyPrinted)
      dataNFCResultJSON = String(data: jsonData, encoding: .utf8) ?? ""
    } catch {
      print(error.localizedDescription)
    }

    let dict: [String: Any] = [
      KeyResultConstantsNFC.dataGroupsResult: saveData.dataGroupsResult,
      KeyResultConstantsNFC.dataNFCResult: saveData.dataNFCResult,
      KeyResultConstantsNFC.clientSessionResult: saveData.clientSessionResult,
      KeyResultConstantsNFC.pathImageAvatar: saveData.pathImageAvatar.absoluteString,
      KeyResultConstantsNFC.hashImageAvatar: saveData.hashImageAvatar,
      KeyResultConstantsNFC.dataNFCResultJSON: dataNFCResultJSON,
      KeyResultConstantsNFC.postcodeOriginalLocationResult: saveData.postcodeOriginalLocationResult,
      KeyResultConstantsNFC.postcodeRecentLocationResult: saveData.postcodeRecentLocationResult,
      KeyResultConstantsNFC.hashAvatarForLog: saveData.hashAvatarForLog,
      KeyResultConstantsNFC.hashDGsForLog: saveData.hashDGsForLog,
      KeyResultConstantsNFC.nfcForLog: saveData.nfcForLog,
      KeyResultConstantsNFC.matchingOriginForLog: saveData.matchingOriginForLog,
      KeyResultConstantsNFC.matchingResidenceForLog: saveData.matchingResidenceForLog
    ]

    do {
      let jsonData = try JSONSerialization.data(withJSONObject: dict, options: .prettyPrinted)
      let jsonString = String(data: jsonData, encoding: .utf8)
      pendingResult?(jsonString)
      pendingResult = nil
    } catch {
      sendJSONEncodingError(error)
    }
  }
}
