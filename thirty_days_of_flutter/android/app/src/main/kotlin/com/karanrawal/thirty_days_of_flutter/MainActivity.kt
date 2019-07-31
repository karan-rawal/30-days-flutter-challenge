package com.karanrawal.thirty_days_of_flutter

import android.os.Bundle

import io.flutter.app.FlutterActivity
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.GeneratedPluginRegistrant

class MainActivity : FlutterActivity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        GeneratedPluginRegistrant.registerWith(this)

        val toastChannel = ToastChannel(flutterView.context)
        MethodChannel(flutterView, ToastChannel.CHANNEL).setMethodCallHandler(toastChannel.methodCallHandler);
    }
}
