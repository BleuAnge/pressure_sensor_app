package com.example.pressure_sensor_app

import android.content.Context
import android.hardware.Sensor
import android.hardware.SensorManager
import android.os.Messenger
import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodChannel

class MainActivity: FlutterActivity() {
    private val METHOD_CHANNEL_NAME = "com.example.pressureSensorApp/method"
    private val EVENT_CHANNEL_NAME = "com.example.pressureSensorApp/event"

    private var methodChannel: MethodChannel? = null
    private lateinit var sensorManager : SensorManager
    private var eventChannel : EventChannel? = null
    private var pressureStreamHandler : StreamHandler? = null

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        //Initialize The Channels
        initChannels(
                this,
                flutterEngine.dartExecutor.binaryMessenger
        )
    }

    override fun onDestroy() {
        destroyChannels()
        super.onDestroy()
    }

    private fun initChannels(
            context: Context,
            messenger: BinaryMessenger
    ) {
        sensorManager = context
                .getSystemService(Context.SENSOR_SERVICE) as SensorManager
        methodChannel = MethodChannel(messenger, METHOD_CHANNEL_NAME)

        methodChannel!!.setMethodCallHandler {
            call , result ->
            when (call.method) {
                "isSensorAvailable" -> {
                    result.success(
                            sensorManager!!.getSensorList(
                                  Sensor.TYPE_PRESSURE
                            ).isNotEmpty()
                    )
                }
                else -> result.notImplemented()
            }
        }

        eventChannel = EventChannel(
                messenger,
                EVENT_CHANNEL_NAME
                )

        pressureStreamHandler = StreamHandler(
                sensorManager!!,
                Sensor.TYPE_PRESSURE
        )

        eventChannel!!.setStreamHandler(
                pressureStreamHandler
        )
    }

    private fun destroyChannels() {
        methodChannel!!.setMethodCallHandler(null)
        eventChannel!!.setStreamHandler(null)
    }

}
