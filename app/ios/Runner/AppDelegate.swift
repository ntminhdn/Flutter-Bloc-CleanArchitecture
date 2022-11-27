import UIKit
import Flutter
// import os.log

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
    // get secrets here!
    // let dartDefinesString = Bundle.main.object(forInfoDictionaryKey:"DartDefines") as! String
    // var dartDefinesDictionary = [String:String]()
    // for definedValue in dartDefinesString.components(separatedBy: ",") {
    //     let decoded = String(data: Data(base64Encoded: definedValue)!, encoding: .utf8)!
    //     let values = decoded.components(separatedBy: "=")
    //    dartDefinesDictionary[values[0]] = values[1]
    // }
    // if #available(iOS 14.0, *) {
    //     os_log("DartDefines = \(dartDefinesDictionary["API_KEY"]!) && \(dartDefinesDictionary["API_SECRET"]!)")
    // } else {
    //     NSLog("DartDefines = \(dartDefinesDictionary)")
    // }
    
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
