import Flutter
import UIKit
import SwiftDate

public class SwiftSamplePluginFlutterPlugin: NSObject, FlutterPlugin {
    // channel to connect with flutter side
    let channel : FlutterMethodChannel
    
    public static func register(with registrar: FlutterPluginRegistrar) {
        //set name for channel, this name must equal to method channel name in flutter side
        let channel = FlutterMethodChannel(name: "sample_plugin_flutter", binaryMessenger: registrar.messenger())
        // call init function to set method channel
        let instance = SwiftSamplePluginFlutterPlugin(channel: channel)
        registrar.addMethodCallDelegate(instance, channel: channel)
        // register functions override from applicationDelegate
        registrar.addApplicationDelegate(instance)
    }

    init(channel: FlutterMethodChannel) {
        self.channel = channel
    }
    
    // handle method call from flutter and return to flutter side
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
        case "getPlatformVersion":
            result("iOS " + UIDevice.current.systemVersion)
        case "isToday":
            isToday(call, result)
        default:
            result(nil)
        }
    }
    
    private func isToday(_ call: FlutterMethodCall,_ result: @escaping FlutterResult) {
        let arguments = call.arguments as! Dictionary<String, Any>
        let dateTime = arguments["dateTime"] as! String;
        // Convert to local
        let localDate = dateTime.toDate(nil, region: Region.current)
        // Check isToday
        let checkToday = localDate?.isToday
        result(checkToday)
    }



    ///
    /// function call override with register function on AppDelegate 
    ///
    
    public func applicationDidBecomeActive(_ application: UIApplication) {
        debugPrint("applicationDidBecomeActive")
    }
    
    public func applicationWillTerminate(_ application: UIApplication) {
        debugPrint("applicationWillTerminate")
    }
    
    public func applicationWillResignActive(_ application: UIApplication) {
        debugPrint("applicationWillResignActive")
    }
    
    public func applicationDidEnterBackground(_ application: UIApplication) {
        debugPrint("applicationDidEnterBackground")

        // ---------- call function pass to flutter side --------
        channel.invokeMethod("method_from_native", arguments: [
            "id": 1,
            "body": "test"
        ])
        print("start call channel from native");
    }
    
    public func applicationWillEnterForeground(_ application: UIApplication) {
        print("applicationWillEnterForeground")
    }
    
    public func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        print("AppsFlyerLib.shared().registerUninstall(deviceToken)")
    }
}
