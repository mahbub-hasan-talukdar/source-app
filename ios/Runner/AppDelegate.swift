import UIKit
import Flutter

@main
@objc class AppDelegate: FlutterAppDelegate {
    private let CHANNEL = "com.example.source_app/navigate"

    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        GeneratedPluginRegistrant.register(with: self)

        let controller: FlutterViewController = window?.rootViewController as! FlutterViewController
        let methodChannel = FlutterMethodChannel(name: CHANNEL, binaryMessenger: controller.binaryMessenger)

        methodChannel.setMethodCallHandler { (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
            if call.method == "openDestinationApp" {
                if let args = call.arguments as? [String: Any], let message = args["message"] as? String {
                    self.openDestinationApp(message: message)
                    result("Opened destination app with message: \(message)")
                } else {
                    result(FlutterError(code: "INVALID_ARGUMENT", message: "Message not provided", details: nil))
                }
            } else {
                result(FlutterMethodNotImplemented)
            }
        }


        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }

    private func openDestinationApp(message: String) {
        let urlString = "example://destination_app?message=\(message)"
        if let url = URL(string: urlString) {
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
    }

}
