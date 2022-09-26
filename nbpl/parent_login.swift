//
//  parent_login.swift
//  Nexdha's BNPL
//
//  Created by Nexdha on 30/05/22.
//

import Foundation
import UIKit
import Alamofire
import SwiftyJSON
import CryptoKit
import Lottie
import CryptoKit
class parent_login: UIViewController , UITextFieldDelegate{
   
    @IBOutlet weak var logg_stack: UIStackView!
    @IBOutlet weak var animations: AnimationView!
    @IBOutlet weak var logg_error: UILabel!
    @IBOutlet weak var header_login: UILabel!
    @IBOutlet weak var login_with_api: UIButton!
    @IBOutlet weak var back_from_plogin: UIImageView!
    @IBOutlet weak var textfield: UITextField!
    @IBOutlet weak var singup_views_only: UIStackView!
    
    var verificationId = String()
    var border = CALayer()
    var width = CGFloat(1.0)
    override func viewDidLoad() {
        super.viewDidLoad()
       print(AppDelegate.Nexdha_student.login_heading)
        addDoneButtonOnKeyboard()
        animations.isHidden = true
     //   singup_views_only.isHidden = true
        self.hideKeyboardWhenTappedAround()
        print("a1")
        login_with_api.new_grad(colors: [UIColor(red: 0.24, green: 0.08, blue: 0.58, alpha: 1.00).cgColor, UIColor.magenta.cgColor])
        login_with_api.clipsToBounds = true
        login_with_api.layer.cornerRadius = 25
        print(AppDelegate.Nexdha_student.login_heading)
        print(verificationId)
       // header_login.text = AppDelegate.Nexdha_student.login_heading
        AppDelegate.Nexdha_student.login_heading = verificationId
        if AppDelegate.Nexdha_student.login_heading == "Student Login"{
            singup_views_only.isHidden = true
        }
        print(AppDelegate.Nexdha_student.login_heading)
        header_login.text = AppDelegate.Nexdha_student.login_heading
        border.borderColor = UIColor(red: 0.17, green: 0.17, blue: 0.17, alpha: 1.00).cgColor
        border.frame = CGRect(x: 0, y: textfield.frame.size.height - width, width: textfield.frame.size.width, height: textfield.frame.size.height)
        border.borderWidth = width
        textfield.backgroundColor = UIColor.clear
        textfield.layer.addSublayer(border)
        textfield.layer.masksToBounds = true
        textfield.textColor = UIColor.white
        textfield.delegate = self
    
        let payment_back_var = UITapGestureRecognizer(target: self, action: #selector(pay_back_clicked(_:)))
        back_from_plogin.addGestureRecognizer(payment_back_var)
        
        
      /*  let logg = UITapGestureRecognizer(target: self, action: #selector(logg_one(_:)))
        logg_stack.addGestureRecognizer(logg)*/
        
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
           return .lightContent
       }
    func addDoneButtonOnKeyboard(){
            let doneToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
            doneToolbar.barStyle = .default
            let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
            let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.doneButtonAction))
            let items = [flexSpace, done]
            doneToolbar.items = items
            doneToolbar.sizeToFit()
            textfield.inputAccessoryView = doneToolbar
        }

    @objc func doneButtonAction(){
            textfield.resignFirstResponder()
        }
    @IBAction func logg(_ sender: Any) {
        logg_error.isHidden = true
    //    textfield.resignFirstResponder()
         let phone_to_be_trimmed = textfield.text
        let finaltrimmed = phone_to_be_trimmed!.replacingOccurrences(of: " ", with: "", options: .regularExpression)
       if(finaltrimmed == ""){
           logg_error.text = "Enter Phone number"
           logg_error.isHidden = false
           textfield.becomeFirstResponder()
        }else if(finaltrimmed.count < 10){
             logg_error.text = "Enter valid phone number"
             logg_error.isHidden = false
             textfield.becomeFirstResponder()
                           }
        else{
             verifylogin()
        }
    }
    @IBAction func signup(_ sender: Any) {
        self.performSegue(withIdentifier: "parentlogin_signup", sender: nil)
    }
    @objc func pay_back_clicked(_ sender: Any){
        self.dismiss(animated: true, completion: nil)
       }
    @objc func logg_one(_ sender: Any){
        logg_error.isHidden = true
    //    textfield.resignFirstResponder()
         let phone_to_be_trimmed = textfield.text
         let finaltrimmed = phone_to_be_trimmed!.replacingOccurrences(of: " ", with: "", options: .regularExpression)
       if(finaltrimmed == ""){
           logg_error.text = "Enter Phone number"
           logg_error.isHidden = false
           textfield.becomeFirstResponder()
        }else if(finaltrimmed.count < 10){
             logg_error.text = "Enter valid phone number"
             logg_error.isHidden = false
             textfield.becomeFirstResponder()
                           }
        else{
             verifylogin()
        }
       }
  
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
           
       var maxLength : Int = 0
           
           if textField == textfield{
               maxLength = 10
           }
          
           let currentString: NSString = textField.text! as NSString
           
           let newString: NSString =  currentString.replacingCharacters(in: range, with: string) as NSString
           return newString.length <= maxLength
       }
    public func verifylogin(){
        AppDelegate.Nexdha_student.login_phone_number = textfield.text!
        animations.isHidden = false
        animations?.contentMode = .scaleAspectFit
        animations?.loopMode =  .loop
        animations?.animationSpeed = 0.85
     //   animationview?.backgroundColor = UIColor(red: 0.00, green: 0.00, blue: 0.00, alpha: 1.00)
        animations?.play()
        let userphone = AppDelegate.Nexdha_student.login_phone_number
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
                            self.animations?.stop()
                            self.animations.isHidden = true
                            self.logg_error.text = status
                            self.logg_error.isHidden = false
                         //   self.Toast(Title: "Number does not exists please signup", Text: "You will be redirected to Signup page", delay: 2)
                          //  self.showToast(controller: self, message : "Number does not exists please signup", seconds: 2.0)
                            self.Toast(Title: "Number does not exists please signup", Text: "You will be redirected to Signup page", delay: Int(2.0))
                            
                        }else{
                            print("enter")
                            print(userphone)
                            UserDefaults.standard.set(userphone, forKey: "number")
                            print(userphone)
                            self.animations?.stop()
                            self.animations.isHidden = true
                            self.performSegue(withIdentifier: "login_to_otp", sender: nil)
                          
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
   
    /*public func logg(){
  
        let params = [
            "phone": textfield.text!,
        ] as [String : Any]
        AF.request("https://student.nexdha.com/api/login", method: .post, parameters: params).responseString  { response in
            print(response.request) // original url request
            print(response.response) // http url reponse
          /*  if let json = response.result.value {
               print("JSON: \(json)") // serialized json response after post
                self.performSegue(withIdentifier: "login_to_otp", sender: nil)

            }*/
        }
    }*/
    
    
    func Toast(Title:String ,Text:String, delay:Int) -> Void {
        let alert = UIAlertController(title: Title, message: Text, preferredStyle: .alert)
        self.present(alert, animated: true)
        let deadlineTime = DispatchTime.now() + .seconds(delay)
        DispatchQueue.main.asyncAfter(deadline: deadlineTime, execute: {
            alert.dismiss(animated: true, completion: nil)
            self.performSegue(withIdentifier: "parentlogin_signup", sender: self)
        })
    }
    func showToast(controller: UIViewController, message : String, seconds: Double) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.view.backgroundColor = UIColor.black
        alert.view.alpha = 0.6
        alert.view.layer.cornerRadius = 15
        controller.present(alert, animated: true)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + seconds) {
            alert.dismiss(animated: true)
        }
    }
}
/*extension UIButton{
    func applyGradient_parent(colors : [CGColor]){
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = colors
        gradientLayer.cornerRadius = layer.cornerRadius
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0)
        gradientLayer.frame = bounds
        gradientLayer.cornerRadius = 25
        layer.insertSublayer(gradientLayer, at: 0)
    }
}
extension UITextField {
    func addBottomBorder() {
        let bottomline = CALayer()
        bottomline.frame = CGRect(x: 0,y:self.frame.size.height - 1, width: self.frame.size.width,height: 1)
        bottomline.backgroundColor = UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0, alpha: 1.0).cgColor
        borderStyle = .none
        self.layer.addSublayer(bottomline)
        self.layer.masksToBounds = true
    }
    func removeBottomBorder() {
            let removebottomline = CALayer()
            removebottomline.frame = CGRect(x: 0,y:self.frame.size.height - 1, width: self.frame.size.width,height: 1)
            removebottomline.backgroundColor = UIColor(red: 30.0/255.0, green: 30.0/255.0, blue: 30.0, alpha: 1.0).cgColor
            borderStyle = .none
            self.layer.addSublayer(removebottomline)
            self.layer.masksToBounds = true
        }
    
}*/


