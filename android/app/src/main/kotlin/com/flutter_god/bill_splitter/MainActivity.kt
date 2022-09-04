package com.flutter_god.bill_splitter


import android.os.Bundle
import io.flutter.embedding.android.FlutterActivity
import io.flutter.plugins.GeneratedPluginRegistrant

class MainActivity: FlutterActivity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
//        FacebookSdk.sdkInitialize(applicationContext)
        GeneratedPluginRegistrant.registerWith(this.flutterEngine!!)
    }
}
