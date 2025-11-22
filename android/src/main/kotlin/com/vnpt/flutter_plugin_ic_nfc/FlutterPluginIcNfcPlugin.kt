package com.vnpt.flutter_plugin_ic_nfc

import android.app.Activity
import android.app.Activity.RESULT_OK
import android.content.Context
import android.content.Context.NFC_SERVICE
import android.content.Intent
import android.nfc.NfcManager
import com.google.gson.Gson
import com.vnptit.nfc.activity.VnptScanNFCActivity
import com.vnptit.nfc.nfc_tool.NfcResult
import com.vnptit.nfc.utils.KeyIntentConstantsNFC
import com.vnptit.nfc.utils.KeyResultConstantsNFC
import com.vnptit.nfc.utils.SDKEnumNFC
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.PluginRegistry
import org.json.JSONArray
import org.json.JSONObject
import kotlin.jvm.java

/** FlutterPluginIcNfcPlugin */
class FlutterPluginIcNfcPlugin : FlutterPlugin, ActivityAware, MethodCallHandler {
    companion object {
        private const val CHANNEL = "flutter.sdk.ic.nfc/integrate"
        private const val NFC_REQUEST_CODE = 11021
        const val NFC_RESULT = "nfc_result"
        const val EKYC_REQUEST_CODE = 11022
        const val NFC_NO_GUIDE_REQUEST_CODE = 11023
        const val ERROR_NFC_CODE = "69"

        fun navigateToOnlyNFC(ctx: Context, json: JSONObject): Intent {
            return Intent(ctx, VnptScanNFCActivity::class.java).also {
                /**
                 * Truyền access token chứa bearer
                 */
                it.putExtra(KeyIntentConstantsNFC.ACCESS_TOKEN, json.optString(KeyArgumentMethodChannel.ACCESS_TOKEN, ""))
                /**
                 * Truyền token id
                 */
                it.putExtra(KeyIntentConstantsNFC.TOKEN_ID, json.optString(KeyArgumentMethodChannel.TOKEN_ID, ""))
                /**
                 * Truyền token key
                 */
                it.putExtra(KeyIntentConstantsNFC.TOKEN_KEY, json.optString(KeyArgumentMethodChannel.TOKEN_KEY, ""))
                /**
                 * Truyền access token ekyc chứa bearer
                 */
                it.putExtra(KeyIntentConstantsNFC.ACCESS_TOKEN_EKYC, json.optString(KeyArgumentMethodChannel.ACCESS_TOKEN_EKYC, ""))
                /**
                 * Truyền token id ekyc
                 */
                it.putExtra(KeyIntentConstantsNFC.TOKEN_ID_EKYC, json.optString(KeyArgumentMethodChannel.TOKEN_ID_EKYC, ""))
                /**
                 * Truyền token key ekyc
                 */
                it.putExtra(KeyIntentConstantsNFC.TOKEN_KEY_EKYC, json.optString(KeyArgumentMethodChannel.TOKEN_KEY_EKYC, ""))
                /**
                 * điều chỉnh ngôn ngữ tiếng việt
                 *    - vi: tiếng việt
                 *    - en: tiếng anh
                 */
                it.putExtra(KeyIntentConstantsNFC.LANGUAGE_SDK, SDKEnumNFC.LanguageEnum.VIETNAMESE.value)
                /**
                 * hiển thị màn hình hướng dẫn + hiển thị nút bỏ qua hướng dẫn
                 * - mặc định luôn luôn hiển thị màn hình hướng dẫn
                 *    - true: hiển thị nút bỏ qua
                 *    - false: ko hiển thị nút bỏ qua
                 */
                it.putExtra(KeyIntentConstantsNFC.IS_ENABLE_GOT_IT, true)
                /**
                 * bật tính năng upload ảnh
                 *    - true: bật tính năng
                 *    - false: tắt tính năng
                 */
                it.putExtra(KeyIntentConstantsNFC.IS_ENABLE_UPLOAD_IMAGE, true)
                /**
                 * bật tính năng get Postcode
                 *    - true: bật tính năng
                 *    - false: tắt tính năng
                 */
                it.putExtra(KeyIntentConstantsNFC.IS_ENABLE_POSTCODE_MATCHING, true)
                /**
                 * truyền các giá trị đọc thẻ
                 *    - nếu không truyền gì mặc định sẽ đọc tất cả (MRZ,Verify Document,Image Avatar)
                 *    - giá trị truyền vào là 1 mảng int: nếu muốn đọc giá trị nào sẽ truyền
                 *      giá trị đó vào mảng
                 * eg: chỉ đọc thông tin MRZ
                 *    intArrayOf(SDKEnumNFC.ReadingNFCTags.MRZInfo.value)
                 */
                it.putExtra(
                    KeyIntentConstantsNFC.READING_TAGS_NFC,
                    intArrayOf(
                        SDKEnumNFC.ReadingNFCTags.MRZInfo.value,
                        SDKEnumNFC.ReadingNFCTags.VerifyDocumentInfo.value,
                        SDKEnumNFC.ReadingNFCTags.ImageAvatarInfo.value
                    )
                )
                /**
                 * Truyền chế độ đọc thẻ
                 */
                it.putExtra(KeyIntentConstantsNFC.READER_CARD_MODE, SDKEnumNFC.ReaderCardMode.NONE.getValue())
                // set baseDomain="" => sử dụng mặc định là Product
                it.putExtra(KeyIntentConstantsNFC.BASE_URL, "")
                // truyền id định danh căn cước công dân
                it.putExtra(KeyIntentConstantsNFC.ID_NUMBER_CARD, json.optString(KeyArgumentMethodChannel.ID_NUMBER, ""))
                // truyền ngày sinh ghi trên căn cước công dân
                it.putExtra(KeyIntentConstantsNFC.BIRTHDAY_CARD, json.optString(KeyArgumentMethodChannel.BIRTHDAY, ""))
                // truyền ngày hết hạn căn cước công dân
                it.putExtra(KeyIntentConstantsNFC.EXPIRED_DATE_CARD, json.optString(KeyArgumentMethodChannel.EXPIRED_DATE, ""))
                
                // Additional parameters
                it.putExtra(KeyIntentConstantsNFC.CHALLENGE_CODE, json.optString(KeyArgumentMethodChannel.CHALLENGE_CODE, ""))
                it.putExtra(KeyIntentConstantsNFC.IS_ENABLE_CHECK_CHIP_CLONE, json.optBoolean(KeyArgumentMethodChannel.IS_ENABLE_CHECK_CHIP_CLONE, false))
                it.putExtra(KeyIntentConstantsNFC.IS_ENABLE_WATERMARK, json.optBoolean(KeyArgumentMethodChannel.IS_ENABLE_WATER_MARK, false))
                it.putExtra(KeyIntentConstantsNFC.IS_ENABLE_ADD_IDCHECK_DATA, json.optBoolean(KeyArgumentMethodChannel.IS_ENABLE_ADD_ID_CHECK_DATA, false))
                it.putExtra(KeyIntentConstantsNFC.IS_ENABLE_UPLOAD_DG, json.optBoolean(KeyArgumentMethodChannel.IS_ENABLE_UPLOAD_DG, false))
                 it.putExtra(KeyIntentConstantsNFC.PUBLIC_KEY, json.optString(KeyArgumentMethodChannel.PUBLIC_KEY, ""))
                it.putExtra(KeyIntentConstantsNFC.IS_ENABLE_ENCRYPT, json.optBoolean(KeyArgumentMethodChannel.IS_ENABLE_ENCRYPT, false))
                it.putExtra(KeyIntentConstantsNFC.MODE_UPLOAD_FILE, json.optString(KeyArgumentMethodChannel.MODE_UPLOAD_FILE, ""))
                it.putExtra(KeyIntentConstantsNFC.FLOW_NFC, json.optString(KeyArgumentMethodChannel.FLOW_NFC, ""))
                it.putExtra(KeyIntentConstantsNFC.NUMBER_TIMES_RETRY_SCAN_NFC, json.optInt(KeyArgumentMethodChannel.NUMBER_TIMES_RETRY_SCAN_NFC, 3))
                it.putExtra(KeyIntentConstantsNFC.URL_UPLOAD_IMAGE, json.optString(KeyArgumentMethodChannel.URL_UPLOAD_IMAGE, ""))
                it.putExtra(KeyIntentConstantsNFC.URL_UPLOAD_DATA_NFC, json.optString(KeyArgumentMethodChannel.URL_UPLOAD_DATA_NFC, ""))
                it.putExtra(KeyIntentConstantsNFC.URL_UPLOAD_LOG_NFC, json.optString(KeyArgumentMethodChannel.URL_UPLOAD_LOG_SDK, ""))
                it.putExtra(KeyIntentConstantsNFC.URL_POSTCODE_MATCHING, json.optString(KeyArgumentMethodChannel.URL_POSTCODE_MATCHING, ""))
                it.putExtra(KeyIntentConstantsNFC.TRANSACTION_ID, json.optString(KeyArgumentMethodChannel.TRANSACTION_ID, ""))
                it.putExtra(KeyIntentConstantsNFC.TRANSACTION_PARTNER_ID, json.optString(KeyArgumentMethodChannel.TRANSACTION_PARTNER_ID, ""))
                it.putExtra(KeyIntentConstantsNFC.TRANSACTION_PARTNER_ID_UPLOAD_NFC, json.optString(KeyArgumentMethodChannel.TRANSACTION_PARTNER_ID_UPLOAD_NFC, ""))
                it.putExtra(KeyIntentConstantsNFC.TRANSACTION_PARTNER_ID_RECENT_LOCATION, json.optString(KeyArgumentMethodChannel.TRANSACTION_PARTNER_ID_RECENT_LOCATION, ""))
                it.putExtra(KeyIntentConstantsNFC.TRANSACTION_PARTNER_ID_ORIGINAL_LOCATION, json.optString(KeyArgumentMethodChannel.TRANSACTION_PARTNER_ID_ORIGINAL_LOCATION, ""))
            }
        }

        private fun mapLanguage(value: String?): SDKEnumNFC.LanguageEnum {
            return when (value?.lowercase()) {
                "icnfc_en" -> SDKEnumNFC.LanguageEnum.ENGLISH
                else -> SDKEnumNFC.LanguageEnum.VIETNAMESE
            }
        }
    }
    // The MethodChannel that will the communication between Flutter and native Android
    //
    // This local reference serves to register the plugin with the Flutter Engine and unregister it
    // when the Flutter Engine is detached from the Activity
    private lateinit var channel: MethodChannel
    private var result: Result? = null
    private var binding: ActivityPluginBinding? = null

     // Hàm helper để chuyển JSONObject thành Map
    fun toMap(jsonObject: JSONObject): Map<String, Any> {
        val map = HashMap<String, Any>()
        val keys = jsonObject.keys()
        while (keys.hasNext()) {
            val key = keys.next()
            val value = jsonObject.get(key)
            when (value) {
                is JSONObject -> map[key] = toMap(value)
                is JSONArray -> map[key] = toList(value)
                else -> map[key] = value
            }
        }
        return map
    }

    // Hàm helper để chuyển JSONArray thành List
    fun toList(jsonArray: JSONArray): List<Any> {
        val list = ArrayList<Any>()
        for (i in 0 until jsonArray.length()) {
            val value = jsonArray.get(i)
            when (value) {
                is JSONObject -> list.add(toMap(value))
                is JSONArray -> list.add(toList(value))
                else -> list.add(value)
            }
        }
        return list
    }

    override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, CHANNEL)
        channel.setMethodCallHandler(this)
    }

    override fun onMethodCall(
        call: MethodCall,
        result: Result
    ) {
        val binding = this.binding
        if (binding == null) {
            result.error("NO_ACTIVITY", "Activity is not available", null)
            return
        }
        
        if (this.result != null) {
            result.error("ALREADY_ACTIVE", "A request is already being processed", null)
            return
        }
        
        val activity = binding.activity
        this.result = result

        val json = parseJsonFromArgs(call)
        val (intent, requestCode) = when (call.method) {
            "NFC_QR_CODE" -> navigateToNfcQrCode(activity, json) to NFC_REQUEST_CODE
            "NFC_MRZ_CODE" -> navigateTo_MRZ_NFC(activity, json) to NFC_REQUEST_CODE
            "NFC_ONLY_UI" -> navigateToOnlyNFC(activity, json) to NFC_REQUEST_CODE
            "NFC_ONLY_WITHOUT_UI" -> Intent(activity, NfcTransparentActivity::class.java).also {
                it.putExtra(
                    NfcTransparentActivity.KEY_EXTRA_INFO_NFC, json.toString()
                )
            } to NFC_NO_GUIDE_REQUEST_CODE
            else -> {
                this.result = null
                result.notImplemented()
                null to null
            }
        }
        intent?.let { activity.startActivityForResult(it, requestCode ?: NFC_REQUEST_CODE) }
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }

    private val resultActivityListener = PluginRegistry.ActivityResultListener { requestCode, resultCode, data ->
        if (requestCode == NFC_REQUEST_CODE) {
            val pendingResult = this.result
            this.result = null
            
            if (pendingResult != null) {
                if (resultCode == RESULT_OK) {
                    if (data != null) {
                        println("FlutterPluginIcNfcPlugin: Nhận kết quả thành công")
                        var dataGroupResult = data.getStringExtra(KeyResultConstantsNFC.DATA_GROUPS_RESULT)
                        /**
                         * đường dẫn ảnh mặt trước trong thẻ chip lưu trong cache
                         * [KeyResultConstantsNFC.PATH_IMAGE_AVATAR]
                         */
                        val avatarPath = data.getStringExtra(KeyResultConstantsNFC.PATH_IMAGE_AVATAR)

                        /**
                         * chuỗi thông tin cua SDK
                         * [KeyResultConstantsNFC.CLIENT_SESSION_RESULT]
                         */
                        val clientSession =
                            data.getStringExtra(KeyResultConstantsNFC.CLIENT_SESSION_RESULT)

                        /**
                         * kết quả NFC
                         * [KeyResultConstantsNFC.DATA_NFC_RESULT]
                         */
                        val dataNfcResult = data.getStringExtra(KeyResultConstantsNFC.DATA_NFC_RESULT)

                        /**
                         * mã hash avatar
                         * [KeyResultConstantsNFC.HASH_IMAGE_AVATAR]
                         */
                        val hashAvatar = data.getStringExtra(KeyResultConstantsNFC.HASH_IMAGE_AVATAR)

                        /**
                         * chuỗi json string chứa thông tin post code của quê quán
                         * [KeyResultConstantsNFC.POST_CODE_ORIGINAL_LOCATION_RESULT]
                         */
                        val postCodeOriginalLocation =
                            data.getStringExtra(KeyResultConstantsNFC.POST_CODE_ORIGINAL_LOCATION_RESULT)

                        /**
                         * chuỗi json string chứa thông tin post code của nơi thường trú
                         * [KeyResultConstantsNFC.POST_CODE_RECENT_LOCATION_RESULT]
                         */
                        val postCodeRecentLocation =
                            data.getStringExtra(KeyResultConstantsNFC.POST_CODE_RECENT_LOCATION_RESULT)

                        /**
                         * kết quả check chip căn cước công dân
                         * [KeyResultConstantsNFC.CHECK_AUTH_CHIP_RESULT]
                         */
                        val checkAuthChipResult =
                            data.getStringExtra(KeyResultConstantsNFC.STATUS_CHIP_AUTHENTICATION)

                        /**
                         * kết quả quét QRCode căn cước công dân
                         * [KeyResultConstantsNFC.QR_CODE_RESULT_NFC]
                         */
                        val qrCodeResult = data.getStringExtra(KeyResultConstantsNFC.QR_CODE_RESULT)

                        pendingResult.success(
                            JSONObject().apply {
                                putSafe(KeyResultConstantsNFC.DATA_GROUPS_RESULT, dataGroupResult)
                                putSafe(KeyResultConstantsNFC.PATH_IMAGE_AVATAR, avatarPath)
                                putSafe(KeyResultConstantsNFC.CLIENT_SESSION_RESULT, clientSession)
                                putSafe(KeyResultConstantsNFC.DATA_NFC_RESULT, dataNfcResult)
                                putSafe(KeyResultConstantsNFC.HASH_IMAGE_AVATAR, hashAvatar)
                                putSafe(
                                    KeyResultConstantsNFC.POST_CODE_ORIGINAL_LOCATION_RESULT,
                                    postCodeOriginalLocation
                                )
                                putSafe(
                                    KeyResultConstantsNFC.POST_CODE_RECENT_LOCATION_RESULT,
                                    postCodeRecentLocation
                                )
                                putSafe(KeyResultConstantsNFC.STATUS_CHIP_AUTHENTICATION, checkAuthChipResult)
                            }.toString()
                        )
                    } else {
                        pendingResult.success(JSONObject().toString())
                    }
                } else {
                    pendingResult.error("CANCELED", "User canceled the operation", null)
                }
            }
        }
        else if (requestCode == NFC_NO_GUIDE_REQUEST_CODE) {
            val pendingResult = this.result
            this.result = null
            
            if (pendingResult != null) {
                if (resultCode == RESULT_OK) {
                    data?.let {
                        val resultStr = it.getStringExtra(NFC_RESULT)
                        val resultObj = Gson().fromJson(resultStr, NfcResult::class.java)
                        pendingResult.success(
                            JSONObject().apply {
                                putSafe(KeyResultConstantsNFC.CLIENT_SESSION_RESULT, resultObj.clientSessionNfc)
                                putSafe(KeyResultConstantsNFC.DATA_NFC_RESULT, resultObj.logNfcResult)
                                putSafe(
                                    KeyResultConstantsNFC.POST_CODE_ORIGINAL_LOCATION_RESULT,
                                    resultObj.postCodeOriginalLocationResult
                                )
                                putSafe(
                                    KeyResultConstantsNFC.POST_CODE_RECENT_LOCATION_RESULT,
                                    resultObj.postCodeRecentLocationResult
                                )
                                putSafe(KeyResultConstantsNFC.STATUS_CHIP_AUTHENTICATION, resultObj.statusChipAuthentication)
                            }.toString()
                        )
                    } ?: run {
                        pendingResult.success(JSONObject().toString())
                    }
                } else {
                    pendingResult.error("CANCELED", "User canceled the operation", null)
                }
            }
        }
        true
    }

     // MARK: - QR and NFC
   // Thực hiện quét mã QR và đọc thông tin thẻ Căn cước NFC
   private fun navigateToNfcQrCode(ctx: Context, json: JSONObject): Intent {
      return Intent(ctx, VnptScanNFCActivity::class.java).also {
         /**
          * Truyền access token chứa bearer
          */
         it.putExtra(KeyIntentConstantsNFC.ACCESS_TOKEN, json.optString(KeyArgumentMethodChannel.ACCESS_TOKEN, ""))
         /**
          * Truyền token id
          */
        it.putExtra(KeyIntentConstantsNFC.TOKEN_ID, json.optString(KeyArgumentMethodChannel.TOKEN_ID, ""))
         /**
          * Truyền token key
          */
         it.putExtra(KeyIntentConstantsNFC.TOKEN_KEY, json.optString(KeyArgumentMethodChannel.TOKEN_KEY, ""))
         /**
          * Truyền access token ekyc chứa bearer
          */
         it.putExtra(KeyIntentConstantsNFC.ACCESS_TOKEN_EKYC, json.optString(KeyArgumentMethodChannel.ACCESS_TOKEN_EKYC, ""))
         /**
          * Truyền token id ekyc
          */
         it.putExtra(KeyIntentConstantsNFC.TOKEN_ID_EKYC, json.optString(KeyArgumentMethodChannel.TOKEN_ID_EKYC, ""))
         /**
          * Truyền token key ekyc
          */
         it.putExtra(KeyIntentConstantsNFC.TOKEN_KEY_EKYC, json.optString(KeyArgumentMethodChannel.TOKEN_KEY_EKYC, ""))
         /**
          * điều chỉnh ngôn ngữ tiếng việt
          *    - vi: tiếng việt
          *    - en: tiếng anh
          */
         it.putExtra(KeyIntentConstantsNFC.LANGUAGE_SDK, mapLanguage(json.optString(KeyArgumentMethodChannel.LANGUAGE_SDK)).value)
         /**
          * hiển thị màn hình hướng dẫn + hiển thị nút bỏ qua hướng dẫn
          * - mặc định luôn luôn hiển thị màn hình hướng dẫn
          *    - true: hiển thị nút bỏ qua
          *    - false: ko hiển thị nút bỏ qua
          */
         it.putExtra(KeyIntentConstantsNFC.IS_ENABLE_GOT_IT, true)
         /**
          * bật tính năng upload ảnh
          *    - true: bật tính năng
          *    - false: tắt tính năng
          */
         it.putExtra(KeyIntentConstantsNFC.IS_ENABLE_UPLOAD_IMAGE, true)
         /**
          * bật tính năng get Postcode
          *    - true: bật tính năng
          *    - false: tắt tính năng
          */
         it.putExtra(KeyIntentConstantsNFC.IS_ENABLE_POSTCODE_MATCHING, true)
         /**
          * truyền các giá trị đọc thẻ
          *    - nếu không truyền gì mặc định sẽ đọc tất cả (MRZ,Verify Document,Image Avatar)
          *    - giá trị truyền vào là 1 mảng int: nếu muốn đọc giá trị nào sẽ truyền
          *      giá trị đó vào mảng
          * eg: chỉ đọc thông tin MRZ
          *    intArrayOf(SDKEnumNFC.ReadingNFCTags.MRZInfo.value)
          */
         it.putExtra(
            KeyIntentConstantsNFC.READING_TAGS_NFC,
            intArrayOf(
               SDKEnumNFC.ReadingNFCTags.MRZInfo.value,
               SDKEnumNFC.ReadingNFCTags.VerifyDocumentInfo.value,
               SDKEnumNFC.ReadingNFCTags.ImageAvatarInfo.value
            )
         )

          it.putExtra(KeyIntentConstantsNFC.READER_CARD_MODE, SDKEnumNFC.ReaderCardMode.QRCODE.getValue())

         /**
          * set baseDomain="" => sử dụng mặc định là Product của VNPT
          */
         it.putExtra(KeyIntentConstantsNFC.BASE_URL, json.optString(KeyArgumentMethodChannel.BASE_URL, ""))
         
         // Additional parameters
         it.putExtra(KeyIntentConstantsNFC.IS_SHOW_TUTORIAL, json.optBoolean(KeyArgumentMethodChannel.IS_SHOW_TUTORIAL, false))
         it.putExtra(KeyIntentConstantsNFC.INPUT_CLIENT_SESSION, json.optString(KeyArgumentMethodChannel.INPUT_CLIENT_SESSION, ""))
         it.putExtra(KeyIntentConstantsNFC.CHALLENGE_CODE, json.optString(KeyArgumentMethodChannel.CHALLENGE_CODE, ""))
         it.putExtra(KeyIntentConstantsNFC.NAME_VIDEO_HELP_NFC, json.optString(KeyArgumentMethodChannel.NAME_VIDEO_HELP_NFC, ""))
         it.putExtra(KeyIntentConstantsNFC.IS_ENABLE_CHECK_CHIP_CLONE, json.optBoolean(KeyArgumentMethodChannel.IS_ENABLE_CHECK_CHIP_CLONE, false))
         it.putExtra(KeyIntentConstantsNFC.IS_ENABLE_WATERMARK, json.optBoolean(KeyArgumentMethodChannel.IS_ENABLE_WATER_MARK, false))
         it.putExtra(KeyIntentConstantsNFC.IS_ENABLE_ADD_IDCHECK_DATA, json.optBoolean(KeyArgumentMethodChannel.IS_ENABLE_ADD_ID_CHECK_DATA, false))
         it.putExtra(KeyIntentConstantsNFC.IS_ENABLE_UPLOAD_DG, json.optBoolean(KeyArgumentMethodChannel.IS_ENABLE_UPLOAD_DG, false))
         it.putExtra(KeyIntentConstantsNFC.PUBLIC_KEY, json.optString(KeyArgumentMethodChannel.PUBLIC_KEY, ""))
         it.putExtra(KeyIntentConstantsNFC.IS_ENABLE_ENCRYPT, json.optBoolean(KeyArgumentMethodChannel.IS_ENABLE_ENCRYPT, false))
         it.putExtra(KeyIntentConstantsNFC.MODE_UPLOAD_FILE, json.optString(KeyArgumentMethodChannel.MODE_UPLOAD_FILE, ""))
         it.putExtra(KeyIntentConstantsNFC.FLOW_NFC, json.optString(KeyArgumentMethodChannel.FLOW_NFC, ""))
         it.putExtra(KeyIntentConstantsNFC.NUMBER_TIMES_RETRY_SCAN_NFC, json.optInt(KeyArgumentMethodChannel.NUMBER_TIMES_RETRY_SCAN_NFC, 3))
         it.putExtra(KeyIntentConstantsNFC.URL_UPLOAD_IMAGE, json.optString(KeyArgumentMethodChannel.URL_UPLOAD_IMAGE, ""))
         it.putExtra(KeyIntentConstantsNFC.URL_UPLOAD_DATA_NFC, json.optString(KeyArgumentMethodChannel.URL_UPLOAD_DATA_NFC, ""))
         it.putExtra(KeyIntentConstantsNFC.URL_UPLOAD_LOG_NFC, json.optString(KeyArgumentMethodChannel.URL_UPLOAD_LOG_SDK, ""))
         it.putExtra(KeyIntentConstantsNFC.URL_POSTCODE_MATCHING, json.optString(KeyArgumentMethodChannel.URL_POSTCODE_MATCHING, ""))
         it.putExtra(KeyIntentConstantsNFC.TRANSACTION_ID, json.optString(KeyArgumentMethodChannel.TRANSACTION_ID, ""))
         it.putExtra(KeyIntentConstantsNFC.TRANSACTION_PARTNER_ID, json.optString(KeyArgumentMethodChannel.TRANSACTION_PARTNER_ID, ""))
         it.putExtra(KeyIntentConstantsNFC.TRANSACTION_PARTNER_ID_UPLOAD_NFC, json.optString(KeyArgumentMethodChannel.TRANSACTION_PARTNER_ID_UPLOAD_NFC, ""))
         it.putExtra(KeyIntentConstantsNFC.TRANSACTION_PARTNER_ID_RECENT_LOCATION, json.optString(KeyArgumentMethodChannel.TRANSACTION_PARTNER_ID_RECENT_LOCATION, ""))
         it.putExtra(KeyIntentConstantsNFC.TRANSACTION_PARTNER_ID_ORIGINAL_LOCATION, json.optString(KeyArgumentMethodChannel.TRANSACTION_PARTNER_ID_ORIGINAL_LOCATION, ""))
      }
   }

   // Thực hiện quét mã MRZ và đọc thông tin thẻ Căn cước NFC
   private fun navigateTo_MRZ_NFC(ctx: Context, json: JSONObject): Intent {
      return Intent(ctx, VnptScanNFCActivity::class.java).also {
          /**
           * Truyền access token chứa bearer
           */
          it.putExtra(KeyIntentConstantsNFC.ACCESS_TOKEN, json.optString(KeyArgumentMethodChannel.ACCESS_TOKEN, ""))
          /**
           * Truyền token id
           */
          it.putExtra(KeyIntentConstantsNFC.TOKEN_ID, json.optString(KeyArgumentMethodChannel.TOKEN_ID, ""))
          /**
           * Truyền token key
           */
          it.putExtra(KeyIntentConstantsNFC.TOKEN_KEY, json.optString(KeyArgumentMethodChannel.TOKEN_KEY, ""))
          /**
           * Truyền access token ekyc chứa bearer
           */
          it.putExtra(KeyIntentConstantsNFC.ACCESS_TOKEN_EKYC, json.optString(KeyArgumentMethodChannel.ACCESS_TOKEN_EKYC, ""))
          /**
           * Truyền token id ekyc
           */
          it.putExtra(KeyIntentConstantsNFC.TOKEN_ID_EKYC, json.optString(KeyArgumentMethodChannel.TOKEN_ID_EKYC, ""))
          /**
           * Truyền token key ekyc
           */
          it.putExtra(KeyIntentConstantsNFC.TOKEN_KEY_EKYC, json.optString(KeyArgumentMethodChannel.TOKEN_KEY_EKYC, ""))
          /**
           * điều chỉnh ngôn ngữ tiếng việt
           *    - vi: tiếng việt
           *    - en: tiếng anh
           */
          it.putExtra(KeyIntentConstantsNFC.LANGUAGE_SDK, SDKEnumNFC.LanguageEnum.VIETNAMESE.value)
          /**
           * hiển thị màn hình hướng dẫn + hiển thị nút bỏ qua hướng dẫn
           * - mặc định luôn luôn hiển thị màn hình hướng dẫn
           *    - true: hiển thị nút bỏ qua
           *    - false: ko hiển thị nút bỏ qua
           */
          it.putExtra(KeyIntentConstantsNFC.IS_ENABLE_GOT_IT, true)
          /**
           * bật tính năng upload ảnh
           *    - true: bật tính năng
           *    - false: tắt tính năng
           */
          it.putExtra(KeyIntentConstantsNFC.IS_ENABLE_UPLOAD_IMAGE, true)
          /**
           * bật tính năng get Postcode
           *    - true: bật tính năng
           *    - false: tắt tính năng
           */
          it.putExtra(KeyIntentConstantsNFC.IS_ENABLE_POSTCODE_MATCHING, true)
          /**
           * truyền các giá trị đọc thẻ
           *    - nếu không truyền gì mặc định sẽ đọc tất cả (MRZ,Verify Document,Image Avatar)
           *    - giá trị truyền vào là 1 mảng int: nếu muốn đọc giá trị nào sẽ truyền
           *      giá trị đó vào mảng
           * eg: chỉ đọc thông tin MRZ
           *    intArrayOf(SDKEnumNFC.ReadingNFCTags.MRZInfo.value)
           */
          it.putExtra(
              KeyIntentConstantsNFC.READING_TAGS_NFC,
              intArrayOf(
                  SDKEnumNFC.ReadingNFCTags.MRZInfo.value,
                  SDKEnumNFC.ReadingNFCTags.VerifyDocumentInfo.value,
                  SDKEnumNFC.ReadingNFCTags.ImageAvatarInfo.value
              )
          )
          /**
           * Truyền chế độ đọc thẻ
           */
          it.putExtra(KeyIntentConstantsNFC.READER_CARD_MODE, SDKEnumNFC.ReaderCardMode.MRZ_CODE.getValue())
      }
   }

   private fun parseJsonFromArgs(call: MethodCall): JSONObject {
      return try {
         @Suppress("UNCHECKED_CAST")
         (JSONObject(call.arguments as Map<String, Any>))
      } catch (e: Exception) {
         JSONObject(mapOf<String, Any>())
      }
   }

   /**
    * put value to [JSONObject] with null-safety
    */
   private fun JSONObject.putSafe(key: String, value: String?) {
      value?.let { put(key, JsonUtil.prettify(it)) }
   }

    override fun onAttachedToActivity(binding: ActivityPluginBinding) {
        this.binding = binding
        binding.addActivityResultListener(resultActivityListener)
    }

    override fun onDetachedFromActivityForConfigChanges() {
    }

    override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
    }

    override fun onDetachedFromActivity() {
        binding?.removeActivityResultListener(resultActivityListener)
        binding = null
    }
}
