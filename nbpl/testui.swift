//
//  testui.swift
//  nbpl
//
//  Created by Nexdha on 04/07/22.
//

import Foundation
import UIKit
import Alamofire
import AVFoundation
import SwiftyJSON
import DynamicBottomSheet
import Then
import BLTNBoard

class testui: UIViewController , UITextFieldDelegate, UIGestureRecognizerDelegate {

    @IBOutlet weak var BTNS: GradientButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Initialize gradient layer.
        
        
        
/*
        let gradientLayer: CAGradientLayer = CAGradientLayer()

        // Set frame of gradient layer.
        gradientLayer.frame = u.bounds
        u.clipsToBounds = true
        // Color at the top of the gradient.
        let topColor: CGColor = UIColor(red: 0.14, green: 0.14, blue: 0.20, alpha: 1.00).cgColor
        // Color at the middle of the gradient.
        let middleColor: CGColor = UIColor(red: 0.31, green: 0.31, blue: 0.36, alpha: 1.00).cgColor

        // Color at the bottom of the gradient.
        let bottomColor: CGColor = UIColor(red: 0.52, green: 0.52, blue: 0.52, alpha: 1.00).cgColor
        // Set colors.
        gradientLayer.colors = [topColor, middleColor, bottomColor]

        // Set start point.
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)

        // Set end point.
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        u.layer.cornerRadius = 25
      //  layouts.translatesAutoresizingMaskIntoConstraints = false

        // Insert gradient layer into view's layer heirarchy.
        u.layer.insertSublayer(gradientLayer, at: 0)*/
     //   BTNS.layer.cornerRadius = 20
//BTNS.new_grad(colors: [UIColor.magenta.cgColor, UIColor(red: 0.24, green: 0.08, blue: 0.58, alpha: 1.00).cgColor])
     //  BTNS.clipsToBounds = true
        //btns.frame = btns.bounds
        
        
    /*    self.BTNS.layer.cornerRadius = self.BTNS.frame.height/3
         self.BTNS.clipsToBounds = true

         let gradient = CAGradientLayer()
         gradient.frame =  CGRect(origin: CGPoint.zero, size: self.BTNS.frame.size)
         gradient.colors =  [UIColor.blue.cgColor, UIColor.green.cgColor]

         let shape = CAShapeLayer()
         shape.lineWidth = 1
       //  shape.path = UIBezierPath(roundedRect: self.sp_pay_grad.bounds.insetBy(dx: 2.5, dy: 2.5), cornerRadius: 15.0).cgPath

         shape.path = UIBezierPath(roundedRect: self.BTNS.bounds, cornerRadius: self.BTNS.layer.cornerRadius).cgPath

         shape.strokeColor = UIColor.black.cgColor
         shape.fillColor = UIColor.clear.cgColor
         gradient.mask = shape

         self.BTNS.layer.addSublayer(gradient)*/
        let gradientColor = CAGradientLayer()
        gradientColor.frame =  CGRect(origin: CGPoint.zero, size: BTNS.frame.size)
        gradientColor.colors = [UIColor.red.cgColor, UIColor.blue.cgColor, UIColor.green.cgColor]
        let shape = CAShapeLayer()
        shape.lineWidth = 3
        shape.path = UIBezierPath(rect: BTNS.bounds).cgPath
        shape.strokeColor = UIColor.black.cgColor
        shape.fillColor = UIColor.clear.cgColor
        gradientColor.mask = shape
        BTNS.clipsToBounds = true
        BTNS.layer.addSublayer(gradientColor)
        
        
        
        
        
    }
}

