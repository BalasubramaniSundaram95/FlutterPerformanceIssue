import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
      
      let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
      
      weak var registrar = self.registrar(forPlugin: "native")
            let nativeFactory = FLNativeViewFactory(registrar!.messenger())
                    self.registrar(forPlugin: "<native>")!.register(nativeFactory,withId: "<native_view>")
      
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
