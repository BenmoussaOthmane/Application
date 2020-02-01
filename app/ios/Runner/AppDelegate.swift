import UIKit
import Flutter
import Firebase
import GoogleMaps


@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
    GMSServices.provideAPIKey("AIzaSyDcGlwp1UaghdNbmq1AmyVWUwhWcUqJK3Y")
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

}
