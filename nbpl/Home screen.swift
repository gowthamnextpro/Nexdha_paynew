//
//  Home screen.swift
//  Nexdha's BNPL
//
//  Created by Nexdha on 26/05/22.
//

import Foundation
import UIKit
import CryptoKit
import DTGradientButton
import Alamofire
import SwiftyJSON
import TTGSnackbar
class Homescreen: UIViewController {
    @IBOutlet weak var junior_logg: UIStackView!
    var isGradientAdded: Bool = false
    var verificationId = String()
    @IBOutlet weak var parent_logg: UIStackView!
    @IBOutlet weak var student_btn: UIButton!
    @IBOutlet weak var parent_btn: UIButton!
    @IBOutlet weak var are_you: UILabel!
    @IBOutlet weak var BNPL_label: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
       // parent_btn.isHidden = true
       
        // Initialize gradient layer.
    /*  let gradientLayer: CAGradientLayer = CAGradientLayer()

        // Set frame of gradient layer.
        gradientLayer.frame = parent_btn.bounds
        parent_btn.clipsToBounds = true
       // let width = parent_logg.bounds.width
      //  let r = parent_btn.frame
     //   parent_btn.frame = CGRect(x: r.origin.x, y: r.origin.y, width: width, height: r.height)
       // parent_btn.width = UIScreen.main.bounds.width
       
        // Color at the top of the gradient.
        let topColor: CGColor = UIColor.magenta.cgColor

        // Color at the middle of the gradient.
      //  let middleColor: CGColor = UIColor.blue.cgColor

        // Color at the bottom of the gradient.
        let bottomColor: CGColor = UIColor(red: 0.24, green: 0.08, blue: 0.58, alpha: 1.00).cgColor

        // Set colors.
        gradientLayer.colors = [topColor, bottomColor]

        // Set start point.
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)

        // Set end point.
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)

        // Insert gradient layer into view's layer heirarchy.
        parent_btn.layer.insertSublayer(gradientLayer, at: 0)*/
        parent_btn.new_grad(colors: [UIColor.magenta.cgColor, UIColor(red: 0.24, green: 0.08, blue: 0.58, alpha: 1.00).cgColor])
        parent_btn.clipsToBounds = true
        parent_btn.layer.cornerRadius = 25

        student_btn.new_grad(colors: [UIColor(red: 0.24, green: 0.08, blue: 0.58, alpha: 1.00).cgColor, UIColor.magenta.cgColor])
        student_btn.clipsToBounds = true
        student_btn.layer.cornerRadius = 25

        are_you.textColor = UIColor(red: 252, green: 252, blue: 252, alpha: 1.0)
        let label = UILabel()
        let text = NSMutableAttributedString()
        text.append(NSAttributedString(string: "Buy Now &   Pay Later for", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white]));
        //let gold = UIColor(named: "#ffe700ff")
        let swiftColor = UIColor(red: 0.91, green: 1.00, blue: 0.00, alpha: 1.00)
        text.append(NSAttributedString(string: " Students", attributes: [NSAttributedString.Key.foregroundColor: swiftColor]))
        BNPL_label.attributedText = text

    /*    let juniors = UITapGestureRecognizer(target: self, action: #selector(junior_only(_:)))
        junior_logg.addGestureRecognizer(juniors)
        
        
        let parent_dash = UITapGestureRecognizer(target: self, action: #selector(parents(_:)))
        parent_logg.addGestureRecognizer(parent_dash)*/
      // parent_btn.applyGradient(colors: [UIColor(red: 0.69, green: 0.76, blue: 098, alpha: 1.00).cgColor,UIColor(red: 0.53, green: 0.61, blue: 0.97, alpha: 1.00).cgColor,UIColor(red: 0.90, green: 0.17, blue: 0.85, alpha: 1.00).cgColor])
      /*  parent_btn.colors = colors
        parent_btn.transform = CATransform3DMakeRotation(270 / 180 * CGFloat.pi, 0, 0, 1) // New line
        parent_btn.frame = self.gradientButton.bounds*/
     /*   let gradient = CAGradientLayer()
        gradient.colors = [UIColor.systemGray.cgColor,UIColor.systemYellow.cgColor]
        gradient.frame = parent_btn.bounds
        parent_btn.setTitle("Parent", for: .normal)
        parent_btn.layer.insertSublayer(gradient, at: 2)
        parent_btn.layer.cornerRadius = 25
        parent_btn.layer.masksToBounds = true
        let gradient1 = CAGradientLayer()
        gradient1.colors = [UIColor.systemGray.cgColor,UIColor.systemYellow.cgColor]
        gradient1.frame = student_btn.bounds
        student_btn.setTitle("Child", for: .normal)
        student_btn.layer.insertSublayer(gradient1, at: 2)
        student_btn.layer.cornerRadius = 25
        student_btn.layer.masksToBounds = true*/
    }
    @objc func parents(_ sender: Any){
        func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if (segue.identifier == "Homescreen_to_parent") {
                let vc = segue.destination as! parent_login
                vc.verificationId = "Parent Login"
            } else if (segue.identifier == "Homescreen_to_student") {
                let vc = segue.destination as! parent_login
                vc.verificationId = "Student Login"
            }
        }
        
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
           return .lightContent
       }
    @IBAction func student_go(_ sender: Any) {
      //  AppDelegate.Nexdha_student.login_heading  == "student"
       // print(AppDelegate.Nexdha_student.login_heading)
       self.performSegue(withIdentifier: "Homescreen_to_student", sender: nil)
     //   self.performSegue(withIdentifier: "home_to_transhistory", sender: nil)
    }
    @objc func junior_only(_ sender: Any){
        func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if (segue.identifier == "Homescreen_to_parent") {
                let vc = segue.destination as! parent_login
                vc.verificationId = "Parent Login"
            } else if (segue.identifier == "Homescreen_to_student") {
                let vc = segue.destination as! parent_login
                vc.verificationId = "Student Login"
            }
        }
       }
    @IBAction func parent_go(_ sender: Any) {
       // AppDelegate.Nexdha_student.login_heading  == "Parent"
       // print(AppDelegate.Nexdha_student.login_heading)
      //  let snackbar = TTGSnackbar(message: "coming soon...", duration: .short) //// check hide
      //  snackbar.show()
     self.performSegue(withIdentifier: "Homescreen_to_parent", sender: nil)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "Homescreen_to_parent") {
            let vc = segue.destination as! parent_login
            vc.verificationId = "Parent Login"
        } else if (segue.identifier == "Homescreen_to_student") {
            let vc = segue.destination as! parent_login
            vc.verificationId = "Student Login"
        }
    }
}
var preferredStatusBarStyle13: UIStatusBarStyle {
    return .lightContent
}
extension UIButton{
    func applyGradient(colors : [CGColor]){
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = colors
       // gradientLayer.cornerRadius = layer.cornerRadius
       // gradientLayer.startPoint = CGPoint(x: 0.0, y: 1.0)
       // gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
        //let view = UIView(frame: CGRect(x: 0, y: 0, width: 300, height: 50))

        gradientLayer.startPoint = CGPoint(x: 0.0, y: 1.0)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
        gradientLayer.frame = bounds
        gradientLayer.cornerRadius = 25
        layer.insertSublayer(gradientLayer, at: 0)
        
      /*  let view = UIView(frame: CGRect(x: 0, y: 0, width: 380, height: 50))
        let gradient = CAGradientLayer()

        gradient.frame = view.bounds
        gradient.colors = [UIColor(red: 0.24, green: 0.08, blue: 0.58, alpha: 1.00).cgColor, UIColor.magenta.cgColor]
        gradient.cornerRadius = 25

        layer.insertSublayer(gradient, at: 0)*/
      
    }
 
    func applyGradient_dashboard(colors : [CGColor]){
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = colors
        gradientLayer.cornerRadius = layer.cornerRadius
       // gradientLayer.startPoint = CGPoint(x: 0.0, y: 1.0)
       // gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
        
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 1.0)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
        gradientLayer.frame = bounds
        gradientLayer.cornerRadius = 0
        layer.insertSublayer(gradientLayer, at: 0)
    }
    func new_grad(colors : [CGColor]){
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = colors
      // gradientLayer.cornerRadius = layer.cornerRadius
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0)
        gradientLayer.frame = bounds
        layer.insertSublayer(gradientLayer, at: 0)
    }

    }

