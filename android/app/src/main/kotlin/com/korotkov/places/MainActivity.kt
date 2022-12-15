package com.korotkov.places

import com.yandex.mapkit.MapKitFactory
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine

class MainActivity : FlutterActivity() {
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
//        MapKitFactory.setLocale("ru_RU")
        MapKitFactory.setApiKey("c9f03f5e-2c33-4c6b-bc93-6455633e8b69")
        super.configureFlutterEngine(flutterEngine)
    }
}
