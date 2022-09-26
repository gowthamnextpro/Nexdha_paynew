//
//  Parent signup.swift
//  Nexdha's BNPL
//
//  Created by Nexdha on 31/05/22.
//

import Foundation
import UIKit
class parentsignup: UIViewController , UITextFieldDelegate{

    @IBOutlet weak var backs: UIImageView!
    @IBOutlet weak var next_grad: UIButton!
    @IBOutlet weak var person_name: UITextField!
    @IBOutlet weak var student_name: UITextField!
    @IBOutlet weak var parent_emailid: UITextField!
    @IBOutlet weak var student_mobilenumber: UITextField!
    @IBOutlet weak var parent_mobilenumber: UITextField!
    var border = CALayer()
    var width = CGFloat(1.0)
    
    var border1 = CALayer()
    var width1 = CGFloat(1.0)
    
    var border2 = CALayer()
    var width2 = CGFloat(1.0)
    
    var border3 = CALayer()
    var width3 = CGFloat(1.0)
    
    var border4 = CALayer()
    var width4 = CGFloat(1.0)
    override func viewDidLoad() {
        super.viewDidLoad()
      /*  s_mobilenumber.attributedPlaceholder = NSAttributedString(
            string: "Student Mobile Number",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray]
        )
        s_mobilenumber.font = UIFont(name: "Montserrat-Regular", size: 22)

        p_emailid.attributedPlaceholder = NSAttributedString(
            string: "Parent EmailID",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray]
        )
        p_emailid.font = UIFont(name: "Montserrat-Regular", size: 22)

        p_mobilenumber.attributedPlaceholder = NSAttributedString(
            string: "Parent Mobile Number",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray]
        )
        p_mobilenumber.font = UIFont(name: "Montserrat-Regular", size: 22)

        p_name.attributedPlaceholder = NSAttributedString(
            string: "Parent Name",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray]
        )
        p_name.font = UIFont(name: "Montserrat-Regular", size: 22)

        s_name.attributedPlaceholder = NSAttributedString(
            string: "Student Name",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray]
        )
        s_name.font = UIFont(name: "Montserrat-Regular", size: 22)*/

      next_grad.applyGradient(colors: [UIColor.magenta.cgColor, UIColor(red: 0.46, green: 0.76, blue: 0.04, alpha: 1.00).cgColor])
        let payment_back_var = UITapGestureRecognizer(target: self, action: #selector(pay_back_clicked(_:)))
        backs.addGestureRecognizer(payment_back_var)
        border.borderColor = UIColor.gray.cgColor
        border.frame = CGRect(x: 0, y: person_name.frame.size.height - width, width: person_name.frame.size.width, height: person_name.frame.size.height)
        border.borderWidth = width
        person_name.backgroundColor = UIColor.clear
        person_name.layer.addSublayer(border)
        person_name.layer.masksToBounds = true
        person_name.textColor = UIColor.gray
        person_name.delegate = self
        
        
        border1.borderColor = UIColor.gray.cgColor
        border1.frame = CGRect(x: 0, y: student_name.frame.size.height - width1, width: student_name.frame.size.width, height: student_name.frame.size.height)
        border1.borderWidth = width1
        student_name.backgroundColor = UIColor.clear
        student_name.layer.addSublayer(border1)
        student_name.layer.masksToBounds = true
        student_name.textColor = UIColor.gray
        student_name.delegate = self
        
        
        border2.borderColor = UIColor.gray.cgColor
        border2.frame = CGRect(x: 0, y: parent_emailid.frame.size.height - width2, width: parent_emailid.frame.size.width, height: parent_emailid.frame.size.height)
        border2.borderWidth = width2
        parent_emailid.backgroundColor = UIColor.clear
        parent_emailid.layer.addSublayer(border2)
        parent_emailid.layer.masksToBounds = true
        parent_emailid.textColor = UIColor.gray
        parent_emailid.delegate = self
        
        
        border3.borderColor = UIColor.gray.cgColor
        border3.frame = CGRect(x: 0, y: student_mobilenumber.frame.size.height - width3, width: student_mobilenumber.frame.size.width, height: student_mobilenumber.frame.size.height)
        border3.borderWidth = width3
        student_mobilenumber.backgroundColor = UIColor.clear
        student_mobilenumber.layer.addSublayer(border3)
        student_mobilenumber.layer.masksToBounds = true
        student_mobilenumber.textColor = UIColor.gray
        student_mobilenumber.delegate = self
        
        
        
        
        border4.borderColor = UIColor.gray.cgColor
        border4.frame = CGRect(x: 0, y: parent_mobilenumber.frame.size.height - width4, width: parent_mobilenumber.frame.size.width, height: parent_mobilenumber.frame.size.height)
        border4.borderWidth = width4
        parent_mobilenumber.backgroundColor = UIColor.clear
        parent_mobilenumber.layer.addSublayer(border4)
        parent_mobilenumber.layer.masksToBounds = true
        parent_mobilenumber.textColor = UIColor.gray
        parent_mobilenumber.delegate = self
      
        
        
        
        
        
    }
  
 
    @IBAction func login(_ sender: Any) {
        self.performSegue(withIdentifier: "signup_to_login", sender: nil)

    }
    @objc func pay_back_clicked(_ sender: Any){
        self.dismiss(animated: true, completion: nil)
       }
 
}
