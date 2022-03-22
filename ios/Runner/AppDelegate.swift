import UIKit
import Flutter
import GoogleMaps
@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
    

GMSServices.provideAPIKey("AIzaSyBJRCrRpTTvsRW1bDI2KsuY1PyLgW7N1YU")
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
