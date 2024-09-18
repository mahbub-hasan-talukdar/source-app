package com.example.source_app

import android.content.Intent
import android.net.Uri
import android.os.Bundle
import io.flutter.embedding.android.FlutterActivity
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    private val CHANNEL = "com.example.source_app/navigate"

    override fun configureFlutterEngine(flutterEngine: io.flutter.embedding.engine.FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            if (call.method == "openDestinationApp") {
                val message = call.argument<String>("message") ?: "No message"
                openDestinationApp(message)
                result.success("Opened destination app with message: $message")
            } else {
                result.notImplemented()
            }
        }
    }

    private fun openDestinationApp(message: String) {
        val uri = Uri.parse("example://destination?message=$message")
        val intent = Intent(Intent.ACTION_VIEW, uri)
        intent.flags = Intent.FLAG_ACTIVITY_NEW_TASK
        startActivity(intent)
    }
}
