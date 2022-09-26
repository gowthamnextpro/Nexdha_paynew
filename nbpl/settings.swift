//
//  settings.swift
//  nbpl
//
//  Created by Nexdha on 09/06/22.
//

import Foundation
import UIKit
import Alamofire
import AVFoundation
import SwiftyJSON
import TTGSnackbar

class settings: UIViewController , UITextFieldDelegate{
    @IBOutlet weak var view_ofone: UIView!
    @IBOutlet weak var view_of_two: UIView!
    @IBOutlet weak var view_of_three: UIView!
    @IBOutlet weak var view_of_four: UIView!
    @IBOutlet weak var view_of_five: UIView!
    @IBOutlet weak var view_of_seven: UIView!
    
    @IBOutlet weak var b2: UILabel!
    @IBOutlet weak var b1: UILabel!
    @IBOutlet weak var kyced: UILabel!
    @IBOutlet weak var edit_name: UIButton!
    @IBOutlet weak var mobile_color: UILabel!
    @IBOutlet weak var email_color: UILabel!
    @IBOutlet weak var name_color: UILabel!
    
    @IBOutlet weak var k_color: UILabel!
    @IBOutlet weak var view_of_eight: UIView!
    @IBOutlet weak var view_of_six: UIView!
    @IBOutlet weak var terms_condition: UILabel!
    @IBOutlet weak var privacy_policy: UILabel!
    @IBOutlet weak var logout: UIButton!
    @IBOutlet weak var edit: UIButton!
    @IBOutlet weak var kyc_status: UILabel!
    @IBOutlet weak var mail_id: UILabel!
    @IBOutlet weak var mobile_number: UILabel!
    @IBOutlet weak var displayusername: UILabel!
    @IBOutlet weak var support_call: UILabel!
    var webview_send: String = ""
    var count = 0
    var count1 = 3

    @IBOutlet weak var settings_head: UILabel!
    @IBOutlet weak var support_colors: UILabel!
    @IBOutlet weak var privacy_color: UILabel!
    @IBOutlet weak var terms_color: UILabel!
    @IBOutlet weak var supportcolor: UILabel!
    @IBOutlet weak var verified: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
   /*     let attributedString = NSMutableAttributedString.init(string: "")
        // Add Underline Style Attribute.
        attributedString.addAttribute(NSAttributedString.Key.underlineStyle, value: 1, range:
            NSRange.init(location: 0, length: attributedString.length));
        kyc_status.attributedText = attributedString*/
        
        
        
        settings_head.textColor = UIColor(red: 1.00, green: 1.00, blue: 1.00, alpha: 1.00)
        displayusername.textColor = UIColor(red: 1.00, green: 1.00, blue: 1.00, alpha: 1.00)
        mobile_number.textColor = UIColor(red: 1.00, green: 1.00, blue: 1.00, alpha: 1.00)
        mail_id.textColor = UIColor(red: 1.00, green: 1.00, blue: 1.00, alpha: 1.00)
       support_call.textColor = UIColor(red: 0.01, green: 0.85, blue: 0.77, alpha: 1.00)
      //  edit_name.currentTitleColor = UIColor(red: 0.01, green: 0.85, blue: 0.77, alpha: 1.00)
        kyc_status.textColor =  UIColor(red: 0.01, green: 0.85, blue: 0.77, alpha: 1.00)
      //  kyc_status.textColor =  UIColor(red: 0.01, green: 0.85, blue: 0.77, alpha: 1.00)
        terms_color.textColor =  UIColor(red: 0.01, green: 0.85, blue: 0.77, alpha: 1.00)
        privacy_color.textColor =  UIColor(red: 0.01, green: 0.85, blue: 0.77, alpha: 1.00)
        
        
        view_ofone.backgroundColor = UIColor(red: 0.18, green: 0.18, blue: 0.18, alpha: 1.00)
        view_of_two.backgroundColor = UIColor(red: 0.18, green: 0.18, blue: 0.18, alpha: 1.00)
        view_of_three.backgroundColor = UIColor(red: 0.18, green: 0.18, blue: 0.18, alpha: 1.00)
      //  view_of_four.backgroundColor = UIColor(red: 0.18, green: 0.18, blue: 0.18, alpha: 1.00)
        view_of_five.backgroundColor = UIColor(red: 0.18, green: 0.18, blue: 0.18, alpha: 1.00)
        view_of_seven.backgroundColor = UIColor(red: 0.18, green: 0.18, blue: 0.18, alpha: 1.00)
        b1.textColor = UIColor(red: 0.60, green: 0.60, blue: 0.60, alpha: 1.00)
        email_color.textColor = UIColor(red: 0.60, green: 0.60, blue: 0.60, alpha: 1.00)
        name_color.textColor = UIColor(red: 0.60, green: 0.60, blue: 0.60, alpha: 1.00)
        mobile_color.textColor = UIColor(red: 0.60, green: 0.60, blue: 0.60, alpha: 1.00)
        kyced.textColor = UIColor(red: 1.00, green: 1.00, blue: 1.00, alpha: 1.00)
        support_colors.textColor = UIColor(red: 1.00, green: 1.00, blue: 1.00, alpha: 1.00)
     /*   let blurEffect = UIBlurEffect(style: .light)
        // 3
        let blurView = UIVisualEffectView(effect: blurEffect)
        // 4
        blurView.translatesAutoresizingMaskIntoConstraints = false
        view.insertSubview(blurView, at: 0)*/
        profileinfo()
        logout.layer.borderWidth = 1
        logout.layer.cornerRadius = 25
        logout.layer.borderColor = UIColor.red.cgColor
        
     
        let terms = UITapGestureRecognizer(target: self, action: #selector(terms_condition(_:)))
        terms_condition.addGestureRecognizer(terms)
        
        let support_click_variable = UITapGestureRecognizer(target: self, action: #selector(supportclicked(_:)))
        support_call.addGestureRecognizer(support_click_variable)
        
        
        let privacy = UITapGestureRecognizer(target: self, action: #selector(privacy(_:)))
        privacy_policy.addGestureRecognizer(privacy)
        counter_check()

        
        let kyced = UITapGestureRecognizer(target: self, action: #selector(kyced(_:)))
        kyc_status.addGestureRecognizer(kyced)
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
      counter_check()
      super.viewWillAppear(animated)
    }
    @objc func kyced(_ sender: Any){
        self.performSegue(withIdentifier: "settings_student_to_kyc", sender: nil)
    }
    @objc func privacy(_ sender: Any){
        if let link = URL(string: "https://www.machpay.nexdha.com/_files/ugd/323de2_1cff3d0238e04205a0be7ab3084957b6.pdf") {
          UIApplication.shared.open(link)
        }
    }
    @objc func terms_condition(_ sender: Any){
        self.performSegue(withIdentifier: "studentsettings_to_terms", sender: nil)

       
       }
    @objc func supportclicked(_ sender: Any) {
        let alert = UIAlertController(title: "Support", message: "Please contact nexdha support at support@nexdha.com or call us at 8667451930 (09AM - 07PM)", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
    @IBAction func LOGOUT(_ sender: Any) {
        //Toast(Title: "DONE", Text: "User Defaults Cleared", delay: 3)
        let alertController = UIAlertController(title: "Logout!", message: "Are you sure you want to logout of Nexdha Pay?", preferredStyle: .alert)
            // Create the actions
        let cancelAction = UIAlertAction(title: "NO,STAY", style: UIAlertAction.Style.default) {
                UIAlertAction in
                NSLog("Cancel Pressed")
            }
        let okAction = UIAlertAction(title: "YES,SURE", style: UIAlertAction.Style.default) {
                UIAlertAction in
         //   UserDefaults.standard.removeObject(forKey: "token")
         //   self.performSegue(withIdentifier: "settings_to_home", sender: nil)
            self.logout_api()
            NSLog("OK Pressed")
            }
      

            // Add the actions
            alertController.addAction(cancelAction)
            alertController.addAction(okAction)

            // Present the controller
        self.present(alertController, animated: true, completion: nil)
    }
    @IBAction func edits_all(_ sender: Any) {
        let snackbar = TTGSnackbar(message: "coming soon...", duration: .short) //check hide
        snackbar.show()
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
           return .lightContent
       }
    
    public func logout_api(){
        let headers: HTTPHeaders = [
            .authorization(UserDefaults.standard.string(forKey: "token") as! String)
        ]
        AF.request(AppDelegate.Nexdha_student.server+"/api/veliye", method: .post, headers: headers).responseJSON { response in
            switch response.result{
                          case .success(let value):
                              let json = JSON(value)
                              let get = json["status"].stringValue
                                print(get)
                                if get == "changed"{
                                    if self.count1 == 3{
                                            self.count1 += 4
                                            print("&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&")
                                            self.activity_log_1()
                                    }else{
                                            print("😊😊😊😊😊😊😊")
                                    }
                                    print("clear")
                                    UserDefaults.standard.removeObject(forKey: "token")
                                    UserDefaults.standard.removeObject(forKey: "number")
                                    self.performSegue(withIdentifier: "settings_to_home", sender: nil)
                                    print("a45465")
                                   
                                }else{
                                    print("a3")
                                }
                              
                          case.failure(let error):
                              print(error)
                          }
               }
    }
    public func activity_log(){
        let headers: HTTPHeaders = [
            .authorization(UserDefaults.standard.string(forKey: "token") as! String)
        ]
        
        let parameters = ["activity_id": "102" ,"os": "iOS"]

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
    public func activity_log_1(){
        let headers: HTTPHeaders = [
            .authorization(UserDefaults.standard.string(forKey: "token") as! String)
        ]
        
        let parameters = ["activity_id": "108" ,"os": "iOS"]

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
        //   let headers: HTTPHeaders = [
        //       .authorization(UserDefaults.standard.string(forKey: "token_counter_check") as! String)
        //   ]
        print("ak")
        print(UserDefaults.standard.string(forKey: "token"))
        print("ak1")
     //   let Auth_header    = [ "Authorization" : UserDefaults.standard.string(forKey: "token_counter_check") ]
        let tokenData =  UserDefaults.standard.string(forKey: "token")
        print(tokenData)
   
         let newString = tokenData!.replacingOccurrences(of: "token", with: "", options: .literal, range: nil)
         print(newString)

        let headers : HTTPHeaders = [
         "Auth": newString,
        ]

         //  UserDefaults.standard.set(token, forKey: "token_counter_check") //setObject

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
                       }else{
                           if self.count == 0{
                               self.count += 1
                               print("&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&")
                               self.activity_log()
                           }else{
                               print("😊😊😊😊😊😊😊")
                           }
                       }
                   }else if status == "Invalid token" || status == "0"{
                       self.Toast1(Title: "Session Expired", Text: "Please login again", delay: 3)
                       UserDefaults.standard.removeObject(forKey: "token")
                       UserDefaults.standard.removeObject(forKey: "number")
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
            self.performSegue(withIdentifier: "settings_to_home", sender: nil)
        })
    }
    func toast_kyc(Title:String ,Text:String, delay:Int) -> Void {
        let alert = UIAlertController(title: Title, message: Text, preferredStyle: .alert)
        self.present(alert, animated: true)
        let deadlineTime = DispatchTime.now() + .seconds(delay)
        DispatchQueue.main.asyncAfter(deadline: deadlineTime, execute: {
            alert.dismiss(animated: true, completion: nil)
        })
    }
    public func profileinfo(){

        let headers: HTTPHeaders = [
            .authorization(UserDefaults.standard.object(forKey: "token") as! String)
        ]
        AF.request(AppDelegate.Nexdha_student.server+"/api/getuserdetails2", method: .post, headers: headers).responseJSON { response in
           
            switch response.result{
                          case .success(let value):
                              let json = JSON(value)
                              debugPrint(json)
                              let u_name = json["name"].stringValue
                              AppDelegate.Nexdha_student.name = u_name
                              let u_phone = json["phone"].stringValue
                              AppDelegate.Nexdha_student.phone = u_phone
                              let u_email = json["email"].stringValue
                              AppDelegate.Nexdha_student.email = u_email
                              let u_id = json["id"].stringValue
                              AppDelegate.Nexdha_student.user_id = u_id
                              AppDelegate.Nexdha_student.kyc = json["kyc"].stringValue
                            let bill1 = json["billdate1"].stringValue
                            AppDelegate.Nexdha_student.Billdate1 = bill1
                            let bill2 = json["billdate2"].stringValue
                            AppDelegate.Nexdha_student.Billdate2 = bill2
                             self.displayusername.text = AppDelegate.Nexdha_student.name
                             self.mail_id.text = AppDelegate.Nexdha_student.email
                             self.mobile_number.text = AppDelegate.Nexdha_student.phone
                if AppDelegate.Nexdha_student.Billdate1 == "0"{
                    self.b2.text =  "N/A"
                    self.b2.textColor = UIColor(red: 0.15, green: 0.44, blue: 0.92, alpha: 1.00)
                }else if AppDelegate.Nexdha_student.Billdate2 == "0"{
                    self.b2.text =  "N/A"
                    self.b2.textColor = UIColor(red: 0.15, green: 0.44, blue: 0.92, alpha: 1.00)
                }else{
                    self.b2.text = AppDelegate.Nexdha_student.Billdate1 + " and " + AppDelegate.Nexdha_student.Billdate2 +  " of Every Month "
                   self.b2.textColor =  UIColor(red: 0.94, green: 0.21, blue: 0.21, alpha: 1.00)
                }
                if AppDelegate.Nexdha_student.kyc == "N.V"{
                    self.kyc_status.isUserInteractionEnabled = true
                    self.kyc_status.text = "Not verified"
                }else if AppDelegate.Nexdha_student.kyc == "P"{
                 //   self.toast_kyc(Title: "we'll notify you when it verified", Text: "", delay: 2)
                    self.kyc_status.isUserInteractionEnabled = false
                    self.kyc_status.text = "Pending"
                }else if AppDelegate.Nexdha_student.kyc == "V"{
                    self.kyc_status.text = "Verified"
                    self.kyc_status.isUserInteractionEnabled = false
                }else{
                    self.kyc_status.isUserInteractionEnabled = true
                    self.kyc_status.text = "Retry"
                }
                
                          case.failure(let error):
                              print(error)
                          }
               }
    }
}
