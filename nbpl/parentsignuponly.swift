//
//  parent_signuponly.swift
//  nbpl
//
//  Created by Nexdha on 23/06/22.
//

import Foundation
import UIKit
import Alamofire
import SwiftyJSON
import Lottie
import CryptoKit
class parentsignuponly: UIViewController , UITextFieldDelegate{
    var border = CALayer()
    var width = CGFloat(1.0)
    var border1 = CALayer()
    var border2 = CALayer()
    var border3 = CALayer()
    var border4 = CALayer()
    @IBOutlet weak var loading: AnimationView!
    @IBOutlet weak var back: UIImageView!
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var error1: UILabel!
    @IBOutlet weak var phone: UITextField!
    @IBOutlet weak var sinup_only: UIButton!
    override var preferredStatusBarStyle: UIStatusBarStyle {
           return .lightContent
       }
    override func viewDidLoad() {
        super.viewDidLoad()
        loading.isHidden = true

        self.hideKeyboardWhenTappedAround()
        self.addDoneButtonOn_name_Keyboard()
        self.addDoneButton_phone_OnKeyboard()
        self.addDoneButtonOn_email_Keyboard()
        print("123456")
        error1.isHidden = true
        sinup_only.new_grad(colors: [UIColor.magenta.cgColor, UIColor(red: 0.24, green: 0.08, blue: 0.58, alpha: 1.00).cgColor])
 

        sinup_only.layer.cornerRadius = 25
        sinup_only.clipsToBounds = true
        let payment_back_var = UITapGestureRecognizer(target: self, action: #selector(pay_back_clicked(_:)))
        back.addGestureRecognizer(payment_back_var)
        
        
        
        name.attributedPlaceholder =
        NSAttributedString(string: "Name", attributes: [NSAttributedString.Key.foregroundColor : UIColor.gray])
        
        
        email.attributedPlaceholder =
        NSAttributedString(string: "Email", attributes: [NSAttributedString.Key.foregroundColor : UIColor.gray])
        
        phone.attributedPlaceholder =
        NSAttributedString(string: "Phone", attributes: [NSAttributedString.Key.foregroundColor : UIColor.gray])
        
        border.borderColor = UIColor(red: 0.17, green: 0.17, blue: 0.17, alpha: 1.00).cgColor
        border.frame = CGRect(x: 0, y: name.frame.size.height - width, width: name.frame.size.width, height: name.frame.size.height)
        border.borderWidth = width
        name.backgroundColor = UIColor.clear
        name.layer.addSublayer(border)
        name.layer.masksToBounds = true
        name.textColor = UIColor.gray
        name.delegate = self
        
        
        border1.borderColor = UIColor(red: 0.17, green: 0.17, blue: 0.17, alpha: 1.00).cgColor
        border1.frame = CGRect(x: 0, y: email.frame.size.height - width, width: email.frame.size.width, height: email.frame.size.height)
        border1.borderWidth = width
        email.backgroundColor = UIColor.clear
        email.layer.addSublayer(border1)
        email.layer.masksToBounds = true
        email.textColor = UIColor.gray
        email.delegate = self
        
        
        border2.borderColor = UIColor(red: 0.17, green: 0.17, blue: 0.17, alpha: 1.00).cgColor
        border2.frame = CGRect(x: 0, y: phone.frame.size.height - width, width: phone.frame.size.width, height: phone.frame.size.height)
        border2.borderWidth = width
        phone.backgroundColor = UIColor.clear
        phone.layer.addSublayer(border2)
        phone.layer.masksToBounds = true
        phone.textColor = UIColor.gray
        phone.delegate = self
        
      
    }
    override func viewWillAppear(_ animated: Bool) {
      super.viewWillAppear(animated)
    }
  public func parent_signup()  {
        loading.isHidden = false
        loading?.contentMode = .scaleAspectFit
        loading?.loopMode =  .loop
        loading?.animationSpeed = 0.85
   //   animationview?.backgroundColor = UIColor(red: 0.00, green: 0.00, blue: 0.00, alpha: 1.00)
        loading?.play()
        let name = name.text
        let trimmed_name = name!.trimmingCharacters(in: .whitespacesAndNewlines) // prints "Taylor Swift"

        let phone = phone.text
        let trimmed_phone = phone!.trimmingCharacters(in: .whitespacesAndNewlines) // prints "Taylor Swift"

        let email = email.text
        let trimmed_email = email!.trimmingCharacters(in: .whitespacesAndNewlines) // prints "Taylor Swift"

        let inputString1 = "kmKHO0vpCxUK5m9fAs0Z"
        let inputString2 = trimmed_name + trimmed_email + trimmed_phone + "parent" + inputString1
        print(inputString2)
        let trimmed = inputString2.trimmingCharacters(in: .whitespacesAndNewlines) // prints "Taylor Swift"
        let inputData = Data(trimmed.utf8)
        let hashed = SHA512.hash(data: inputData)
        print(hashed.description)
        let hash = hashed.compactMap { String(format: "%02x", $0) }.joined()
        print(hash)
      let parameters = ["name": trimmed_name.replacingOccurrences(of: " ", with: "", options: .regularExpression), "email": trimmed_email.replacingOccurrences(of: " ", with: "", options: .regularExpression), "phone":trimmed_phone.replacingOccurrences(of: " ", with: "", options: .regularExpression),"os":"iOS", "user_type":"parent","namee": hash]
                      
                     AF.request(AppDelegate.Nexdha_student.server+"/api/save_users", method: .post, parameters: parameters).responseJSON { response in
                                 debugPrint(response)
                      switch response.result{
                      case .success(let value):
                          let json = JSON(value)
                          if let token = json["token"].string{
                            //  let json = JSON(value).arrayValue
                            if token == "Number Exists"{
                                self.loading?.stop()
                                self.loading.isHidden = true
                                self.Toast1(Title: "Number already exists please login", Text: "You will be redirected to Login page", delay: 2)
                            }else{
                                UserDefaults.standard.set(phone, forKey: "number")
                                self.loading?.stop()
                                self.loading.isHidden = true
                                self.Toast(Title: "Signup Successfully", Text: "", delay: 2)
                                debugPrint("Done")
                               //  self.sendsignupsms()
                            }
                          }
                      case.failure(let error):
                          print(error)
                      }
                             }
    }
    func Toast(Title:String ,Text:String, delay:Int) -> Void {
        let alert = UIAlertController(title: Title, message: Text, preferredStyle: .alert)
        self.present(alert, animated: true)
        let deadlineTime = DispatchTime.now() + .seconds(delay)
        DispatchQueue.main.asyncAfter(deadline: deadlineTime, execute: {
            alert.dismiss(animated: true, completion: nil)
            self.performSegue(withIdentifier: "parent_otppage", sender: self)
        })
    }
    func Toast1(Title:String ,Text:String, delay:Int) -> Void {
        let alert = UIAlertController(title: Title, message: Text, preferredStyle: .alert)
        self.present(alert, animated: true)
        let deadlineTime = DispatchTime.now() + .seconds(delay)
        DispatchQueue.main.asyncAfter(deadline: deadlineTime, execute: {
            alert.dismiss(animated: true, completion: nil)
           self.performSegue(withIdentifier: "signup_to_login", sender: nil)
           
        })
    }
    
    @objc override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "signup_to_login") {
            let vc = segue.destination as! parent_login
            vc.verificationId = "Parent Login"
        }
    }
    func addDoneButtonOn_name_Keyboard(){
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        doneToolbar.barStyle = .default

        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Next", style: .done, target: self, action: #selector(self.done_name_ButtonAction))

        let items = [flexSpace, done]
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        name.inputAccessoryView = doneToolbar
    }
    @objc func done_name_ButtonAction(){
        name.resignFirstResponder()
        email.becomeFirstResponder()
    }
    func addDoneButton_phone_OnKeyboard(){
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        doneToolbar.barStyle = .default

        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Next", style: .done, target: self, action: #selector(self.done_phone_ButtonAction))

        let items = [flexSpace, done]
        doneToolbar.items = items
        doneToolbar.sizeToFit()

        email.inputAccessoryView = doneToolbar
    }

    @objc func done_phone_ButtonAction(){
        email.resignFirstResponder()
        phone .becomeFirstResponder()
    }
    func addDoneButtonOn_email_Keyboard(){
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        doneToolbar.barStyle = .default

        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.done_email_ButtonAction))

        let items = [flexSpace, done]
        doneToolbar.items = items
        doneToolbar.sizeToFit()

        phone.inputAccessoryView = doneToolbar
    }
    @objc func done_email_ButtonAction(){
        phone.resignFirstResponder()
    }
    @IBAction func signup_to_otp(_ sender: Any) {
        email.resignFirstResponder()
        error1.isHidden = true
             let name_to_be_trimmed = name.text
                 let phone_to_be_trimmed = phone.text
                 let email_to_be_trimmed = email.text
                 let trimmed_name = name_to_be_trimmed!.replacingOccurrences(of: " ", with: "", options: .regularExpression)
                 let trimmed_phone = phone_to_be_trimmed!.replacingOccurrences(of: " ", with: "", options: .regularExpression)
                 let trimmed_email = email_to_be_trimmed!.replacingOccurrences(of: " ", with: "", options: .regularExpression)
             //for Validation
                                    if(name.text == ""){
                                        error1.text = "Enter User name"
                                        error1.isHidden = false
                                        name.becomeFirstResponder()
                                    }else if(trimmed_name == ""){
                                        error1.text = "User name cannot be blank"
                                        error1.isHidden = false
                                        name.becomeFirstResponder()
                                    }
                                    else{
                                        if(phone.text == ""){
                                            error1.text = "Enter Phone Number"
                                            error1.isHidden = false
                                            phone.becomeFirstResponder()
                                        }else if(trimmed_phone == ""){
                                            error1.text = "Phone cannot be blank"
                                            error1.isHidden = false
                                         phone.becomeFirstResponder()
                                        }else if(trimmed_phone.count < 10){
                                            error1.text = "Invalid phone number"
                                            error1.isHidden = false
                                         phone.becomeFirstResponder()
                                        }
                                        else{
                                            if(email.text == ""){
                                                error1.text = "Enter Email ID"
                                                error1.isHidden = false
                                                email.becomeFirstResponder()
                                            }else if(isValidEmail(email: email.text!) == false){
                                                error1.text = "Enter valid mail ID"
                                                error1.isHidden = false
                                             email.becomeFirstResponder()
                                            }else if(trimmed_email == ""){
                                                error1.text = "Email cannot be blank"
                                                error1.isHidden = false
                                             email.becomeFirstResponder()
                                            }
                                            else {
                                         parent_signup()
                                            
                                         }
                                            
                                        }
                                    }
    }
    func isValidEmail(email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    @IBAction func login(_ sender: Any) {
        self.performSegue(withIdentifier: "signup_to_login", sender: nil)

    }
    @objc func pay_back_clicked(_ sender: Any){
        self.dismiss(animated: true, completion: nil)
       }
 
}
