// Copyright 2016 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import SwiftUI


/// The initial `UIViewController` defined in `Main.storyboard` uses this class.
/// This class overlays a SwiftUI view on top of the Flutter application.
/// It also communicates with the Flutter code to signal when a new widget must be shown.
@available(iOS 14.0, *)
class OverlayFlutterViewController: FlutterViewController, FlutterStreamHandler, ObservableObject {
    var panGesture       = UIPanGestureRecognizer()
  lazy var swiftUIController: UIViewController =
    UIHostingController(rootView: OverlaySwiftUIView(controller: self))
  lazy var overlaySwiftUIView: OverlaySwiftUIView = OverlaySwiftUIView(controller: self)
  
  // The overlay's center point is assigned when self.view appears.
  var originalOverlayCenter: CGPoint = .zero
  
//   OverlaySwiftUIView listens to this var's publisher to
//   present the selected control.
//   Set control key when the toggle changes
   @Published var controlKey: String?
   @Published var showSwiftUI: Bool = false

  
    let disclaimerLabel: UILabel = UILabel()
    let xLabel: UILabel = UILabel()
    let yLabel: UILabel = UILabel()
    let alphaLabel: UILabel = UILabel()
    let resetButton: UIButton = UIButton()
    let xSlider: UISlider = UISlider()
    let ySlider: UISlider = UISlider()
    let alphaSlider: UISlider = UISlider()
    lazy var slidersStackViewHeader: UIStackView = UIStackView(arrangedSubviews: [disclaimerLabel, resetButton])
    lazy var slidersStackViewFirstRow: UIStackView = UIStackView(arrangedSubviews: [xLabel, xSlider])
    lazy var slidersStackViewSecondRow: UIStackView = UIStackView(arrangedSubviews: [yLabel, ySlider])
    lazy var slidersStackViewThirdRow: UIStackView = UIStackView(arrangedSubviews: [alphaLabel, alphaSlider])
    lazy var slidersStackView: UIStackView = UIStackView(arrangedSubviews: [slidersStackViewHeader,
                                       slidersStackViewFirstRow,
                                       slidersStackViewSecondRow,
                                       slidersStackViewThirdRow])
  
  // MARK: App cycle methods
  
   override func viewDidLoad() {
      super.viewDidLoad()
      createControls()
      if(!showSwiftUI){slidersStackView.isHidden = true}
    }
    
    
    func createControls() {
        disclaimerLabel.text = "SwiftUI Modifiers"
        xLabel.text = "x  "
        yLabel.text = "y  "
        alphaLabel.text = "a  "
        
        resetButton.setTitle("Reset", for: .normal)
        resetButton.setTitleColor(.systemBlue, for: .normal)
        resetButton.addTarget(self, action: #selector(resetButtonTapped), for: .touchUpInside)
        
        slidersStackViewHeader.axis = .horizontal
        slidersStackViewHeader.spacing = UIStackView.spacingUseSystem

        xSlider.minimumValue = -200
        xSlider.maximumValue = 200
        xSlider.isContinuous = true
        xSlider.addTarget(self, action: #selector(xSliderChanged), for: .valueChanged)
        
        ySlider.minimumValue = -200
        ySlider.maximumValue = 200
        ySlider.isContinuous = true
        ySlider.addTarget(self, action: #selector(ySliderChanged), for: .valueChanged)
        
        alphaSlider.minimumValue = 0
        alphaSlider.maximumValue = 1
        alphaSlider.value = 1
        alphaSlider.isContinuous = true
        alphaSlider.addTarget(self, action: #selector(alphaSliderChanged), for: .valueChanged)
            
        slidersStackView.axis = .vertical
        slidersStackView.distribution = .fillEqually
        slidersStackView.center = self.view.center
        slidersStackView.backgroundColor = UIColor.lightGray.withAlphaComponent(0.3)
        slidersStackView.isLayoutMarginsRelativeArrangement = true
        slidersStackView.directionalLayoutMargins =
          NSDirectionalEdgeInsets(top: 10, leading: 20, bottom: 0, trailing: 20)
        slidersStackView.spacing = UIStackView.spacingUseSystem
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:)))
        slidersStackView.addGestureRecognizer(panGesture)
    }
  
    @objc func handlePan(_ gestureRecognizer: UIPanGestureRecognizer) {
        let translation = gestureRecognizer.translation(in: view)
        gestureRecognizer.setTranslation(.zero, in: view)

        let newCenter = CGPoint(x: slidersStackView.center.x + translation.x, y: slidersStackView.center.y + translation.y)
        slidersStackView.center = newCenter
    }
    
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)

    self.addChild(swiftUIController)
    swiftUIController.view.frame = self.view.bounds
    originalOverlayCenter = swiftUIController.view.center
    swiftUIController.didMove(toParent: self)
    self.view.addSubview(swiftUIController.view)
    
    if(!showSwiftUI){swiftUIController.view.isHidden = true}
    swiftUIController.view.backgroundColor = .clear

    self.view.addSubview(slidersStackView)
    let stackViewHeight: CGFloat = 150.0
    slidersStackView.frame = CGRect(x: 0,
                                    y: self.view.bounds.height - stackViewHeight - 25,
                                    width: self.view.bounds.width,
                                    height: stackViewHeight)
    

  }
    
    func updateView(show: Bool, control: String?) {
        print("I am updating the view")
        controlKey = control
        showSwiftUI = show
        if(!showSwiftUI){
            swiftUIController.view.isHidden = true
            slidersStackView.isHidden = true
        }
        else{
            swiftUIController.view.isHidden = false
            slidersStackView.isHidden = false
        }
    }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    
    // Reset view upon disappearance
    self.view.subviews.forEach { $0.removeFromSuperview() }
    self.children.forEach { $0.removeFromParent() }
  }
  
  // MARK: UI Target Actions
  
  @objc func resetButtonTapped() {
    xSlider.setValue(0, animated: true)
    ySlider.setValue(0, animated: true)
    alphaSlider.setValue(1, animated: true)
    
    xSliderChanged()
    ySliderChanged()
    alphaSliderChanged()
  }
  
  @objc func xSliderChanged() {
    swiftUIController.view.center.x = originalOverlayCenter.x + CGFloat(xSlider.value)
  }
  
  @objc func ySliderChanged() {
    swiftUIController.view.center.y = originalOverlayCenter.y + CGFloat(ySlider.value)
  }
  
  @objc func alphaSliderChanged() {
    swiftUIController.view.alpha = CGFloat(alphaSlider.value)
  }
  
  // MARK: Flutter Stream Handler
  
  func onListen(withArguments arguments: Any?,
                eventSink events: @escaping FlutterEventSink) -> FlutterError? {
//    eventSink = events
    return nil
  }

  func onCancel(withArguments arguments: Any?) -> FlutterError? {
    nil
  }
  
  // MARK: UIActivity touch functions
  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    if !fallsInStackView(touches: touches, event: event) {
      super.touchesBegan(touches, with: event)
    }
  }
  
  override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
    if !fallsInStackView(touches: touches, event: event) {
      super.touchesMoved(touches, with: event)
    }
  }
  
  override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
    if !fallsInStackView(touches: touches, event: event) {
      super.touchesCancelled(touches, with: event)
    }
  }

  override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
    if !fallsInStackView(touches: touches, event: event) {
      super.touchesEnded(touches, with: event)
    }
  }
  
  // Returns whether one of the touches are within the bounds
  // of the slidersStackView.
  func fallsInStackView(touches: Set<UITouch>, event: UIEvent?) -> Bool {
    !touches.filter {
      self.slidersStackView.point(inside: $0.location(in: self.slidersStackView), with: event)
    }.isEmpty
  }
}
