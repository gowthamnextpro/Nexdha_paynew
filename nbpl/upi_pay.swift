//
//  upi_pay.swift
//  nbpl
//
//  Created by Nexdha on 03/06/22.
//

import Foundation
import UIKit
import Foundation
import Alamofire
import SwiftyJSON
import Lottie
import CryptoKit

class upi_pay: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var credit_available: UILabel!
    @IBOutlet weak var outstanding_anim: UILabel!
    @IBOutlet weak var date_and_studentid: UILabel!
    @IBOutlet weak var nexdha_behalf: UILabel!
    @IBOutlet weak var nexdha_name: UILabel!
    @IBOutlet weak var amount_anim: UILabel!
    @IBOutlet weak var close_roundcorner: UIButton!
    @IBOutlet weak var closebackground: UIStackView!
    @IBOutlet weak var paid_anim: UILabel!
    @IBOutlet weak var full_view: UIStackView!
    @IBOutlet weak var pay_stack: UIStackView!
    
    @IBOutlet weak var name_designs: UIStackView!
    @IBOutlet weak var name_upiid: UIStackView!
    @IBOutlet weak var enter_amount: UIStackView!
    
    @IBOutlet weak var anim2: AnimationView!
    @IBOutlet weak var failed_view: UIStackView!
    @IBOutlet weak var failed_label: UILabel!
    @IBOutlet weak var label_of_tf: UILabel!
    @IBOutlet weak var btn_background: UIStackView!
    @IBOutlet weak var close: UIButton!
    
    @IBOutlet weak var close_for_anim3: UIButton!
    @IBOutlet weak var anim3: AnimationView!
    @IBOutlet weak var trans_pending: UILabel!
    @IBOutlet weak var text: UILabel!
    @IBOutlet weak var pending_view: UIStackView!
    @IBOutlet weak var pending_close_background: UIStackView!
    
    
    
    @IBOutlet weak var extra_line: UIStackView!
    @IBOutlet weak var bttom: NSLayoutConstraint!
    @IBOutlet weak var trailing: NSLayoutConstraint!
    @IBOutlet weak var leading: NSLayoutConstraint!
    @IBOutlet weak var bottoms: UIView!
    @IBOutlet weak var main_view_anim: UIStackView!
    @IBOutlet weak var anim_after_transaction: AnimationView!
    @IBOutlet weak var animations: AnimationView!
    @IBOutlet weak var ERROR: UILabel!
    @IBOutlet weak var PAY: UIButton!
    @IBOutlet weak var back: UIImageView!
    @IBOutlet weak var indicator_api: UIActivityIndicatorView!
    @IBOutlet weak var amount_get: UITextField!
    @IBOutlet weak var upi_id: UILabel!
    @IBOutlet weak var name: UILabel!
    var pickerData: [String] = [String]()
    var purposearray: [String] = [String]()
    var border = CALayer()
    var width = CGFloat(1.0)
    var mainVC = Dashboard()
    var count = 0
  

    override var preferredStatusBarStyle: UIStatusBarStyle {
           return .lightContent
       }
    override func viewDidLoad() {
        super.viewDidLoad()
      //  main_view_anim.layer.
        main_view_anim.isHidden = true
        main_view_anim.clipsToBounds = true
        main_view_anim.layer.cornerRadius = 20
        
        failed_view.isHidden = true
        failed_view.clipsToBounds = true
        failed_view.layer.cornerRadius = 20
        
        pending_view.isHidden = true
        pending_view.clipsToBounds = true
        pending_view.layer.cornerRadius = 20
       // full_view?.backgroundColor = NSColor.clearColor().CGColor

        closebackground.backgroundColor = UIColor(red: 0.00, green: 0.35, blue: 0.17, alpha: 1.00)
        
     //   name_designs.backgroundColor = UIColor(red: 0.08, green: 0.07, blue: 0.07, alpha: 1.00)
     //   name_designs.layer.cornerRadius = 20
        
        btn_background.backgroundColor = UIColor(red: 0.58, green: 0.35, blue: 0.23, alpha: 1.00)
      //  main_view_anim.isHidden = true
      //  main_view_anim.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMaxYCorner]

        animations.isHidden = true
        close_roundcorner.layer.borderWidth = 0.5
        close_roundcorner.layer.cornerRadius = 25
        close_roundcorner.layer.borderColor = UIColor.white.cgColor
        
        close.layer.borderWidth = 0.5
        close.layer.cornerRadius = 20
        close.layer.borderColor = UIColor.white.cgColor
        
        close_for_anim3.layer.borderWidth = 0.5
        close_for_anim3.layer.cornerRadius = 20
        close_for_anim3.layer.borderColor = UIColor.white.cgColor
        
        extra_line.backgroundColor = UIColor(red: 0.18, green: 0.18, blue: 0.18, alpha: 1.00)
        pending_close_background.backgroundColor = UIColor(red: 0.02, green: 0.38, blue: 0.42, alpha: 1.00)
        
        let label = UILabel()
        let text = NSMutableAttributedString()
        let swiftColor = UIColor(red: 232, green: 255/255, blue: 0, alpha: 1)
        text.append(NSAttributedString(string: "Error", attributes: [NSAttributedString.Key.foregroundColor: swiftColor]))
        nexdha_name.attributedText = text
        
        self.addDoneButtonOnKeyboard()
        self.hideKeyboardWhenTappedAround()
        border.borderColor = UIColor.gray.cgColor
        border.frame = CGRect(x: 0, y: amount_get.frame.size.height - width, width: amount_get.frame.size.width, height: amount_get.frame.size.height)
        border.borderWidth = width
        amount_get.backgroundColor = UIColor.clear
        amount_get.layer.addSublayer(border)
        amount_get.layer.masksToBounds = true
        amount_get.textColor = UIColor.gray
        amount_get.delegate = self
        PAY.new_grad(colors: [UIColor(red: 0.24, green: 0.08, blue: 0.58, alpha: 1.00).cgColor, UIColor.magenta.cgColor])
        PAY.clipsToBounds = true
        PAY.layer.cornerRadius = 25
        print("welcome for payment")
        print(AppDelegate.Nexdha_student.Upi_name)
        print(AppDelegate.Nexdha_student.Upi_id)
        print("123456789")
        indicator_api.isHidden = true
        ERROR.isHidden = true
        name.text = AppDelegate.Nexdha_student.Upi_name
        upi_id.text = AppDelegate.Nexdha_student.Upi_id
        let payment_back_var = UITapGestureRecognizer(target: self, action: #selector(pay_back_clicked(_:)))
        back.addGestureRecognizer(payment_back_var)
      /*  let paying = UITapGestureRecognizer(target: self, action: #selector(payed_direct(_:)))
        pay_stack.addGestureRecognizer(paying)*/
        
        
        counter_check()
    }
   
    func Toast(Title:String ,Text:String, delay:Int) -> Void {
           let alert = UIAlertController(title: Title, message: Text, preferredStyle: .alert)
           self.present(alert, animated: true)
           let deadlineTime = DispatchTime.now() + .seconds(delay)
           DispatchQueue.main.asyncAfter(deadline: deadlineTime, execute: {
               alert.dismiss(animated: true, completion: nil)
           })
       }
    @objc func pay_back_clicked(_ sender: Any){
        self.performSegue(withIdentifier: "upi_dashboard", sender: nil)
       }
    @objc func payed_direct(_ sender: Any){
        if(amount_get.text == ""){
          ERROR.isHidden = false
          ERROR.text = "Enter Amount"
        }
        else{
         
           // self.PAY.backgroundColor = UIColor.gray
          //  PAY.setTitle("Please wait Processing", for: .normal)
          //  PAY.setTitleColor(.white, for: .normal)
            //commented
            
            let Amount1 = amount_get.text
            let amount_trim_ = Amount1!.replacingOccurrences(of: " ", with: "", options: .regularExpression)
            print(AppDelegate.Nexdha_student.Upiamt)
            let alertController = UIAlertController(title:"Please confirm to Initiate Payment of ₹" + amount_trim_, message: nil, preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Pay", style: .default,handler: self.alertaction1(_:)))
            self.present(alertController, animated: true, completion: nil)
          
         //   PAY.isEnabled = false
          //  indicator_api.isHidden = false
          //  indicator_api.startAnimating()
          //  pay_you()
       }
    }
    override func viewWillAppear(_ animated: Bool) {
      counter_check()
      super.viewWillAppear(animated)
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
            self.performSegue(withIdentifier: "upipayment_to_home", sender: nil)
        })
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
    var maxLength : Int = 0
        
        if textField == amount_get{
            maxLength = 8
        }
        let currentString: NSString = textField.text! as NSString
        let newString: NSString =  currentString.replacingCharacters(in: range, with: string) as NSString
        return newString.length <= maxLength
    }
    @objc func alertaction1(_ sender: Any) {
        PAY.isEnabled = false
        indicator_api.isHidden = false
        indicator_api.startAnimating()
        pay_you()
    }
    @IBAction func payed(_ sender: Any) {
        if(amount_get.text == ""){
          ERROR.isHidden = false
          ERROR.text = "Enter Amount"
        }
        else{
         
           // self.PAY.backgroundColor = UIColor.gray
          //  PAY.setTitle("Please wait Processing", for: .normal)
          //  PAY.setTitleColor(.white, for: .normal)
            //commented
            let Amount1 = amount_get.text
            let amount_trim_ = Amount1!.replacingOccurrences(of: " ", with: "", options: .regularExpression)
            print(AppDelegate.Nexdha_student.Upiamt)
            let alertController = UIAlertController(title:"Please confirm to Initiate Payment of ₹" + amount_trim_, message: nil, preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Pay", style: .default,handler: self.alertaction1(_:)))
            self.present(alertController, animated: true, completion: nil)
          
 
            ///commented
            
            //success
        /*    full_view.isUserInteractionEnabled = false
            pending_view.isHidden = true
            failed_view.isHidden = true
            main_view_anim.isHidden = false
            date_and_studentid.text = "2022-06-14" + " " + "|" + " " + "Transaction ID :" + " " + "stud20219528"
            credit_available.text = "₹" + " " + "2300"
            nexdha_name.text = "New Nafessa Fancy"
            nexdha_behalf.text = "Nexdha has paid on your behalf"
           // amount_anim.font =  UIFont(name: "Montserrat-ExtraBold", size: 30)

            amount_anim.text = "₹"  + " " + "1.0"

            //amount_anim.font = UIFont(name: "Montserrat-Bold", size: 25 )

            self.animations.isHidden = true
            self.animations?.stop()
         //   UserDefaults.standard.set(userphone, forKey: "number") //setObject
         //   self.performSegue(withIdentifier: "login_to_otp", sender: nil)
            self.indicator_api.isHidden = true
            indicator_api.stopAnimating()
          /* let alert = UIAlertController(title: "Transaction Status", message: welcome, preferredStyle: .actionSheet)
            alert.addAction(UIAlertAction(title: "ok", style: .default, handler:  { action in
            self.performSegue(withIdentifier: "upi_dashboard", sender: nil)

                            }))
            self.present(alert, animated: true, completion: nil)*/
           // anim_after_transaction.isHidden = false
          //  anim_after_transaction?.contentMode = .scaleAspectFit
           // anim_after_transaction?.loopMode =  .loop
          //  anim_after_transaction?.animationSpeed = 1
         //   animationview?.backgroundColor = UIColor(red: 0.00, green: 0.00, blue: 0.00, alpha: 1.00)
          //  anim_after_transaction?.play()
        //    paid_anim.isHidden = false
        //    amount_anim.isHidden = false
        //    nexdha_name.isHidden = false
        //    nexdha_behalf.isHidden = false
         //   date_and_studentid.isHidden = false
        //    outstanding_anim.isHidden = false
        //    credit_available.isHidden = false
            anim_after_transaction.isHidden = false
            main_view_anim.backgroundColor = UIColor(red: 0.00, green: 0.51, blue: 0.25, alpha: 1.00)
           // anim_after_transaction.isHidden = false
            anim_after_transaction?.contentMode = .scaleAspectFit
           // anim_after_transaction?.loopMode =  .loop
            anim_after_transaction?.animationSpeed = 0.85
         //   animationview?.backgroundColor = UIColor(red: 0.00, green: 0.00, blue: 0.00, alpha: 1.00)
            anim_after_transaction?.play()*/
            ////suceess
           /////failed
            ///
            ///
        /*    full_view.isUserInteractionEnabled = false

            main_view_anim.isHidden = true
            pending_view.isHidden = true
            failed_view.isHidden = false
            self.animations.isHidden = true
            self.animations?.stop()
          /*  let alert = UIAlertController(title: "Transaction Status", message: welcome, preferredStyle: .actionSheet)
            alert.addAction(UIAlertAction(title: "ok", style: .default, handler:  { action in
            self.performSegue(withIdentifier: "upi_dashboard", sender: nil)

                            }))
            self.present(alert, animated: true, completion: nil)*/
         //   paid_anim.isHidden = true
        //    amount_anim.isHidden = true
         //   nexdha_name.isHidden = true
          //  nexdha_behalf.isHidden = true
        //    nexdha_behalf.text = "Transaction failed.Please try again later"
            failed_view.backgroundColor = UIColor(red: 0.77, green: 0.46, blue: 0.31, alpha: 1.00)
          //  date_and_studentid.isHidden = true
         //   outstanding_anim.isHidden = true
         //   credit_available.isHidden = true
            anim2.isHidden = false
            anim2?.contentMode = .scaleAspectFit
          //  anim2?.loopMode =  .loop
            anim2?.animationSpeed = 0.85
         //   animationview?.backgroundColor = UIColor(red: 0.00, green: 0.00, blue: 0.00, alpha: 1.00)
            anim2?.play()*/
           
            ///failed
            
           //pending
          /*  full_view.isUserInteractionEnabled = false
            failed_view.isHidden = true
            main_view_anim.isHidden = true
            pending_view.isHidden = false
           // paid_anim.isHidden = true
          //  amount_anim.isHidden = true
         //   nexdha_name.isHidden = true
         //   nexdha_behalf.isHidden = true
        //    date_and_studentid.isHidden = true
        //    outstanding_anim.isHidden = true
         //   credit_available.isHidden = true
            self.animations.isHidden = true
            self.animations?.stop()
            pending_view.backgroundColor = UIColor(red: 0.03, green: 0.48, blue: 0.53, alpha: 1.00)
            anim3.isHidden = false
            anim3?.contentMode = .scaleAspectFit
          //  anim3?.loopMode =  .loop
            anim3?.animationSpeed = 0.85
         //   animationview?.backgroundColor = UIColor(red: 0.00, green: 0.00, blue: 0.00, alpha: 1.00)
            anim3?.play()*/
            
          //pending
               }
        }
        
    @IBAction func CLOSE1(_ sender: Any) {
        self.performSegue(withIdentifier: "upi_dashboard", sender: nil)
    }
    @IBAction func CLOSE2(_ sender: Any) {
        self.performSegue(withIdentifier: "upi_dashboard", sender: nil)
    }
    
    @IBAction func close_anim(_ sender: Any) {
     //   self.dismiss(animated: true, completion: nil)
        self.performSegue(withIdentifier: "upi_dashboard", sender: nil)
    }
 
    public func activity_log(){
        let headers: HTTPHeaders = [
            .authorization(UserDefaults.standard.string(forKey: "token") as! String)
        ]
        
        let parameters = ["activity_id": "105" ,"os": "iOS"]

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
    func addDoneButtonOnKeyboard(){
            let doneToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
            doneToolbar.barStyle = .default
            let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
            let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.doneButtonAction))
            let items = [flexSpace, done]
            doneToolbar.items = items
            doneToolbar.sizeToFit()
            amount_get.inputAccessoryView = doneToolbar
        }

        @objc func doneButtonAction(){
            amount_get.resignFirstResponder()
        }
    private func pay_you(){
        //   let first_name = firstname.text
        indicator_api.isHidden = true
        indicator_api.startAnimating()
        
        animations.isHidden = false
        animations?.contentMode = .scaleAspectFit
        animations?.loopMode =  .loop
        animations?.animationSpeed = 0.85
     //   animationview?.backgroundColor = UIColor(red: 0.00, green: 0.00, blue: 0.00, alpha: 1.00)
        animations?.play()
        let headers: HTTPHeaders = [
            .authorization(UserDefaults.standard.object(forKey: "token") as! String)
                ]
        print(headers)
        print("this is upi")
        
        let Amount = amount_get.text
        let amount_trim = Amount!.replacingOccurrences(of: " ", with: "", options: .regularExpression)
        AppDelegate.Nexdha_student.Upiamt = amount_trim
        let inputString1 = "kmKHO0vpCxUK5m9fAs0Z"
        let inputString2 = amount_trim + AppDelegate.Nexdha_student.Upi_id + inputString1
        print(inputString2)
        let inputData = Data(inputString2.utf8)
        let hashed = SHA512.hash(data: inputData)
        print(hashed.description)
        let hash = hashed.compactMap { String(format: "%02x", $0) }.joined()
        print(hash)
        
        
        let parameters = ["amount": amount_trim,"upi_handle": AppDelegate.Nexdha_student.Upi_id , "name": hash.replacingOccurrences(of: " ", with: "", options: .regularExpression) , "location" : AppDelegate.Nexdha_student.location]
           print(parameters)
        AF.request(AppDelegate.Nexdha_student.server+"/api/office_exp", method: .post, parameters: parameters, headers: headers).responseJSON { [self] response in
                       debugPrint(response)
               switch response.result{
                               case .success(let value):
                   
                                   print("checks")
                                   let json = JSON(value)
                                    print("checks123")
                                print("A1")
                                print(json)
                                print("A2")
                                let trans_id = json["transaction_id"].stringValue
                                let dates = json["date"].stringValue
                                let amt = json["amount"].stringValue
                                let bene_ame = json["beni_name"].stringValue
                                let outstanding  =  json["balance"].stringValue
                   if let welcome = json["statuss"].string{
                       if welcome == "success"  {
                           print("s1")
                           full_view.isUserInteractionEnabled = false
                           pending_view.isHidden = true
                           failed_view.isHidden = true
                           main_view_anim.isHidden = false
                           date_and_studentid.text = dates + " " + "|" + " " + "Transaction ID :" + " " + trans_id
                           credit_available.text = "₹" + " " + outstanding
                           nexdha_name.text = bene_ame
                           nexdha_behalf.text = "Nexdha has Paid on your behalf"
                           amount_anim.text = "₹"  + " " + amt
                           self.animations.isHidden = true
                           self.animations?.stop()
                        //   UserDefaults.standard.set(userphone, forKey: "number") //setObject
                        //   self.performSegue(withIdentifier: "login_to_otp", sender: nil)
                           self.indicator_api.isHidden = true
                           indicator_api.stopAnimating()
                          
                           
                         /* let alert = UIAlertController(title: "Transaction Status", message: welcome, preferredStyle: .actionSheet)
                           alert.addAction(UIAlertAction(title: "ok", style: .default, handler:  { action in
                           self.performSegue(withIdentifier: "upi_dashboard", sender: nil)

                                           }))
                           self.present(alert, animated: true, completion: nil)*/
                          // anim_after_transaction.isHidden = false
                         //  anim_after_transaction?.contentMode = .scaleAspectFit
                          // anim_after_transaction?.loopMode =  .loop
                         //  anim_after_transaction?.animationSpeed = 1
                        //   animationview?.backgroundColor = UIColor(red: 0.00, green: 0.00, blue: 0.00, alpha: 1.00)
                         //  anim_after_transaction?.play()
                       //    paid_anim.isHidden = false
                       //    amount_anim.isHidden = false
                       //    nexdha_name.isHidden = false
                       //    nexdha_behalf.isHidden = false
                        //   date_and_studentid.isHidden = false
                       //    outstanding_anim.isHidden = false
                       //    credit_available.isHidden = false
                           anim_after_transaction.isHidden = false
                           main_view_anim.backgroundColor = UIColor(red: 0.00, green: 0.51, blue: 0.25, alpha: 1.00)
                          // anim_after_transaction.isHidden = false
                           anim_after_transaction?.contentMode = .scaleAspectFit
                          // anim_after_transaction?.loopMode =  .loop
                           anim_after_transaction?.animationSpeed = 0.85
                        //   animationview?.backgroundColor = UIColor(red: 0.00, green: 0.00, blue: 0.00, alpha: 1.00)
                           anim_after_transaction?.play()
                       }else if welcome == "failure"{
                           print("s2")
                           full_view.isUserInteractionEnabled = false
                          // failed_view.isHidden = true
                           main_view_anim.isHidden = true
                           pending_view.isHidden = true
                           failed_view.isHidden = false
                           self.animations.isHidden = true
                           self.animations?.stop()
                         /*  let alert = UIAlertController(title: "Transaction Status", message: welcome, preferredStyle: .actionSheet)
                           alert.addAction(UIAlertAction(title: "ok", style: .default, handler:  { action in
                           self.performSegue(withIdentifier: "upi_dashboard", sender: nil)

                                           }))
                           self.present(alert, animated: true, completion: nil)*/
                        //   paid_anim.isHidden = true
                       //    amount_anim.isHidden = true
                        //   nexdha_name.isHidden = true
                         //  nexdha_behalf.isHidden = true
                       //    nexdha_behalf.text = "Transaction failed.Please try again later"
                           failed_view.backgroundColor = UIColor(red: 0.77, green: 0.46, blue: 0.31, alpha: 1.00)
                         //  date_and_studentid.isHidden = true
                        //   outstanding_anim.isHidden = true
                        //   credit_available.isHidden = true
                           anim2.isHidden = false
                           anim2?.contentMode = .scaleAspectFit
                         //  anim2?.loopMode =  .loop
                           anim2?.animationSpeed = 0.85
                        //   animationview?.backgroundColor = UIColor(red: 0.00, green: 0.00, blue: 0.00, alpha: 1.00)
                           anim2?.play()
                           
                       }else{
                           if welcome == "pending"{
                               print("s3")
                               full_view.isUserInteractionEnabled = false
                               failed_view.isHidden = true
                               main_view_anim.isHidden = true
                               pending_view.isHidden = false
                              // paid_anim.isHidden = true
                             //  amount_anim.isHidden = true
                            //   nexdha_name.isHidden = true
                            //   nexdha_behalf.isHidden = true
                           //    date_and_studentid.isHidden = true
                           //    outstanding_anim.isHidden = true
                            //   credit_available.isHidden = true
                               self.animations.isHidden = true
                               self.animations?.stop()
                               pending_view.backgroundColor = UIColor(red: 0.03, green: 0.48, blue: 0.53, alpha: 1.00)
                               anim3.isHidden = false
                               anim3?.contentMode = .scaleAspectFit
                             //  anim3?.loopMode =  .loop
                               anim3?.animationSpeed = 0.85
                            //   animationview?.backgroundColor = UIColor(red: 0.00, green: 0.00, blue: 0.00, alpha: 1.00)
                               anim3?.play()
                           
                           }else{
                               print("s4")
                               self.animations.isHidden = true
                               self.animations?.stop()
                               let alert = UIAlertController(title: "Transaction Status", message: welcome ,preferredStyle: UIAlertController.Style.alert)
                                       alert.addAction(UIAlertAction(title: "ok",
                                                                     style: UIAlertAction.Style.default,
                                                                     handler: {(_: UIAlertAction!) in
                                           self.performSegue(withIdentifier: "upi_dashboard", sender: nil)
                                       }))
                                       self.present(alert, animated: true, completion: nil)
                           }
                              
                           
                          
                          
                       }
                   }
                               case.failure(let error):
                                   print(error)
                               }
                   }
       }
}

