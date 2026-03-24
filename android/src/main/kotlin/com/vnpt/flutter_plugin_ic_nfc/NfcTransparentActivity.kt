package com.vnpt.flutter_plugin_ic_nfc

import android.app.Activity
import android.content.Intent
import android.os.Bundle
import android.view.View
import androidx.appcompat.app.AppCompatActivity
import androidx.core.view.WindowCompat
import com.google.gson.Gson
import com.vnptit.nfc.nfc_tool.NfcCallback
import com.vnptit.nfc.nfc_tool.NfcError
import com.vnptit.nfc.nfc_tool.NfcOptionNoGuide
import com.vnptit.nfc.nfc_tool.NfcResult
import com.vnptit.nfc.nfc_tool.NfcTool
import org.json.JSONObject
import java.util.concurrent.atomic.AtomicBoolean

class NfcTransparentActivity : AppCompatActivity() {

   companion object {
      const val KEY_EXTRA_INFO_NFC = "extra::NFC"
      private const val CHANNEL = "flutter.sdk.ic.nfc/integrate"
       private const val NFC_REQUEST_CODE = 11021
       const val NFC_RESULT = "nfc_result"
       const val NFC_ERROR = "nfc_error"
       const val NFC_CODE = "IC_NFC_CANCELLED"
       const val EKYC_REQUEST_CODE = 11022
       const val NFC_NO_GUIDE_REQUEST_CODE = 11023
       const val ERROR_NFC_CODE = "69"
   }

    private var nfcTool: NfcTool? = null
    private val isNFCFinished = AtomicBoolean(false)

   override fun onCreate(savedInstanceState: Bundle?) {
      super.onCreate(savedInstanceState)

      WindowCompat.setDecorFitsSystemWindows(window, false)
      setContentView(View(this))

      val jsonObject = JSONObject(intent.getStringExtra(KEY_EXTRA_INFO_NFC) ?: "{}")

      nfcTool = NfcTool(this)
      // clear previous session reader chip
      nfcTool?.clearReadChip()
      // start new session
      nfcTool?.startReadChip(
         NfcOptionNoGuide().setExtras(FlutterPluginIcNfcPlugin.navigateToOnlyNFC(this, jsonObject)),
         object : NfcCallback() {
             override fun onSuccess(result: NfcResult?) {
                 isNFCFinished.set(true)
                 val intent = Intent()
                 val gson = Gson()

                 val jsonString = if (result != null) {
                     gson.toJson(result)
                 } else {
                     "{}"
                 }

                 intent.putExtra(NFC_RESULT, jsonString)
                 setResult(RESULT_OK, intent)
                 finish()
             }

             override fun onError(message: NfcError?) {
                 isNFCFinished.set(true)
                 val intent = Intent()
                 val errorCode = "IC_NFC_HAS_ERROR"
                 val errorMessage = message?.name ?: ""

                 intent.putExtra(NFC_ERROR, errorCode)
                 intent.putExtra(NFC_CODE, errorMessage)
                 setResult(RESULT_CANCELED, intent)
                 finish()
             }
         }
      )
   }

    private fun dismiss() {
        val intent = Intent()
        val errorCode = "IC_NFC_CANCELLED"
        val errorMessage = "NFC operation cancelled by system (app backgrounded)"
        intent.putExtra(NFC_ERROR, errorCode)
        intent.putExtra(NFC_CODE, errorMessage)
        setResult(RESULT_CANCELED, intent)
        finish()
    }

    override fun onStop() {
        super.onStop()
        if (!isNFCFinished.get()) {
            dismiss()
        }
    }

   override fun onDestroy() {
      super.onDestroy()
      nfcTool?.clearReadChip()
   }
}