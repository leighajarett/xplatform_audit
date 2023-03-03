// Copyright 2016 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import UIKit
import Flutter
import SwiftUI

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    var showSwiftUI = false
    var controlKey: String?
    
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
        let overlayChannel = FlutterMethodChannel(name: "overlay_ios.flutter.io/overlay",
                                                  binaryMessenger: controller.binaryMessenger)
        overlayChannel.setMethodCallHandler({
            [weak self] (call: FlutterMethodCall, result: FlutterResult) -> Void in
            // This method is invoked on the UI thread.
            guard call.method == "switchChanged" else {
                result(FlutterMethodNotImplemented)
                return
            }
            self?.switchChanged(call: call, result: result)
        })
        
        GeneratedPluginRegistrant.register(with: self)
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
    
    
    
    private func switchChanged(call: FlutterMethodCall, result: FlutterResult) {
        print("I am here")
        guard let args = call.arguments as? [String : Any] else {return}
        showSwiftUI = args["show_swiftui"] as! Bool
        controlKey = args["component"] as! String?
        
        let controller : OverlayFlutterViewController = window?.rootViewController as! OverlayFlutterViewController
        // Call the method on OverlayFlutterViewController
        controller.updateView(show: showSwiftUI, control: controlKey)
    }
}

