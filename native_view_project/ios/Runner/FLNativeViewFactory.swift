import Foundation
import Flutter
import UIKit

class FLNativeViewFactory: NSObject, FlutterPlatformViewFactory {
    private var messenger: FlutterBinaryMessenger
    
    init(_ messenger: FlutterBinaryMessenger) {
        self.messenger = messenger
        super.init()
    }

    func create(
        withFrame frame: CGRect,
        viewIdentifier viewId: Int64,
        arguments args: Any?
    ) -> FlutterPlatformView {
        return FLNativeView(
            frame: frame,
            viewIdentifier: viewId,
            arguments: args,
            binaryMessenger: messenger)
    }
}

class FLNativeView: NSObject, FlutterPlatformView {
    private var imageView: UIImageView?
    
    init(
        frame: CGRect,
        viewIdentifier viewId: Int64,
        arguments args: Any?,
        binaryMessenger messenger: FlutterBinaryMessenger?
    ) {
        imageView = UIImageView(frame: frame)
        super.init()
        // iOS views can be created here
        createNativeView()
    }
    
    deinit{
        imageView = nil
        imageView?.image = nil
    }
    
    func view() -> UIView {
        return imageView!
    }
    
    func createNativeView(){
        imageView?.contentMode = .scaleAspectFill
        imageView?.image = UIImage(named: "flutter_image")
        imageView?.frame = CGRect(x: 0, y: 0, width: 300, height: 210)
    }
}


