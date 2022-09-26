//
//  enterupi.swift
//  nbpl
//
//  Created by Nexdha on 09/06/22.
//

import Foundation
import Alamofire
import SwiftyJSON
import AVFoundation
import Lottie
import CryptoKit


class enterupi: UIViewController, UITextFieldDelegate {
    var roomTextField: UITextField!
//    var animationView: AnimationView?
    @IBOutlet weak var anime: AnimationView!
    @IBOutlet weak var back: UIImageView!
    @IBOutlet weak var verify: UIButton!
    @IBOutlet weak var stacked: UIStackView!
    @IBOutlet weak var enter_upi: UITextField!
    @IBOutlet weak var verifiedorunverified: UILabel!
    var count = 0
    var userInput = ""
    var add_status   = ""
    var width = CGFloat(1.0)
    var border = CALayer()
    override var preferredStatusBarStyle: UIStatusBarStyle {
           return .lightContent
       }
    override func viewDidLoad() {
        super.viewDidLoad()
        anime.isHidden = true
     //   alertControllerWithTf()
        self.hideKeyboardWhenTappedAround()

        
      
        counter_check()
     //   indicator.isHidden = true
        verifiedorunverified.isHidden = true
        border.borderColor = UIColor(red: 0.41, green: 0.40, blue: 0.40, alpha: 1.00).cgColor
        border.frame = CGRect(x: 0, y: enter_upi.frame.size.height - width, width: enter_upi.frame.size.width, height: enter_upi.frame.size.height)
        border.borderWidth = width
        enter_upi.backgroundColor = UIColor.clear
        enter_upi.layer.addSublayer(border)
        enter_upi.layer.masksToBounds = true
        enter_upi.textColor = UIColor.white
        enter_upi.delegate = self
        enter_upi.attributedPlaceholder = NSAttributedString(string:"Enter UPI id to verify", attributes:[NSAttributedString.Key.foregroundColor: UIColor.lightGray])

        stacked.backgroundColor = UIColor(red: 0.10, green: 0.10, blue: 0.10, alpha: 1.00)
        stacked.layer.cornerRadius = 20
        verify.new_grad(colors: [UIColor.magenta.cgColor, UIColor(red: 0.24, green: 0.08, blue: 0.58, alpha: 1.00).cgColor])
        verify.layer.cornerRadius = 25
        verify.clipsToBounds = true
        
        
        
        
        
       let payment_back_var1 = UITapGestureRecognizer(target: self, action: #selector(logo_clicked(_:)))
          back.addGestureRecognizer(payment_back_var1)
    }
    @IBAction func verifying(_ sender: Any) {
        let enter_upiid = enter_upi.text
        if enter_upiid == ""{
            self.verifiedorunverified.textColor = UIColor(red: 255/255, green: 87/255, blue: 51/255, alpha: 1.00)
            verifiedorunverified.text = "Please Enter UPId"
            verifiedorunverified.isHidden = false
              // self.present(dialogMessage, animated: true, completion: nil)
        }else{
       //     self.animationview.isHidden = false
            self.hideKeyboardWhenTappedAround()
            self.Upi_trans()

        }
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
       // anime.isHidden = true
        //alertControllerWithTf()
    }
    @objc func logo_clicked(_ sender: Any){
        self.dismiss(animated: true, completion: nil)

    }
    func alertControllerWithTf(){
     //   animationview.isHidden = true
        let dialogMessage = UIAlertController(title: "Enter UPId", message: nil, preferredStyle: .alert)
        let cancel = UIAlertAction(title: "Cancel", style: .default) { (action) -> Void in
            print("Cancel button tapped")
            self.dismiss(animated: true, completion: nil)

        }
        let Create = UIAlertAction(title: "Verify", style: .default, handler: { (action) -> Void in
           
            if let userInput = self.roomTextField.text {
                let label = UILabel(frame: CGRect(x: 0, y: 40, width: 270, height:18))
                label.textAlignment = .center
                label.textColor = .red
                label.font = label.font.withSize(12)
                dialogMessage.view.addSubview(label)
                label.isHidden = true
                self.userInput = userInput
                print(self.userInput)
                print("apple")
                print(self.userInput)
                print("orange")
                print("Create button success block called do stuff here....")
                if self.userInput == ""{
                       label.text = "Please Enter UPId"
                       label.isHidden = false
                       self.present(dialogMessage, animated: true, completion: nil)

                }else{
               //     self.animationview.isHidden = false
                    self.Upi_trans()

                }
            /*    if self.userInput == ""{
                    label.text = "Enter UPI"
                    label.isHidden = false
                    self.present(dialogMessage, animated: true, completion: nil)

                }else if self.haveSameRoomName(createdRoomName: self.userInput){
                    label.text = "You've already created room with this name."
                    label.isHidden = false
                }else{
                    print(self.userInput)
                    print("apple")
                    print(self.userInput)
                    print("orange")
                    print("Create button success block called do stuff here....")
                }*/
            }
        })
       
      

        //Add OK and Cancel button to dialog message
        dialogMessage.addAction(cancel)
        dialogMessage.addAction(Create)
        // Add Input TextField to dialog message
        dialogMessage.addTextField { (textField) -> Void in
            self.roomTextField = textField
            self.roomTextField?.placeholder = "Enter UPId "
        }
        // Present dialog message to user
        self.present(dialogMessage, animated: true, completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
      counter_check()
      super.viewWillAppear(animated)
    }
    public func activity_log(){
        let headers: HTTPHeaders = [
            .authorization(UserDefaults.standard.string(forKey: "token") as! String)
        ]
        
        let parameters = ["activity_id": "103" ,"os": "iOS"]

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
                       
                   }else if status == "Invalid token"  || status == "0"{
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
            self.performSegue(withIdentifier: "enter_upi_to_home", sender: nil)
        })
    }
    func haveSameRoomName(createdRoomName: String) -> Bool{
        print("applesss")
        print(self.userInput)
        let allRoomNames =  self.userInput
        if allRoomNames.contains(createdRoomName){
            self.Upi_trans()
            return true
        }else{
            return false
        }
    }
    public func Upi_trans(){
        self.hideKeyboardWhenTappedAround()
        anime.isHidden = false
        anime?.contentMode = .scaleAspectFit
        anime?.loopMode =  .loop
        anime?.animationSpeed = 0.85
     //   animationview?.backgroundColor = UIColor(red: 0.00, green: 0.00, blue: 0.00, alpha: 1.00)
        anime?.play()
       // indicator.isHidden = false
       // indicator.startAnimating()
        debugPrint("this is upi")
        let headers: HTTPHeaders = [
            .authorization(UserDefaults.standard.object(forKey: "token") as! String)
                ]
        debugPrint(headers)
         print(userInput)
   //     let upi_trim = userInput
        let enter_upiid = enter_upi.text
        let inputString1 = "kmKHO0vpCxUK5m9fAs0Z"
        let inputString2 = "upi" + enter_upiid! + inputString1
        print(inputString2)
        let inputData = Data(inputString2.utf8)
        let hashed = SHA512.hash(data: inputData)
        print(hashed.description)
        let hash = hashed.compactMap { String(format: "%02x", $0) }.joined()
        print(hash)
        
        let upi = enter_upiid!.replacingOccurrences(of: " ", with: "", options: .regularExpression)
        let parameters = ["upi_id": upi,"account_type":"upi" , "name" : hash]
        debugPrint(parameters)
        AF.request(AppDelegate.Nexdha_student.server+"/api/upi_verifyy", method: .post, parameters: parameters, headers: headers).responseJSON { response in
                    debugPrint(response)
            switch response.result{
                            case .success(let value):
                                let json = JSON(value)
                                //self.Toast(Title: "DONE", Text: json["status"]["BRANCH"].string!, delay: 3)
                                print(json)
                                self.add_status = json["statuss"].stringValue
                                let add_status1 = json["name"]
                                print(add_status1)

                              //  AppDelegate.Nexdha_student.Upi_name  =  hello2.emptyString_name
                              //  AppDelegate.Nexdha_student.Upi_id    = hello1.stringValue
                              /*  print("hello")
                                debugPrint(add_status)
                                print("hello 12345")
                                let hello1 = add_status["vpa"]
                                let hello2 = add_status["name"]
                                let hello3 = add_status["valid"]
                                print(hello1.stringValue)
                                print("123")
                                print(hello2)
                                print("welcome")
                                print(hello3)
                                print("welcome1")
                                AppDelegate.Nexdha_student.Upi_name  = hello2.stringValue
                                AppDelegate.Nexdha_student.Upi_id    = hello1.stringValue
                                print("s1")
                                print(AppDelegate.Nexdha_student.Upi_name)
                                print("s2")
                                print( AppDelegate.Nexdha_student.Upi_id)
                                self.performSegue(withIdentifier: "scanner_to_detailedpay", sender: nil)*/
                                if self.add_status == "success" {
                                    self.anime.isHidden = true
                                    self.anime?.stop()
                                    self.verifiedorunverified.isHidden = false
                                    AppDelegate.Nexdha_student.Upi_name = add_status1.stringValue
                                    AppDelegate.Nexdha_student.Upi_id   = upi
                                    debugPrint("upiddd")
                                    self.verify.backgroundColor = UIColor(red: 0.58, green: 0.57, blue: 0.57, alpha: 1.00)
                                 //   self.verify.isUserInteractionEnabled = true
                                 //   self.indicator.stopAnimating()
                               //    self.indicator.isHidden = true
                                    self.verifiedorunverified.text = "verified"
                                    self.verifiedorunverified.textColor = UIColor(red: 75/255, green: 181/255, blue: 67/255, alpha: 1.00)
                                    debugPrint("upis")
                                    self.performSegue(withIdentifier: "enterupi_pay", sender: nil)

                                                
                                }else{
                                    self.verifiedorunverified.isHidden = false
                                    self.anime.isHidden = true
                                    self.anime?.stop()
                                   /* let alert = UIAlertController(title: "UPId Not Valid", message: self.add_status, preferredStyle: .actionSheet)
                                    alert.addAction(UIAlertAction(title: "ok", style: .default, handler:  { action in

                                     ///   self.performSegue(withIdentifier: "enterupi_pay", sender: nil)
                                        self.alertControllerWithTf()


                                                    }))
                                    self.present(alert, animated: true, completion: nil)*/
                                   // self.verify.isUserInteractionEnabled = false
                                  //  self.indicator.stopAnimating()
                                  //  self.indicator.isHidden = true
                                    self.verifiedorunverified.text = self.add_status
                                    self.verifiedorunverified.textColor = UIColor(red: 0.82, green: 0.15, blue: 0.04, alpha: 1.00)

                }
                               
                            case.failure(let error):
                                print(error)
                            }
            
            
                }
    }
    
    
}

