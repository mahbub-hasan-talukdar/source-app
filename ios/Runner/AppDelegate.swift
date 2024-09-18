// import UIKit
// import Flutter

// @main
// @objc class AppDelegate: FlutterAppDelegate {
//     private let CHANNEL = "com.example.source_app/navigate"

//     override func application(
//         _ application: UIApplication,
//         didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
//     ) -> Bool {
//         GeneratedPluginRegistrant.register(with: self)

//         let controller: FlutterViewController = window?.rootViewController as! FlutterViewController
//         let methodChannel = FlutterMethodChannel(name: CHANNEL, binaryMessenger: controller.binaryMessenger)

//         methodChannel.setMethodCallHandler { (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
//             if call.method == "openDestinationApp" {
//                 if let args = call.arguments as? [String: Any], let message = args["message"] as? String {
//                     self.openDestinationApp(message: message)
//                     result("Opened destination app with message: \(message)")
//                 } else {
//                     result(FlutterError(code: "INVALID_ARGUMENT", message: "Message not provided", details: nil))
//                 }
//             } else {
//                 result(FlutterMethodNotImplemented)
//             }
//         }


//         return super.application(application, didFinishLaunchingWithOptions: launchOptions)
//     }

//     private func openDestinationApp(message: String) {
//         let urlString = "example://destination_app?message=\(message)"
//         if let url = URL(string: urlString) {
//             if UIApplication.shared.canOpenURL(url) {
//                 UIApplication.shared.open(url, options: [:], completionHandler: nil)
//             }
//         }
//     }

// }

import UIKit
import Flutter
 
@main
@objc class AppDelegate: FlutterAppDelegate, ExampleHostApi {
 
    private let CHANNEL = "com.example.source_app/deep_link"
 
    // Implement the ExampleHostApi protocol (from Pigeon)
    func getHostLanguage() throws -> String {
        return "Swift"
    }
 
    func sendMessage(message: String) throws {
        // Handle the message sent from Flutter here
        print("Message received from Flutter: \(message)")
        openDestinationApp(message: message)  // Optionally open the destination app
    }
 
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        GeneratedPluginRegistrant.register(with: self)
 
        let controller: FlutterViewController = window?.rootViewController as! FlutterViewController
 
        // Set up Pigeon to handle messages from Flutter
        ExampleHostApiSetup.setUp(binaryMessenger: controller.binaryMessenger, api: self)
 
        // Set up the method channel for deep linking (as it was in your original code)
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