//
//  CircularProgressBarView.swift
//  NexdhaPay
//
//  Created by Nexdha on 20/09/22.
//

import Foundation
import UIKit

class ProgressBar: UIView {
    
    /*   @IBInspectable public var backgroundCircleColor: UIColor = UIColor.lightGray
     @IBInspectable public var startGradientColor: UIColor = UIColor.red
     @IBInspectable public var endGradientColor: UIColor = UIColor.orange
     @IBInspectable public var textColor: UIColor = UIColor.white
     
     
     private var backgroundLayer: CAShapeLayer!
     private var foregroundLayer: CAShapeLayer!
     private var textLayer: CATextLayer!
     private var gradientLayer: CAGradientLayer!
     
     
     public var progress : CGFloat = 0{
     didSet{
     didProgressUpdated()
     }
     }
     
     
     override func draw(_ rect: CGRect){
     
     
     guard layer.sublayers == nil else{
     return
     }
     
     let width = rect.width
     let height = rect.height
     
     let lineWidth = 0.1 * min(width, height)
     
     /*  let center = CGPoint(x :width / 2, y: height/2)
      let radius = (min(width,height) - lineWidth)/2
      
      let startAngle = -CGFloat.pi / 2
      let endAngle = startAngle + 2 * CGFloat.pi*/
     
     
     //   let circularPath = UIBezierPath (arcCenter: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
     
     
     backgroundLayer = createCircularLayer(rect: rect, strokeColor: backgroundCircleColor.cgColor, fillColor: UIColor.clear.cgColor, lineWidth: lineWidth)
     
     
     foregroundLayer = createCircularLayer(rect: rect, strokeColor: UIColor.red.cgColor, fillColor: UIColor.clear.cgColor, lineWidth: lineWidth)
     
     gradientLayer = CAGradientLayer()
     gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
     gradientLayer.endPoint =  CGPoint(x: 0.5, y: 1.0)
     
     
     gradientLayer.colors = [startGradientColor.cgColor, endGradientColor.cgColor]
     gradientLayer.frame = rect
     gradientLayer.mask = foregroundLayer
     
     textLayer = createTextlayer(rect: rect, textColor: textColor.cgColor)
     
     /*   backgroundLayer = CAShapeLayer()
      backgroundLayer.path = circularPath.cgPath
      
      
      backgroundLayer.strokeColor = UIColor.lightGray.cgColor
      backgroundLayer.fillColor =  UIColor.clear.cgColor
      backgroundLayer.lineWidth = lineWidth
      backgroundLayer.lineCap = .round
      
      foregroundLayer = CAShapeLayer()
      
      foregroundLayer.path = circularPath.cgPath
      
      foregroundLayer.strokeColor = UIColor.red.cgColor
      foregroundLayer.fillColor = UIColor.clear.cgColor
      foregroundLayer.lineWidth = lineWidth
      foregroundLayer.lineCap = .round
      
      
      foregroundLayer.strokeEnd = 0.3 */
     
     layer.addSublayer(backgroundLayer)
     layer.addSublayer(foregroundLayer)
     layer.addSublayer(textLayer)
     
     }
     
     
     
     private func createCircularLayer (rect: CGRect , strokeColor: CGColor, fillColor :CGColor ,lineWidth: CGFloat) -> CAShapeLayer{
     
     let width = rect.width
     let height = rect.height
     
     //    let lineWidth = 0.1 * min(width, height)
     
     let center = CGPoint(x :width / 2, y: height/2)
     let radius = (min(width,height) - lineWidth)/2
     
     let startAngle = -CGFloat.pi / 2
     let endAngle = startAngle + 2 * CGFloat.pi
     
     let circularPath = UIBezierPath (arcCenter: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
     
     
     let shapeLayer = CAShapeLayer()
     shapeLayer.path = circularPath.cgPath
     
     
     shapeLayer.strokeColor = strokeColor
     shapeLayer.fillColor =  fillColor
     shapeLayer.lineWidth = lineWidth
     shapeLayer.lineCap = .round
     
     return shapeLayer
     
     }
     private func createTextlayer (rect: CGRect, textColor: CGColor) -> CATextLayer {
     
     let width = rect.width
     let height = rect.height
     
     
     let fontSize = min(width, height) / 4
     let offset = min(width, height) * 0.1
     
     
     let layer = CATextLayer()
     layer.string = "\(Int(progress * 100))"
     layer.backgroundColor = UIColor.clear.cgColor
     layer.foregroundColor = textColor
     layer.fontSize = fontSize
     layer.frame = CGRect(x: 0, y: (height - fontSize - offset) / 2, width: width , height: fontSize + offset)
     layer.alignmentMode = .center
     return layer
     }
     
     ////////////////////first check
     /*   private let labelLayer = CATextLayer()
      private let centerText = UILabel()
      private let foregroundLayer = CAShapeLayer()
      private let backgroundLayer = CAShapeLayer()
      
      //(-Double.pi / 2 - (2 * 25)) * -Double.pi
      private var pathCenter: CGPoint{ get{ return self.convert(self.center, from:self.superview) } }
      /// circle line width
      var lineWidth: Double  = 10
      /// Text inside the circle line
      var title : String = ""
      /// Text inside the circle line 2
      var subtitle : String = ""
      /// Circle foregroundColor
      var color: UIColor = UIColor.blue
      /// Circle backgroundColor
      var Backgroundcolor: UIColor = UIColor.white
      ///0.0 - 1.0
      var progress: Double = 0.5
      /// circle radius
      var radius: Int = 90
      override init(frame: CGRect) {
      super.init(frame: frame)
      }
      required init?(coder: NSCoder) {
      super.init(coder: coder)
      }
      private func createCircularPath() {
      print("R1")
      let startPoint = -CGFloat.pi / 2     ////CGFloat(-Double.pi / 2)
      let endPoint = startPoint + 2 * CGFloat.pi / 2 ///CGFloat(3.5 * Double.pi / 2)
      print(endPoint)
      let circularPath = UIBezierPath(arcCenter: CGPoint(x: frame.size.width / 2, y: frame.size.height / 2), radius: CGFloat(self.radius), startAngle: startPoint, endAngle: endPoint, clockwise: true)
      // Create background layer
      backgroundLayer.path = circularPath.cgPath
      backgroundLayer.fillColor = UIColor.clear.cgColor
      backgroundLayer.lineCap = .round
      backgroundLayer.lineWidth = self.lineWidth
      backgroundLayer.strokeEnd = 1.0
      backgroundLayer.strokeColor = Backgroundcolor.cgColor
      layer.addSublayer(backgroundLayer)
      // Create foreground layer
      foregroundLayer.path = circularPath.cgPath
      foregroundLayer.fillColor = UIColor.clear.cgColor
      foregroundLayer.lineCap = .round
      foregroundLayer.lineWidth = self.lineWidth
      foregroundLayer.strokeEnd = self.progress
      foregroundLayer.strokeColor = self.color.cgColor
      layer.addSublayer(foregroundLayer)
      }
      private func createLabels(){
      centerText.sizeToFit()
      centerText.textAlignment = .center
      centerText.numberOfLines = 2
      centerText.frame = self.frame
      // center textfield in view
      centerText.center = CGPoint(x: frame.size.width / 2.0, y: frame.size.height / 2.0)
      //Text Formatting
      let titleParagraphStyle = NSMutableParagraphStyle()
      titleParagraphStyle.alignment = .center
      let firstAttributes: [NSAttributedString.Key: Any] = [ .font: UIFont.systemFont(ofSize: 15.0), .foregroundColor: self.color, .paragraphStyle: titleParagraphStyle]
      let secondAttributes = [ NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15.0), NSAttributedString.Key.foregroundColor: self.color, .paragraphStyle: titleParagraphStyle]
      let firstString = NSMutableAttributedString(string: self.title, attributes: firstAttributes)
      let secondString = NSMutableAttributedString(string: self.subtitle, attributes: secondAttributes)//
      firstString.append(secondString)
      print("%%%%%%%%%%%%%%%")
      print(centerText)
      print("@@@@@@@@@@@@@@@")
      centerText.attributedText = firstString
      self.addSubview(centerText)
      }
      func setprogress(_ progress: Double = 0.5, _ color: UIColor = UIColor.blue, _ text: String = "", _ text2: String = ""){
      self.progress =  progress
      self.color = color
      self.title = text
      self.subtitle = "\n" + text2
      createLabels()
      createCircularPath()
      }
      
      func animate(_ value: Double, duration: TimeInterval = 2 ) {
      let circularProgressAnimation = CABasicAnimation(keyPath: "strokeEnd")
      circularProgressAnimation.duration = duration
      circularProgressAnimation.toValue = value
      circularProgressAnimation.fillMode = .forwards
      circularProgressAnimation.isRemovedOnCompletion = false
      foregroundLayer.add(circularProgressAnimation, forKey: "progressAnim")
      }*/
     ////////////////////first check
     
     private func didProgressUpdated(){
     textLayer?.string = "\(Int(progress * 100))"
     foregroundLayer?.strokeEnd = progress
     }
     
     
     }*/
    
     @IBInspectable public lazy var backgroundCircleColor: UIColor = UIColor.lightGray
     @IBInspectable public lazy var foregroundCircleColor: UIColor = UIColor.red
     @IBInspectable public lazy var startGradientColor: UIColor = UIColor.red
     @IBInspectable public lazy var endGradientColor: UIColor = UIColor.orange
     @IBInspectable public lazy var textColor: UIColor = UIColor.white
     private lazy var fillColor: UIColor = UIColor.clear
     private var backgroundLayer: CAShapeLayer!
     private var progressLayer: CAShapeLayer!
     private var textLayer: CATextLayer!
     public var progress: CGFloat = 0 {
       didSet {
         didProgressUpdated()
       }
     }
     public var animationDidStarted: (()->())?
     public var animationDidCanceled: (()->())?
     public var animationDidStopped: (()->())?
     private var timer: AppTimer?
     private var isAnimating = false
     private let tickInterval = 0.1
     
     public var maxDuration: Int = 3
     
     
     override func draw(_ rect: CGRect) {
       
       guard layer.sublayers == nil else {
         return
       }
       
       let lineWidth = min(frame.size.width, frame.size.height) * 0.1
       
       backgroundLayer = createCircularLayer(strokeColor: backgroundCircleColor.cgColor, fillColor: fillColor.cgColor, lineWidth: lineWidth)
       
       progressLayer = createCircularLayer(strokeColor: foregroundCircleColor.cgColor, fillColor: fillColor.cgColor, lineWidth: lineWidth)
       progressLayer.strokeEnd = progress
       
       let gradientLayer = CAGradientLayer()
       gradientLayer.startPoint = CGPoint(x: 1.0, y: 0.5)
       gradientLayer.endPoint = CGPoint(x: 0.0, y: 0.5)
       
       gradientLayer.colors = [startGradientColor.cgColor, endGradientColor.cgColor]
       gradientLayer.frame = self.bounds
       gradientLayer.mask = progressLayer
    
       textLayer = createTextLayer(textColor: textColor)
       
       layer.addSublayer(backgroundLayer)
       layer.addSublayer(gradientLayer)
       layer.addSublayer(textLayer)
     }
     
     private func createCircularLayer(strokeColor: CGColor, fillColor: CGColor, lineWidth: CGFloat) -> CAShapeLayer {
       
       let startAngle = -CGFloat.pi / 2
       let endAngle = 2 * CGFloat.pi + startAngle
       
       let width = frame.size.width
       let height = frame.size.height
       
       let center = CGPoint(x: width / 2, y: height / 2)
       let radius = (min(width, height) - lineWidth) / 2
       
       let circularPath = UIBezierPath(arcCenter: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
       
       let shapeLayer = CAShapeLayer()
       
       shapeLayer.path = circularPath.cgPath
       
       shapeLayer.strokeColor = strokeColor
       shapeLayer.lineWidth = lineWidth
       shapeLayer.fillColor = fillColor
       shapeLayer.lineCap = .round
       
       return shapeLayer
     }
     
     private func createTextLayer(textColor: UIColor) -> CATextLayer {
       
       let width = frame.size.width
       let height = frame.size.height
       
       let fontSize = min(width, height) / 4 - 5
       let offset = min(width, height) * 0.1
       
       let layer = CATextLayer()
       layer.string = "\(Int(progress * 100))"
       layer.backgroundColor = UIColor.clear.cgColor
       layer.foregroundColor = textColor.cgColor
       layer.fontSize = fontSize
       layer.frame = CGRect(x: 0, y: (height - fontSize - offset) / 2, width: width, height: height)
       layer.alignmentMode = .center
       
       return layer
     }
     
     private func didProgressUpdated() {
       
       textLayer?.string = "\(Int(progress * 100))"
       progressLayer?.strokeEnd = progress
     }
   }

   // Animation
   extension ProgressBar {
     
     func startAnimation(duration: TimeInterval) {
       
       print("Start animation")
       isAnimating = true
       
       progressLayer.removeAllAnimations()
       
       let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
       basicAnimation.duration = duration
       basicAnimation.toValue = progress
       
       basicAnimation.delegate = self
       
       timer = AppTimer(duration: maxDuration, tickInterval: tickInterval)
       
       timer?.timerFired = { [weak self] value in
         self?.textLayer.string = "\(value)"
       }
       
       timer?.timerStopped = { [weak self] in
         self?.textLayer.string = ""
       }
       
       timer?.timerCompleted = {}
       
       progressLayer.add(basicAnimation, forKey: "recording")
       timer?.start()
     }
     
     func stopAnimation() {
       timer?.stop()
       progressLayer.removeAllAnimations()
     }
     
   }

   extension ProgressBar: CAAnimationDelegate {
     
     func animationDidStart(_ anim: CAAnimation) {
       animationDidStarted?()
     }
     
     func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
       isAnimating = false
       flag ? animationDidStopped?() : animationDidCanceled?()
     }
     
       
}
