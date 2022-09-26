//
//  split_page.swift
//  nbpl
//
//  Created by Nexdha on 14/07/22.
//

import Foundation
import UIKit
import Alamofire
import AVFoundation
import SwiftyJSON
import DynamicBottomSheet
import Then
import BLTNBoard
import CashfreePGCoreSDK
import CashfreePGUISDK
import CashfreePG
import CryptoKit
import Lottie


class split_page: UIViewController {
    @IBOutlet weak var b_total_paid: UILabel!
    @IBOutlet weak var total_paid_gw: UILabel!
    @IBOutlet weak var late_fee: UILabel!
    @IBOutlet weak var cs_fee: UILabel!
    @IBOutlet weak var pay_amts: UILabel!
    @IBOutlet weak var Goback: UIImageView!
    @IBOutlet weak var pay: UIButton!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var pay_stack: UIStackView!
    @IBOutlet weak var mainview: UIStackView!
    @IBOutlet weak var get_out: UIButton!
    @IBOutlet weak var animes: AnimationView!
    @IBOutlet weak var final_pay: UIStackView!
    
    var count = 0
    var count1 = 5
    var count2 = 10
    private let cfPaymentGatewayService = CFPaymentGatewayService.getInstance()
    override func viewDidLoad() {
        super.viewDidLoad()
        counter_check()
        self.cfPaymentGatewayService.setCallback(self)
        pay_stack.layer.cornerRadius = 25
        final_pay.layer.cornerRadius = 25
        pay.layer.cornerRadius = 25
        pay.clipsToBounds = true
        final_pay.layer.cornerRadius = 25
        final_pay.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        pay.new_grad(colors: [UIColor.magenta.cgColor, UIColor(red: 0.24, green: 0.08, blue: 0.58, alpha: 1.00).cgColor])
        let payment_back_var = UITapGestureRecognizer(target: self, action: #selector(pay_back_clicked(_:)))
        Goback.addGestureRecognizer(payment_back_var)
        print(AppDelegate.Nexdha_student.final_pay_GW)
        print(AppDelegate.Nexdha_student.total_amt)
        print(AppDelegate.Nexdha_student.name_bill_pay_parentdashboard)
        print(AppDelegate.Nexdha_student.late_fee)
        print(AppDelegate.Nexdha_student.bill_value)
        print(AppDelegate.Nexdha_student.percentage_bill_parent_to_student)
        print(AppDelegate.Nexdha_student.bill_number)
        b_total_paid.text = "₹" + " " + AppDelegate.Nexdha_student.final_pay_GW
        total_paid_gw.text = "₹" + " " + AppDelegate.Nexdha_student.final_pay_GW
        pay_amts.text = "₹" + " " + AppDelegate.Nexdha_student.total_amt
        late_fee.text = AppDelegate.Nexdha_student.late_fee
        cs_fee.text = AppDelegate.Nexdha_student.percentage_bill_parent_to_student + " %"
        name.text = AppDelegate.Nexdha_student.name_bill_pay_parentdashboard
    }
    override func viewWillAppear(_ animated: Bool) {
      counter_check()
      super.viewWillAppear(animated)
    }
    private func getSession() -> CFSession? {
           do {
               let session = try CFSession.CFSessionBuilder()
                   .setEnvironment(.PRODUCTION)
                   .setOrderID(AppDelegate.Nexdha_student.order_id)
                   .setOrderToken(AppDelegate.Nexdha_student.order_token)
                   .build()
               return session
           } catch let e {
               let error = e as! CashfreeError
               print(error.localizedDescription)
               // Handle errors here
           }
           return nil
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
            self.performSegue(withIdentifier: "split_to_homescreen", sender: nil)
        })
    }
    public func activity_log(){
        let headers: HTTPHeaders = [
            .authorization(UserDefaults.standard.string(forKey: "token") as! String)
        ]
        
        let parameters = ["activity_id": "207" ,"os": "iOS"]

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
      public func hash_generator(){
          let bill_number = AppDelegate.Nexdha_student.bill_number
          let inputString1 = "kmKHO0vpCxUK5m9fAs0Z"
          let inputString2 = bill_number + inputString1
          print(inputString2)
          let inputData = Data(inputString2.utf8)
          let hashed = SHA512.hash(data: inputData)
          print(hashed.description)
          let hash = hashed.compactMap { String(format: "%02x", $0) }.joined()
          print(hash)
          let headers: HTTPHeaders = [
              .authorization(UserDefaults.standard.object(forKey: "token") as! String)
          ]
          let parameters = ["bill_number": bill_number.replacingOccurrences(of: " ", with: "", options: .regularExpression),"name": hash.replacingOccurrences(of: " ", with: "", options: .regularExpression)]
          debugPrint(parameters)
          AF.request(AppDelegate.Nexdha_student.server+"/api/food_token", method: .post, parameters: parameters,headers: headers).responseJSON { response in
                             //debugPrint(response)
                  switch response.result{
                  case .success(let value):
                      let json = JSON(value)
                      print("a1")
                      print(json)
                      print("a23")
                      let order_id = json["order_id"].string
                      let order_token = json["order_token"].string
                      AppDelegate.Nexdha_student.order_id = order_id!
                      print(AppDelegate.Nexdha_student.order_id)
                      AppDelegate.Nexdha_student.order_token = order_token!
                      print(AppDelegate.Nexdha_student.order_token)
                    //  self.performSegue(withIdentifier: "splitup_to_pg", sender: nil)
                      if let session = self.getSession() {
                                  do {
                                    
                                      // Set Components
                                      let paymentComponents = try CFPaymentComponent.CFPaymentComponentBuilder()
                                          .enableComponents([
                                              "order-details",
                                              "card",
                                              "paylater",
                                              "wallet",
                                              "emi",
                                              "netbanking",
                                              "upi"
                                          ])
                                          .build()
                                      let theme = try CFTheme.CFThemeBuilder()
                                          .setNavigationBarBackgroundColor("#2d2d2d")
                                          .setNavigationBarTextColor("#FFFFFF")
                                          .setButtonBackgroundColor("#2d2d2d")
                                          .setButtonTextColor("#FFFFFF")
                                          .setPrimaryFont("Montserrat-Regular")
                                          .setSecondaryFont("Montserrat-Regular")
                                          .build()
                                      let nativePayment = try CFDropCheckoutPayment.CFDropCheckoutPaymentBuilder()
                                          .setSession(session)
                                          .setTheme(theme)
                                          .setComponent(paymentComponents)
                                          .build()
                                      try self.cfPaymentGatewayService.doPayment(nativePayment, viewController: self)
                                      
                                      
                                  } catch let e {
                                      let error = e as! CashfreeError
                                      print(error.localizedDescription)
                                      // Handle errors here
                                  }
                              }
                  case.failure(let error):
                      print(error)
                  }
                         }
      }
    public func activity_log_SUCCESS(){
        let headers: HTTPHeaders = [
            .authorization(UserDefaults.standard.string(forKey: "token") as! String)
        ]
        
        let parameters = ["activity_id": "208" ,"os": "iOS"]

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
    public func activity_log_FAILED(){
        let headers: HTTPHeaders = [
            .authorization(UserDefaults.standard.string(forKey: "token") as! String)
        ]
        
        let parameters = ["activity_id": "209" ,"os": "iOS"]

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
    override var preferredStatusBarStyle: UIStatusBarStyle {
           return .lightContent
       }
    @objc func pay_back_clicked(_ sender: Any){
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func proceed_to_pay(_ sender: Any) {
            if self.count == 0{
                self.count += 1
                print("&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&")
                self.activity_log()
            }else{
                print("😊😊😊😊😊😊😊")
            }
        hash_generator()


    }
  
    @objc func alertaction(_ sender: Any) {
                debugPrint("alert action")
                self.performSegue(withIdentifier: "split_dashboard", sender: self)
    }
    
    
    
}
extension split_page: CFResponseDelegate {
    func onError(_ error: CFErrorResponse, order_id: String) {
        print(error.message)
        if self.count1 == 5{
                self.count1 += 6
                print("Toni")
                self.activity_log_FAILED()
        }else{
                print("😊😊😊😊😊😊😊")
        }
        let alertController = UIAlertController(title:error.message, message: nil, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Close", style: .default,handler: self.alertaction(_:)))
        self.present(alertController, animated: true, completion: nil)
    }
    func verifyPayment(order_id: String) {
        print("!!!!!!!!!!!!!!!!!!!!!")
        print(order_id)
        print("=============================")
        if self.count2 == 10{
                self.count2 += 11
                print("&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&")
                self.activity_log_SUCCESS()
        }else{
                print("😊😊😊😊😊😊😊")
        }
        let alertController = UIAlertController(title:"Transaction Successful", message: nil, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Close", style: .default,handler: self.alertaction(_:)))
        self.present(alertController, animated: true, completion: nil)
    }
}
