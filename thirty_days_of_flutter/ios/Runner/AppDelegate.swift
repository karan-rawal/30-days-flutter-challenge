import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?
  ) -> Bool {
    let controller: FlutterViewController = window.rootViewController as! FlutterViewController;
    let CHANNEL_NAME: String = "com.karanrawal.thirty_days_of_flutter/toast";
    let toastChannel = FlutterMethodChannel(name: CHANNEL_NAME, binaryMessenger: controller);
    
    toastChannel.setMethodCallHandler({
        (call: FlutterMethodCall, result: FlutterResult) -> Void in
        if (call.method == "showToast") {
            let args: [String : Any] = call.arguments as? [String : Any] ?? ["message": "No message"];
            let message: String = args["message"] as! String;
            let alertDisapperTimeInSeconds = 2.0
            let alert = UIAlertController(title: "You typed", message: message, preferredStyle: UIAlertControllerStyle.alert)
            controller.present(alert, animated: false, completion: nil)
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + alertDisapperTimeInSeconds) {
                alert.dismiss(animated: false)
            }
        } else {
            result(FlutterMethodNotImplemented);
        }
    });
    
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
