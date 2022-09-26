//
//  add_student.swift
//  nbpl
//
//  Created by Nexdha on 21/06/22.
//

import Foundation
import UIKit
import Foundation
import Alamofire
import SwiftyJSON
import Lottie
import CryptoKit


class add_student: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var add_btns: UIButton!
    @IBOutlet weak var error: UILabel!
    @IBOutlet weak var add: UIButton!
    @IBOutlet weak var back: UIImageView!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var add_stacks: UIStackView!
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var phone: UITextField!
    var border = CALayer()
    var width = CGFloat(1.0)
    var border1 = CALayer()
    var border2 = CALayer()
    var count = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        error.isHidden = true
        self.hideKeyboardWhenTappedAround()

        add_btns.layer.cornerRadius = 20
        add.applyGradient(colors: [UIColor.magenta.cgColor, UIColor(red: 0.24, green: 0.08, blue: 0.58, alpha: 1.00).cgColor])
        border.borderColor = UIColor(red: 0.17, green: 0.17, blue: 0.17, alpha: 1.00).cgColor
        border.frame = CGRect(x: 0, y: email.frame.size.height - width, width: email.frame.size.width, height: email.frame.size.height)
        border.borderWidth = width
        email.backgroundColor = UIColor.clear
        email.layer.addSublayer(border)
        email.layer.masksToBounds = true
        email.textColor = UIColor.white
        email.delegate = self
        
        email.attributedPlaceholder = NSAttributedString(string: "Email", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])

        border1.borderColor = UIColor(red: 0.17, green: 0.17, blue: 0.17, alpha: 1.00).cgColor
        border1.frame = CGRect(x: 0, y: name.frame.size.height - width, width: name.frame.size.width, height: name.frame.size.height)
        border1.borderWidth = width
        name.backgroundColor = UIColor.clear
        name.layer.addSublayer(border1)
        name.layer.masksToBounds = true
        name.textColor = UIColor.white
        name.delegate = self
        
        
        name.attributedPlaceholder = NSAttributedString(string: "Name", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        border2.borderColor = UIColor(red: 0.17, green: 0.17, blue: 0.17, alpha: 1.00).cgColor
        border2.frame = CGRect(x: 0, y: phone.frame.size.height - width, width: phone.frame.size.width, height: phone.frame.size.height)
        border2.borderWidth = width
        phone.backgroundColor = UIColor.clear
        phone.layer.addSublayer(border2)
        phone.layer.masksToBounds = true
        phone.textColor = UIColor.white
        phone.delegate = self
        phone.attributedPlaceholder = NSAttributedString(string: "Phone", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        
        let payment_back_var = UITapGestureRecognizer(target: self, action: #selector(pay_back_clicked(_:)))
        back.addGestureRecognizer(payment_back_var)
        
        let stack = UITapGestureRecognizer(target: self, action: #selector(stack_add(_:)))
        add_stacks.addGestureRecognizer(stack)
        self.addDoneButtonOn_name_Keyboard()
        self.addDoneButton_phone_OnKeyboard()
        self.addDoneButtonOn_email_Keyboard()
        counter_check()

 }
    override func viewWillAppear(_ animated: Bool) {
      counter_check()
      super.viewWillAppear(animated)
    }
    public func activity_log(){
        let headers: HTTPHeaders = [
            .authorization(UserDefaults.standard.string(forKey: "token") as! String)
        ]
        let parameters = ["activity_id": "204" ,"os": "iOS"]
        AF.request(AppDelegate.Nexdha_student.server+"/api/activity_log", method: .post, parameters: parameters , headers: headers).responseJSON { response in
            switch response.result{
                          case .success(let value):
                              let json = JSON(value)
                              print("745")
                              print(json)
                          case.failure(let error):
                              print(error)
                          }
               }
    }
    public func counter_check(){
        print("ak")
        print(UserDefaults.standard.string(forKey: "token"))
        print("ak1")
        let tokenData =  UserDefaults.standard.string(forKey: "token")
        print(tokenData)
        let newString = tokenData!.replacingOccurrences(of: "token", with: "", options: .literal, range: nil)
        print(newString)
        let headers : HTTPHeaders = [
         "Auth": newString,
        ]
        AF.request(AppDelegate.Nexdha_student.server+"/api/counter_check", method: .post, headers: headers).responseJSON { response in
           
            switch response.result{
                          case .success(let value):
                              let json = JSON(value)
                              debugPrint(json)
                               print(json)
                                let status = json["detail"].string

                if status == "1"{
                    let status1 = json["allow_user"].string
                    if status1 == "0"{
                        let alert = UIAlertController(title: "Account Blocked", message: "Your account is blocked by Nexdha Pay. Please contact support@nexdha.com", preferredStyle: .alert)
                                   debugPrint("This is three")

                                  // alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
                                  

                                   self.present(alert, animated: true)
                    } else{
                        if self.count == 0{
                           self.count += 1
                           print("&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&")
                           self.activity_log()
                       }else{
                           print("😊😊😊😊😊😊😊")
                       }
                    }
                }else if status == "Invalid token" || status == "0"{
                    self.Toast(Title: "Session Expired", Text: "Please login again", delay: 3)
                    UserDefaults.standard.removeObject(forKey: "token")
                    UserDefaults.standard.removeObject(forKey: "number")
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
            self.performSegue(withIdentifier: "addstudent_home", sender: nil)
        })
    }
    
    @objc func stack_add(_ sender: Any){
        email.resignFirstResponder()
        error.isHidden = true
             let name_to_be_trimmed = name.text
                 let phone_to_be_trimmed = phone.text
                 let email_to_be_trimmed = email.text
                 let trimmed_name = name_to_be_trimmed!.replacingOccurrences(of: " ", with: "", options: .regularExpression)
                 let trimmed_phone = phone_to_be_trimmed!.replacingOccurrences(of: " ", with: "", options: .regularExpression)
                 let trimmed_email = email_to_be_trimmed!.replacingOccurrences(of: " ", with: "", options: .regularExpression)
             //for Validation
                                    if(name.text == ""){
                                         error.text = "Enter User name"
                                        error.isHidden = false
                                        name.becomeFirstResponder()
                                    }else if(trimmed_name == ""){
                                        error.text = "User name cannot be blank"
                                        error.isHidden = false
                                        name.becomeFirstResponder()
                                    }
                                    else{
                                        if(phone.text == ""){
                                            error.text = "Enter Phone Number"
                                            error.isHidden = false
                                            phone.becomeFirstResponder()
                                        }else if(trimmed_phone == ""){
                                         error.text = "Phone cannot be blank"
                                          error.isHidden = false
                                         phone.becomeFirstResponder()
                                        }else if(trimmed_phone.count < 10){
                                         error.text = "Invalid phone number"
                                          error.isHidden = false
                                         phone.becomeFirstResponder()
                                        }
                                        else{
                                            if(email.text == ""){
                                                error.text = "Enter Email ID"
                                                error.isHidden = false
                                                email.becomeFirstResponder()
                                            }else if(isValidEmail(email: email.text!) == false){
                                             error.text = "Enter valid mail ID"
                                             error.isHidden = false
                                             email.becomeFirstResponder()
                                            }else if(trimmed_email == ""){
                                             error.text = "Email cannot be blank"
                                              error.isHidden = false
                                             email.becomeFirstResponder()
                                            }
                                            else {
                                          signup()
                                            
                                         }
                                            
                                        }
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
    @IBAction func add(_ sender: Any) {
        email.resignFirstResponder()
        error.isHidden = true
             let name_to_be_trimmed = name.text
                 let phone_to_be_trimmed = phone.text
                 let email_to_be_trimmed = email.text
                 let trimmed_name = name_to_be_trimmed!.replacingOccurrences(of: " ", with: "", options: .regularExpression)
                 let trimmed_phone = phone_to_be_trimmed!.replacingOccurrences(of: " ", with: "", options: .regularExpression)
                 let trimmed_email = email_to_be_trimmed!.replacingOccurrences(of: " ", with: "", options: .regularExpression)
             //for Validation
                                    if(name.text == ""){
                                         error.text = "Enter User name"
                                        error.isHidden = false
                                        name.becomeFirstResponder()
                                    }else if(trimmed_name == ""){
                                        error.text = "User name cannot be blank"
                                        error.isHidden = false
                                        name.becomeFirstResponder()
                                    }
                                    else{
                                        if(phone.text == ""){
                                            error.text = "Enter Phone Number"
                                            error.isHidden = false
                                            phone.becomeFirstResponder()
                                        }else if(trimmed_phone == ""){
                                         error.text = "Phone cannot be blank"
                                          error.isHidden = false
                                         phone.becomeFirstResponder()
                                        }else if(trimmed_phone.count < 10){
                                         error.text = "Invalid phone number"
                                          error.isHidden = false
                                         phone.becomeFirstResponder()
                                        }
                                        else{
                                            if(email.text == ""){
                                                error.text = "Enter Email ID"
                                                error.isHidden = false
                                                email.becomeFirstResponder()
                                            }else if(isValidEmail(email: email.text!) == false){
                                             error.text = "Enter valid mail ID"
                                             error.isHidden = false
                                             email.becomeFirstResponder()
                                            }else if(trimmed_email == ""){
                                             error.text = "Email cannot be blank"
                                              error.isHidden = false
                                             email.becomeFirstResponder()
                                            }
                                            else {
                                          signup()
                                         }
                                        }
                                    }
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
           return .lightContent
       }
    func isValidEmail(email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    @objc func pay_back_clicked(_ sender: Any){
      self.dismiss(animated: true, completion: nil)
    }
    public func signup(){
        let name = name.text
        let phone = phone.text
        let email = email.text
        
        
        let inputString1 = "kmKHO0vpCxUK5m9fAs0Z"
        let inputString2 = name! + email! + phone! + "junior" + inputString1
        print(inputString2)
        let inputData = Data(inputString2.utf8)
        let hashed = SHA512.hash(data: inputData)
        print(hashed.description)
        let hash = hashed.compactMap { String(format: "%02x", $0) }.joined()
        print(hash)
        
        let headers: HTTPHeaders = [
            .authorization(UserDefaults.standard.object(forKey: "token") as! String)
                ]
        let parameters = ["name": name!.replacingOccurrences(of: " ", with: "", options: .regularExpression), "email": email!.replacingOccurrences(of: " ", with: "", options: .regularExpression), "phone":phone!.replacingOccurrences(of: " ", with: "", options: .regularExpression),"os":"iOS", "user_type":"junior", "namee" : hash.replacingOccurrences(of: " ", with: "", options: .regularExpression)]
                      
                     AF.request(AppDelegate.Nexdha_student.server+"/api/save_users", method: .post, parameters: parameters,headers: headers).responseJSON { response in
                                 debugPrint(response)
                      switch response.result{
                      case .success(let value):
                          let json = JSON(value)
                          if let token = json["token"].string{
                            //  let json = JSON(value).arrayValue
                            if token == "success"{
                                self.Toast1(Title: "Successfully Added Junior", Text: "You can Add the Amount for your Junior", delay: 2)
                                debugPrint("Done")
                               
                                
                             //   self.phoneerror.text = "Number already exists"
                             //   self.phoneerror.isHidden = false
                                
                            }else{
                                self.Toast1(Title: token, Text: "" , delay: 2)
                              //  debugPrint(token)
                                  // UserDefaults.standard.set("token  "+token, forKey: "usertoken")
                                
                               //  self.sendsignupsms()
                               //  self.performSegue(withIdentifier: "signuptootp", sender: self)
                            }
                              
                              
                          }
                      case.failure(let error):
                          print(error)
                      }
                             }
    }
    func Toast1(Title:String ,Text:String, delay:Int) -> Void {
        let alert = UIAlertController(title: Title, message: Text, preferredStyle: .alert)
        self.present(alert, animated: true)
        let deadlineTime = DispatchTime.now() + .seconds(delay)
        DispatchQueue.main.asyncAfter(deadline: deadlineTime, execute: {
            alert.dismiss(animated: true, completion: nil)
            self.performSegue(withIdentifier: "add_student_to_dashboard", sender: self)
        })
    }

}
