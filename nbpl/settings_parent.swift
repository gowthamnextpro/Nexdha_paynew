//
//  settings_parent.swift
//  nbpl
//
//  Created by Nexdha on 20/06/22.
//

import Foundation
import UIKit
import Foundation
import Alamofire
import SwiftyJSON
import Lottie
import CryptoKit
import TTGSnackbar

class settings_parent: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var add_teen: UIButton!
    @IBOutlet weak var terms_conditions: UILabel!
    @IBOutlet weak var privacy: UILabel!
    @IBOutlet weak var kyc_status: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var phone: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var viewjuniors_only: UILabel!
    @IBOutlet weak var support_call: UILabel!
    @IBOutlet weak var edit: UIButton!
    @IBOutlet weak var logout: UIButton!

    @IBOutlet weak var b_date: UILabel!
    @IBOutlet weak var b11: UILabel!
    
    
    @IBOutlet weak var email_address: UILabel!
    @IBOutlet weak var mobile_nmber: UILabel!
    @IBOutlet weak var name_head: UILabel!
    
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var view3: UIView!
    @IBOutlet weak var view4: UIView!
    @IBOutlet weak var view5: UIView!
    @IBOutlet weak var view6: UIView!
    @IBOutlet weak var view7: UIView!
    @IBOutlet weak var view8: UIView!
    @IBOutlet weak var view9: UIView!
    @IBOutlet weak var view10: UIView!
    
    @IBOutlet weak var kyc: UILabel!
    @IBOutlet weak var support: UILabel!
    
    var count = 0
    var count1 = 3

    override func viewDidLoad() {
        super.viewDidLoad()
      //  main_view_anim.layer.
        let paying = UITapGestureRecognizer(target: self, action: #selector(pay_back_clicked(_:)))
        viewjuniors_only.addGestureRecognizer(paying)
        
        let support_click_variable = UITapGestureRecognizer(target: self, action: #selector(privacy(_:)))
        privacy.addGestureRecognizer(support_click_variable)
        
        let terms = UITapGestureRecognizer(target: self, action: #selector(terms_condition(_:)))
        terms_conditions.addGestureRecognizer(terms)
        
        let support_click_variable_one = UITapGestureRecognizer(target: self, action: #selector(supportclicked(_:)))
        support_call.addGestureRecognizer(support_click_variable_one)
        
        
        
        let kyc_page = UITapGestureRecognizer(target: self, action: #selector(kyc(_:)))
        kyc_status.addGestureRecognizer(kyc_page)
        
        
        
        view1.backgroundColor = UIColor(red: 0.18, green: 0.18, blue: 0.18, alpha: 1.00)
        view2.backgroundColor = UIColor(red: 0.18, green: 0.18, blue: 0.18, alpha: 1.00)
        view3.backgroundColor = UIColor(red: 0.18, green: 0.18, blue: 0.18, alpha: 1.00)
        view5.backgroundColor = UIColor(red: 0.18, green: 0.18, blue: 0.18, alpha: 1.00)
        view6.backgroundColor = UIColor(red: 0.18, green: 0.18, blue: 0.18, alpha: 1.00)
        view7.backgroundColor = UIColor(red: 0.18, green: 0.18, blue: 0.18, alpha: 1.00)
        view8.backgroundColor = UIColor(red: 0.18, green: 0.18, blue: 0.18, alpha: 1.00)
        view9.backgroundColor = UIColor(red: 0.18, green: 0.18, blue: 0.18, alpha: 1.00)
        view10.backgroundColor = UIColor(red: 0.18, green: 0.18, blue: 0.18, alpha: 1.00)

        privacy.textColor =  UIColor(red: 0.01, green: 0.85, blue: 0.77, alpha: 1.00)
        terms_conditions.textColor =  UIColor(red: 0.01, green: 0.85, blue: 0.77, alpha: 1.00)
        viewjuniors_only.textColor =  UIColor(red: 0.01, green: 0.85, blue: 0.77, alpha: 1.00)
        kyc_status.textColor =  UIColor(red: 0.01, green: 0.85, blue: 0.77, alpha: 1.00)
        support_call.textColor =  UIColor(red: 0.01, green: 0.85, blue: 0.77, alpha: 1.00)
        

        kyc.textColor = UIColor(red: 0.60, green: 0.60, blue: 0.60, alpha: 1.00)
        support.textColor = UIColor(red: 0.60, green: 0.60, blue: 0.60, alpha: 1.00)


        name_head.textColor = UIColor(red: 0.60, green: 0.60, blue: 0.60, alpha: 1.00)
        b11.textColor = UIColor(red: 0.60, green: 0.60, blue: 0.60, alpha: 1.00)
        
        email_address.textColor = UIColor(red: 0.60, green: 0.60, blue: 0.60, alpha: 1.00)
        mobile_nmber.textColor = UIColor(red: 0.60, green: 0.60, blue: 0.60, alpha: 1.00)
        
        
        add_teen.applyGradient(colors: [UIColor(red: 0.24, green: 0.08, blue: 0.58, alpha: 1.00).cgColor, UIColor.magenta.cgColor])
        logout.layer.borderWidth = 1
        logout.layer.cornerRadius = 25
        logout.layer.borderColor = UIColor.red.cgColor
        profile_parent()
      //  add_teen.isHidden = true
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
        
        let parameters = ["activity_id": "202" ,"os": "iOS"]

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
            self.performSegue(withIdentifier: "settings_parent", sender: nil)
        })
    }

    @IBAction func edit(_ sender: Any) {
        let snackbar = TTGSnackbar(message: "coming soon...", duration: .short) //check hide
        snackbar.show()
    }
    
    
    @IBAction func logout(_ sender: Any) {
        let alertController = UIAlertController(title: "Logout!", message: "Are you sure you want to logout of Nexdha Pay?", preferredStyle: .alert)

            // Create the actions
        let cancelAction = UIAlertAction(title: "NO,STAY", style: UIAlertAction.Style.default) {
                UIAlertAction in
                NSLog("Cancel Pressed")
            }
        let okAction = UIAlertAction(title: "YES,SURE", style: UIAlertAction.Style.default) {
                UIAlertAction in
            self.logout_api()
                NSLog("OK Pressed")
            }
      

            // Add the actions
            alertController.addAction(cancelAction)
            alertController.addAction(okAction)

            // Present the controller
        self.present(alertController, animated: true, completion: nil)
    }
    @objc func privacy(_ sender: Any){
        if let link = URL(string: "https://www.machpay.nexdha.com/_files/ugd/323de2_1cff3d0238e04205a0be7ab3084957b6.pdf") {
          UIApplication.shared.open(link)
        }
    }
    @objc func kyc(_ sender: Any){
        // self.toast_kyc(Title: "we'll notify you when it verified", Text: "", delay: 2)

        self.performSegue(withIdentifier: "settings_to_kyc", sender: nil)
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
                                    print("clear")
                                    if self.count1 == 3{
                                            self.count1 += 4
                                            print("&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&")
                                            self.activity_log_1()
                                    }else{
                                            print("😊😊😊😊😊😊😊")
                                    }
                                    UserDefaults.standard.removeObject(forKey: "token")
                                    UserDefaults.standard.removeObject(forKey: "number")
                                    self.performSegue(withIdentifier: "settings_homescreen", sender: nil)
                                    print("a45465")
                                   
                                }else{
                                    print("a3")
                                }
                              
                          case.failure(let error):
                              print(error)
                          }
               }
    }
    @objc func terms_condition(_ sender: Any){
       // webview_send = "https://www.bnpl.nexdha.com/_files/ugd/323de2_cdb95dcb0b5c4956a073063a8d2771d6.pdf"
       // self.performSegue(withIdentifier: "settings_to_webview", sender: nil)
       /* let myNormalString = "https://www.bnpl.nexdha.com/_files/ugd/323de2_cdb95dcb0b5c4956a073063a8d2771d6.pdf";
        let myEscapedString = myNormalString.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!*/
        self.performSegue(withIdentifier: "settingsparents_to_terms", sender: nil)

       }
    @objc func supportclicked(_ sender: Any) {
        let alert = UIAlertController(title: "Support", message: "Please contact nexdha support at support@nexdha.com or call us at 8667451930 (09AM - 07PM)", preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))

        self.present(alert, animated: true)
        
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
           return .lightContent
       }
    func toast_kyc(Title:String ,Text:String, delay:Int) -> Void {
        let alert = UIAlertController(title: Title, message: Text, preferredStyle: .alert)
        self.present(alert, animated: true)
        let deadlineTime = DispatchTime.now() + .seconds(delay)
        DispatchQueue.main.asyncAfter(deadline: deadlineTime, execute: {
            alert.dismiss(animated: true, completion: nil)
        })
    }
    @IBAction func addstudent(_ sender: Any) {
        if AppDelegate.Nexdha_student.kyc == "V"{
            self.performSegue(withIdentifier: "settings_to_addstudent", sender: nil)
        }else{
            let alert = UIAlertController(title: "KYC", message: "Please verify the KYC and proceed", preferredStyle: .alert)
                       debugPrint("This is three")
                       self.present(alert, animated: true)
        }
       
    }
    @objc func pay_back_clicked(_ sender: Any){
       self.performSegue(withIdentifier: "settingsparent_viewjunior", sender: nil)
       }
    public func profile_parent(){

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
                             self.name.text = AppDelegate.Nexdha_student.name
                             self.email.text = AppDelegate.Nexdha_student.email
                             self.phone.text = AppDelegate.Nexdha_student.phone
                
                if AppDelegate.Nexdha_student.Billdate1 == "0"{
                    self.b_date.text =  "N/A"
                    self.b_date.textColor = UIColor(red: 0.15, green: 0.44, blue: 0.92, alpha: 1.00)
                }else if AppDelegate.Nexdha_student.Billdate2 == "0"{
                    self.b_date.text =  "N/A"
                    self.b_date.textColor = UIColor(red: 0.15, green: 0.44, blue: 0.92, alpha: 1.00)
                }else{
                    self.b_date.text = AppDelegate.Nexdha_student.Billdate1 + " and " + AppDelegate.Nexdha_student.Billdate2 +  " of Every Month "
                   self.b_date.textColor =  UIColor(red: 0.94, green: 0.21, blue: 0.21, alpha: 1.00)
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
