//
//  otp.swift
//  Nexdha's BNPL
//
//  Created by Nexdha on 01/06/22.
//

import Foundation
import UIKit
import Alamofire
import SwiftyJSON
import CryptoKit
class otp: UIViewController , UITextFieldDelegate {
    let testVC = parent_login()

    @IBOutlet weak var otp_enter: UITextField!
    @IBOutlet weak var otp_btn_stack: UIStackView!
    @IBOutlet weak var enter_otp: UILabel!
    @IBOutlet weak var otp_errror: UILabel!
    @IBOutlet weak var signup: UIButton!
    @IBOutlet weak var otp: UITextField!
    @IBOutlet weak var login_with_otp: UIButton!
    @IBOutlet weak var back: UIImageView!
    @IBOutlet weak var v_user: UIStackView!
    var verificationId = String()
    @IBOutlet weak var resend_otp: UILabel!
    var border = CALayer()
    var width = CGFloat(1.0)
    var seconds : Int = 60 //This variable will hold a starting value of seconds. It could be any amount above 0.
    var timer = Timer()
    var isTimerRunning = false
    var count1 = 15
    var count2 = 20

    /* var border = CALayer()
    var width = CGFloat(1.0)
    
    var border1 = CALayer()
    var width1 = CGFloat(1.0)
    
    var border2 = CALayer()
    var width2 = CGFloat(1.0)
    
    var border3 = CALayer()
    var width3 = CGFloat(1.0)
    
   
    var border4 = CALayer()
    var width4 = CGFloat(1.0)*/
    override func viewDidLoad() {
        super.viewDidLoad()
       // resend_otp.isHidden = false
        addDoneButtonOnKeyboard()
        self.hideKeyboardWhenTappedAround()
        self.resend_otp.isUserInteractionEnabled = false
        self.seconds = 60
        self.runTimer()
        self.resend_otp.textColor = UIColor(red: 1.00, green: 1.00, blue: 1.00, alpha: 1.00)
        
        
        
        border.borderColor =  UIColor(red: 0.17, green: 0.17, blue: 0.17, alpha: 1.00).cgColor
        border.frame = CGRect(x: 0, y: otp_enter.frame.size.height - width, width: otp_enter.frame.size.width, height: otp_enter.frame.size.height)
        border.borderWidth = width
        otp_enter.backgroundColor = UIColor.clear
        otp_enter.layer.addSublayer(border)
        otp_enter.layer.masksToBounds = true
        otp_enter.textColor = UIColor.white
        otp_enter.delegate = self
        login_with_otp.new_grad(colors: [UIColor(red: 0.24, green: 0.08, blue: 0.58, alpha: 1.00).cgColor, UIColor.magenta.cgColor])
        login_with_otp.layer.cornerRadius = 25
        login_with_otp.clipsToBounds = true
        let cameraTap = UITapGestureRecognizer(target: self, action: #selector(backTapped))
        back.isUserInteractionEnabled = true
        back.addGestureRecognizer(cameraTap)
        otp_errror.isHidden = true
        let label = UILabel()
        let text = NSMutableAttributedString()
        text.append(NSAttributedString(string: "Enter", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white]));
        //let gold = UIColor(named: "#ffe700ff")
        let swiftColor = UIColor(red: 232, green: 255/255, blue: 0, alpha: 1)
        text.append(NSAttributedString(string: " OTP", attributes: [NSAttributedString.Key.foregroundColor: swiftColor]))
        enter_otp.attributedText = text
        if(AppDelegate.Nexdha_student.login_heading == "Student"){
        //    v_user.isHidden = true
        }

      /*  let logg = UITapGestureRecognizer(target: self, action: #selector(otp_get(_:)))
        otp_btn_stack.addGestureRecognizer(logg)*/
        
        
        let attributedString = NSMutableAttributedString.init(string: "RESEND")
        // Add Underline Style Attribute.
        attributedString.addAttribute(NSAttributedString.Key.underlineStyle, value: 1, range:
            NSRange.init(location: 0, length: attributedString.length));
        resend_otp.attributedText = attributedString
        
        
        let resend_labl = UITapGestureRecognizer(target: self, action: #selector(resend_l(_:)))
        resend_otp.addGestureRecognizer(resend_labl)
        
  
      
      
    }
    
    @objc func resend_l(_ sender: Any){
       // seconds -= 1     //This will decrement(count down)the seconds.
       // self.runTimer()
        self.resend_otp.isUserInteractionEnabled = true
        self.seconds = 60
        self.runTimer()
        self.resend_otp.textColor = UIColor(red: 1.00, green: 1.00, blue: 1.00, alpha: 1.00)
        
        resend_verify_login()
    }
    func runTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self,   selector: (#selector(self.updateTimer)), userInfo: nil, repeats: true)
    }
    @objc func updateTimer() {
        seconds -= 1     //This will decrement(count down)the seconds.
        resend_otp.text =  "Resend OTP" + " " + "\(seconds)" + "s"//This will update the label.
        if (seconds == 0){
            self.resend_otp.isUserInteractionEnabled = true
            self.resend_otp.textColor = UIColor(red: 33/255, green: 126/255, blue: 190/255, alpha: 1.0)
         timer.invalidate()
           // self.runTimer()

           // seconds -= 1     //This will decrement(count down)the seconds.
        }
    }
    @objc func otp_get(_ sender: Any){
        if(otp_errror.text == ""){
            otp_errror.text = "Enter OTP"
            otp_errror.isHidden = false
            otp_enter.becomeFirstResponder()
               }
        else{
                verify_otp()
               }
        
       }
    override var preferredStatusBarStyle: UIStatusBarStyle {
           return .lightContent
       }
    @objc func backTapped() {
      // open your camera controller here
        self.dismiss(animated: true, completion: nil)

    }
    
    func addDoneButtonOnKeyboard(){
            let doneToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
            doneToolbar.barStyle = .default
            let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
            let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.doneButtonAction))
            let items = [flexSpace, done]
            doneToolbar.items = items
            doneToolbar.sizeToFit()
        otp_enter.inputAccessoryView = doneToolbar
        }

        @objc func doneButtonAction(){
            otp_enter.resignFirstResponder()
        }
 
    private func verify_otp(){
      //  self.performSegue(withIdentifier: "otp_to_parentdashboard", sender: nil)//FOR CHECK

        let userphone =  UserDefaults.standard.string(forKey: "number")
        let parameters = ["phone": userphone, "otp" : otp_enter.text!]
        print(parameters)
                
        AF.request(AppDelegate.Nexdha_student.server+"/api/verify_otp", method: .post, parameters: parameters).responseJSON { [self] response in
                           //debugPrint(response)
                switch response.result{
                case .success(let value):
                    let json = JSON(value)
                    print("a1")
                    print(json)
                    print("a23")
                    let Details = json["Details"].string
                    
if Details == "OTP Matched"{
        let status = json["user_type"].string
        let kyc = json["kyc"].string
        let on_b = json["on_b"].string
        AppDelegate.Nexdha_student.onboarding_screen = on_b!
        AppDelegate.Nexdha_student.usertype_otp = status!
        if AppDelegate.Nexdha_student.onboarding_screen == "1"{   /// change  0 to 1
            
                    if let token = json["token"].string{
                      //  let json = JSON(value).arrayValue
                        print(token)
                        if AppDelegate.Nexdha_student.usertype_otp == "junior" {
                           
                            self.otp_errror.isHidden = true
                            self.otp_errror.text = Details
                         //   otp_errror.textColor = UIColor(red: 0.00, green: 1.00, blue: 0.20, alpha: 1.00)
                           // self.otp_errror.text = token
                            //self.otp_errror.isHidden = false
                           // self.Toast(Title: "Number does not exists please signup", Text: "You will be redirected to Signup page", delay: 2)
                            print("A!!")
                           // UserDefaults.standard.set(token, forKey: "token_counter_check") //setObject
                            print("=======================")
                          //  print(UserDefaults.standard.set(token, forKey: "token_counter_check"))
                            UserDefaults.standard.set("token" + "  " + token, forKey: "token") //setObject 
                            print(UserDefaults.standard.set("token" + "  " + token, forKey: "token"))
                            if self.count1 == 15{
                               self.count1 += 16
                               print("&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&")
                               self.activity_log_student()
                           }else{
                               print("😊😊😊😊😊😊😊")
                           }
                            print("-------------------------------------------------")
                            self.performSegue(withIdentifier: "otp_tab", sender: nil)//FOR CHECK
                            print("hello")
                        }
                        else if AppDelegate.Nexdha_student.usertype_otp == "parent"{
                        
                            self.otp_errror.isHidden = true
                            self.otp_errror.text = Details
                         //   otp_errror.textColor = UIColor(red: 0.00, green: 1.00, blue: 0.20, alpha: 1.00)
                           // self.otp_errror.text = token
                            //self.otp_errror.isHidden = false
                           // self.Toast(Title: "Number does not exists please signup", Text: "You will be redirected to Signup page", delay: 2)
                            print("A22222")
                          //  UserDefaults.standard.set(token, forKey: "token_counter_check") //setObject
                            print("=======================")
                         //   print(UserDefaults.standard.set(token, forKey: "token_counter_check"))
                            UserDefaults.standard.set("token" + "  " + token, forKey: "token") //setObject
                            if self.count2 == 20{
                                 self.count2 += 21
                                 print("&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&")
                                 self.activity_log_parent()
                             }else{
                                 print("😊😊😊😊😊😊😊")
                             }
                            self.performSegue(withIdentifier: "otp_to_parentdashboard", sender: nil)//FOR CHECK
                            print("hello")
                        }
                       }else{
                      //  let error = json["error"].string
                      //  if let error1 = json["error"].string{
                            self.otp_errror.isHidden = false
                            self.otp_errror.text = Details
                      //  }
                    }
        }
   
    else{    ////newly added
            if let token = json["token"].string{
              //  let json = JSON(value).arrayValue
                print(token)
                if AppDelegate.Nexdha_student.usertype_otp == "junior"  {
                   
                    self.otp_errror.isHidden = true
                    self.otp_errror.text = Details
                 //   otp_errror.textColor = UIColor(red: 0.00, green: 1.00, blue: 0.20, alpha: 1.00)
                   // self.otp_errror.text = token
                    //self.otp_errror.isHidden = false
                   // self.Toast(Title: "Number does not exists please signup", Text: "You will be redirected to Signup page", delay: 2)
                    print("A!!")
                   // UserDefaults.standard.set(token, forKey: "token_counter_check") //setObject
                    print("=======================")
                  //  print(UserDefaults.standard.set(token, forKey: "token_counter_check"))
                    UserDefaults.standard.set("token" + "  " + token, forKey: "token") //setObject
                    print(UserDefaults.standard.set("token" + "  " + token, forKey: "token"))
                    print("-------------------------------------------------")
                    if self.count1 == 15{
                        self.count1 += 16
                        print("&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&")
                        self.activity_log_student()
                    }else{
                        print("😊😊😊😊😊😊😊")
                    }
                   // self.performSegue(withIdentifier: "otp_tab", sender: nil)//FOR CHECK
                    self.performSegue(withIdentifier: "otp_to_onboard", sender: nil)//FOR CHECK

                    print("hello")
                }
                else if AppDelegate.Nexdha_student.usertype_otp == "parent"{
                  
                    self.otp_errror.isHidden = true
                    self.otp_errror.text = Details
                 //   otp_errror.textColor = UIColor(red: 0.00, green: 1.00, blue: 0.20, alpha: 1.00)
                   // self.otp_errror.text = token
                    //self.otp_errror.isHidden = false
                   // self.Toast(Title: "Number does not exists please signup", Text: "You will be redirected to Signup page", delay: 2)
                    print("A22222")
                  //  UserDefaults.standard.set(token, forKey: "token_counter_check") //setObject
                    print("=======================")
                 //   print(UserDefaults.standard.set(token, forKey: "token_counter_check"))
                    UserDefaults.standard.set("token" + "  " + token, forKey: "token") //setObject
                   // self.performSegue(withIdentifier: "otp_to_parentdashboard", sender: nil)//FOR CHECK
                    if self.count2 == 20{
                        self.count2 += 21
                        print("&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&")
                        self.activity_log_parent()
                    }else{
                        print("😊😊😊😊😊😊😊")
                    }
                    self.performSegue(withIdentifier: "otp_to_onboard", sender: nil)//FOR CHECK

                    print("hello")
                }
               }else{
              //  let error = json["error"].string
              //  if let error1 = json["error"].string{
                    self.otp_errror.isHidden = false
                    self.otp_errror.text = Details
              //  }
            }
        }
}
else if Details == "OTP does not match"{
    self.otp_errror.isHidden = false
    self.otp_errror.text = Details
}

                case.failure(let error):
                    print(error)
                }
                       }
    }
    
    public func activity_log_parent(){
        let headers: HTTPHeaders = [
            .authorization(UserDefaults.standard.string(forKey: "token") as! String)
        ]
        
        let parameters = ["activity_id": "109" ,"os": "iOS"]

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
    public func activity_log_student(){
        let headers: HTTPHeaders = [
            .authorization(UserDefaults.standard.string(forKey: "token") as! String)
        ]
        
        let parameters = ["activity_id": "110" ,"os": "iOS"]

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
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
           
       var maxLength : Int = 0
           
           if textField == otp_enter{
               maxLength = 6
           }
          
           let currentString: NSString = textField.text! as NSString
           
           let newString: NSString =  currentString.replacingCharacters(in: range, with: string) as NSString
           return newString.length <= maxLength
       }
    public func resend_verify_login(){

     
        let userphone =  AppDelegate.Nexdha_student.login_phone_number
       // let inputString = "9488451373"
        let inputString1 = "kmKHO0vpCxUK5m9fAs0Z"
        let inputString2 = userphone + inputString1
        print(inputString2)
        let inputData = Data(inputString2.utf8)
        let hashed = SHA512.hash(data: inputData)
        print(hashed.description)
        let hash = hashed.compactMap { String(format: "%02x", $0) }.joined()
        print(hash)
        let parameters = ["phone": userphone.replacingOccurrences(of: " ", with: "", options: .regularExpression),"hash_login": hash.replacingOccurrences(of: " ", with: "", options: .regularExpression)]
        debugPrint(parameters)
                
               AF.request(AppDelegate.Nexdha_student.server+"/api/login", method: .post, parameters: parameters).responseJSON { response in
                           //debugPrint(response)
                switch response.result{
                case .success(let value):
                    let json = JSON(value)
                    print("a1")
                    print(json)
                    print("a23")
                    let status = json["status"].string
                   // if let token = json["kyc"].string{
                      //  let json = JSON(value).arrayValue
                        if status == "Number not available"  {
                            print("a22")
                        /*    self.animations?.stop()
                            self.animations.isHidden = true
                            self.logg_error.text = status
                            self.logg_error.isHidden = false
                         //   self.Toast(Title: "Number does not exists please signup", Text: "You will be redirected to Signup page", delay: 2)
                            self.showToast(controller: self, message : "Number does not exists please signup", seconds: 2.0)*/
                        }else{
                            print("enter")
                            print(userphone)
                            UserDefaults.standard.set(userphone, forKey: "number")
                            print(userphone)
                           /* self.animations?.stop()
                            self.animations.isHidden = true
                            self.performSegue(withIdentifier: "login_to_otp", sender: nil)*/
                          
                          //  debugPrint(token)
                         //   UserDefaults.standard.set("token  "+token, forKey: "usertoken")
//debugPrint("Done")
                         //   self.performSegue(withIdentifier: "logintootp", sender: self)
                                                   
                        }
                       
                        
                    
                case.failure(let error):
                    print(error)
                }
                       }
    }
    @IBAction func logg_to_dash(_ sender: Any) {
      //  verify_otp()
     //   otpedit_box.resignFirstResponder()
        if(otp_errror.text == ""){
            otp_errror.text = "Enter OTP"
            otp_errror.isHidden = false
            otp_enter.becomeFirstResponder()
               }
        else{
                verify_otp()
               }
        }
        
    }
    
   func Toast(Title:String ,Text:String, delay:Int) -> Void {
       let alert = UIAlertController(title: Title, message: Text, preferredStyle: .alert)
      // self.present(alert, animated: true)
       let deadlineTime = DispatchTime.now() + .seconds(delay)
       DispatchQueue.main.asyncAfter(deadline: deadlineTime, execute: {
           alert.dismiss(animated: true, completion: nil)
        //   self.performSegue(withIdentifier: "singup_from_log", sender: self)
       })
   }




extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
