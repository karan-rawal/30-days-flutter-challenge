package com.karanrawal.thirty_days_of_flutter

import android.content.Context
import android.widget.Toast
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel

class ToastChannel {
    val methodCallHandler: MethodChannel.MethodCallHandler;
    private val context: Context;

    companion object {
        const val CHANNEL = "com.karanrawal.thirty_days_of_flutter/toast"
    }

    constructor(context: Context) {
        this.context = context
        methodCallHandler = MethodChannel.MethodCallHandler { methodCall, result ->
            run {
                if (methodCall.method == "showToast") {
                    showToastHandler(methodCall, context, result)
                } else {
                    result.notImplemented()
                }
            }
        }
    }

    private fun showToastHandler(methodCall: MethodCall, context: Context, result: MethodChannel.Result) {
        var message: String? = "No message provided"
        if (methodCall.hasArgument("message")) {
            message = methodCall.argument<String>("message")
        }
        Toast.makeText(context, message, Toast.LENGTH_SHORT).show()
        result.success(true)
    }
}