//
//  ViewController.swift
//  nbpl
//
//  Created by Nexdha on 02/06/22.
//

import UIKit
import Foundation
import Alamofire
import SwiftyJSON
import LocalAuthentication

class ViewController: UIViewController {
    var context = LAContext()
    var error: NSError?
    var count1 = 15
    var count2 = 20
    var appVersion = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        appVersion = (Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String)!
                 debugPrint("This is app version")
                 debugPrint(appVersion)
        DispatchQueue.main.async { [unowned self] in
          //self.performSegue(withIdentifier: "opendashboard", sender: self)
            print(UserDefaults.standard.string(forKey: "token"))
            if(UserDefaults.standard.string(forKey: "token")) != nil{
                print("1")
                counter_check()
              //  self.performSegue(withIdentifier: "verification_to_dashboard", sender: self)
                print("2")
            }else{
               self.performSegue(withIdentifier: "viewcontroller_to_home", sender: self)///// for onboarding checking
            //    self.performSegue(withIdentifier: "view_to_onboarding", sender: self)

            }
        }
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
           return .lightContent
       }
    @IBAction func logg(_ sender: Any) {
        self.performSegue(withIdentifier: "viewcontroller_to_home", sender: nil)
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
                                      self.present(alert, animated: true)
                       }
                       else if status1 == "1"{
                           self.checking_user()
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
            self.performSegue(withIdentifier: "viewcontroller_to_homescreen", sender: nil)
        })
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
    public func check(){
        let reason = "Identify yourself!"
           context.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: reason ) { success, error in
                     if success {
                       DispatchQueue.main.async { [unowned self] in
                         //self.performSegue(withIdentifier: "opendashboard", sender: self)
                           self.performSegue(withIdentifier: "verification_to_dashboard", sender: self)
                       }
                      debugPrint("Success")
                    } else {
                       debugPrint("error")
                       debugPrint(error?.localizedDescription ?? "Failed to authenticate")
                       let err = error?.localizedDescription ?? "Failed to authenticate"
                       if err == "Passcode not set."{
                           debugPrint("no passcode")
                           //self.performSegue(withIdentifier: "opendashboard", sender: self)
                          // self.verify_version()
                           debugPrint("some other error")
                           let alert = UIAlertController(title: "NEXDHA Pay secure", message: "Authentication is required to secure your financial data", preferredStyle: .alert)
                            debugPrint("This is three")

                           alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: { action in
                              // self.viewWillAppear(true)

                           }))
                            self.present(alert, animated: true)
                       }else{
                           DispatchQueue.main.async {
                              // UI work here
                               let alert = UIAlertController(title: "NEXDHA Pay secure", message: "Authentication is required to secure your financial data", preferredStyle: .alert)
                                debugPrint("This is three")

                               alert.addAction(UIAlertAction(title: "Try Again", style: .default, handler: { action in
                                  // self.viewWillAppear(true)
                                   self.check()
                               }))
                                self.present(alert, animated: true)
                           }
                       }
                    }
               }
    }
 public func check1(){
        let reason = "Identify yourself!"

           context.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: reason ) { success, error in

                     if success {
                       DispatchQueue.main.async { [unowned self] in
                         //self.performSegue(withIdentifier: "opendashboard", sender: self)
                           self.performSegue(withIdentifier: "viewcontroller_to_parentdashboard", sender: self)
                       }
                      debugPrint("Success")
                    } else {
                       debugPrint("error")
                       debugPrint(error?.localizedDescription ?? "Failed to authenticate")
                       let err = error?.localizedDescription ?? "Failed to authenticate"
                       if err == "Passcode not set."{
                           debugPrint("no passcode")
                           //self.performSegue(withIdentifier: "opendashboard", sender: self)
                          // self.verify_version()
                           debugPrint("some other error")
                           let alert = UIAlertController(title: "NEXDHA Pay secure", message: "Authentication is required to secure your financial data", preferredStyle: .alert)
                            debugPrint("This is three")

                           alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: { action in
                              // self.viewWillAppear(true)

                           }))
                            self.present(alert, animated: true)
                       }else{
                           DispatchQueue.main.async {
                              // UI work here
                               let alert = UIAlertController(title: "NEXDHA Pay secure", message: "Authentication is required to secure your financial data", preferredStyle: .alert)
                                debugPrint("This is three")

                               alert.addAction(UIAlertAction(title: "Try Again", style: .default, handler: { action in
                                  // self.viewWillAppear(true)
                                   self.check1()
                               }))
                                self.present(alert, animated: true)
                               
                           }
                           
                       }
                   
                    }
               }
    }
    public func checking_user(){
        print("hello1234566789")
        let headers: HTTPHeaders = [
            .authorization(UserDefaults.standard.string(forKey: "token") as! String)
        ]
        
        
        let parameters = ["OS":"iOS"]
        AF.request(AppDelegate.Nexdha_student.server+"/api/user_type", method: .post, parameters: parameters, headers: headers).responseJSON { response in
           
            switch response.result{
                          case .success(let value):
                              let json = JSON(value)
                              debugPrint(json)
                              print("udaya")
                              let user_type = json["user_type"].stringValue
                              let version = json["version"].stringValue
                              AppDelegate.Nexdha_student.app_version = version
                              AppDelegate.Nexdha_student.type_of_user = user_type
                              print(AppDelegate.Nexdha_student.type_of_user)
                              let kyc_of_usertype = json["kyc"].stringValue
                              AppDelegate.Nexdha_student.kyc_of_usertype = kyc_of_usertype
                              print(AppDelegate.Nexdha_student.kyc_of_usertype)
                print(self.appVersion)
                print(AppDelegate.Nexdha_student.app_version)
                if AppDelegate.Nexdha_student.app_version == self.appVersion{
                    if AppDelegate.Nexdha_student.type_of_user == "junior" {
                        if self.count1 == 15{
                           self.count1 += 16
                           print("&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&")
                           self.activity_log_student()
                       }else{
                           print("😊😊😊😊😊😊😊")
                       }
                        print(UserDefaults.standard.string(forKey: "token"))
                        self.check()
                    }else if AppDelegate.Nexdha_student.type_of_user == "parent"{
                        if self.count2 == 20{
                             self.count2 += 21
                             print("&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&")
                             self.activity_log_parent()
                         }else{
                             print("😊😊😊😊😊😊😊")
                         }
                        print(UserDefaults.standard.string(forKey: "token"))
                        self.check1()
                    }else{
                        self.performSegue(withIdentifier: "viewcontroller_to_home", sender: self)
                    }
                }else{
                    print("Update")
                    let alertController = UIAlertController(title: "Update App", message:"This update includes several bug fixes and a few small Performance improvements", preferredStyle: .alert)
                                                       alertController.addAction(UIAlertAction(title: "Update", style: .default,handler: self.alertaction(_:)))
                                                       self.present(alertController, animated: true, completion: nil)
                }
              
                          case.failure(let error):
                              print(error)
                          }
               }
    }

    @objc func alertaction(_ sender: Any) {
        debugPrint("alert action")
        
        let alert = UIAlertController(title: "Notification", message: "We will Notify you soon", preferredStyle: .alert)
         debugPrint("This is three")

        alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: { action in
           // self.viewWillAppear(true)

        }))
         self.present(alert, animated: true)
       /*   if let url = URL(string: "https://apps.apple.com/in/app/nexdha/id1523650787"), !url.absoluteString.isEmpty {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }*/
        
    }
}

