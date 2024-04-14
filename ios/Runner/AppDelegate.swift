import UIKit
import Flutter
import CoreMotion

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    let METHOD_CHANNEL_NAME = "com.example.pressureSensorApp/method"
    let EVENT_CHANNEL_NAME = "com.example.pressureSensorApp/event"
    
    let pressureStreamHandler = PressureStreamHandler()
      
    let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
      
    let methodChannel = FlutterMethodChannel(
        name: METHOD_CHANNEL_NAME,
        binaryMessenger: controller.binaryMessenger
    )
      
    methodChannel.setMethodCallHandler({
      (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
      switch call.method {
        case "isSensorAvailable":
          result(CMAltimeter.isRelativeAltitudeAvailable())
          break;
        default:
          result(FlutterMethodNotImplemented)
      }
    })
      
    let eventChannel = FlutterEventChannel(
        name: EVENT_CHANNEL_NAME,
        binaryMessenger: controller.binaryMessenger
    )
      
    eventChannel.setStreamHandler(
        pressureStreamHandler
    )

    GeneratedPluginRegistrant.register(with: self)
    return super.application(
        application,
        didFinishLaunchingWithOptions: launchOptions
    )
  }
}
