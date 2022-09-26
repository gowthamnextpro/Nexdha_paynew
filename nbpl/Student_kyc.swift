//
//  Student_kyc.swift
//  nbpl
//
//  Created by Nexdha on 20/07/22.
//

import Foundation
import UIKit
import Foundation
import Alamofire
import SwiftyJSON
import Lottie
import CryptoKit
import WXImageCompress
import AVFoundation
import AVKit
import Photos


class Student_kyc: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet weak var final_submit: UIButton!
    @IBOutlet weak var select_ab: UIButton!
    var get_into = ""
    @IBOutlet weak var view_preview_one: UILabel!
    
    @IBOutlet weak var back_go: UIImageView!
    @IBOutlet weak var h1_view: UIStackView!
    @IBOutlet weak var h2_view: UIStackView!
    
    @IBOutlet weak var selfie: UIButton!
    @IBOutlet weak var view_preview_three: UILabel!
    @IBOutlet weak var view_preview_two: UILabel!
    @IBOutlet weak var select_af: UIButton!
    var selfiePicker = UIImagePickerController()
    var globalImage_selfie:UIImage? = nil

    var imagePicker_aadharfront = UIImagePickerController()
    var globalImage_afront1:UIImage? = nil
    var count = 0

    var imagePicker_aadharback = UIImagePickerController()
    var globalImage_aback1:UIImage? = nil
    override var preferredStatusBarStyle: UIStatusBarStyle {
           return .lightContent
       }
    override func viewDidLoad() {
        super.viewDidLoad()
        h1_view.layer.cornerRadius = 25
        h2_view.layer.cornerRadius = 25
        select_ab.layer.cornerRadius = 20
        select_af.layer.cornerRadius = 20
        selfie.layer.cornerRadius = 20
        final_submit.layer.cornerRadius  = 25
        counter_check()
        let alert_dismiss_kyc = UITapGestureRecognizer(target: self, action: #selector(back_go(_:)))
        back_go.addGestureRecognizer(alert_dismiss_kyc)
        let af = UITapGestureRecognizer(target: self, action: #selector(aadhar_f(_:)))
        view_preview_one.addGestureRecognizer(af)
        let ab = UITapGestureRecognizer(target: self, action: #selector(aadhar_b(_:)))
        view_preview_two.addGestureRecognizer(ab)
        let selfie_view = UITapGestureRecognizer(target: self, action: #selector(selfie_only(_:)))
        view_preview_three.addGestureRecognizer(selfie_view)
        
        let photos = PHPhotoLibrary.authorizationStatus()
           if photos == .notDetermined {
               PHPhotoLibrary.requestAuthorization({status in
                   DispatchQueue.main.async {

                   if status == .authorized{
                      debugPrint("photo got it")
                   } else { let alertController = UIAlertController(title: "Access Denied", message:"Photos permission allows us to access the photos you select for KYC.So, please provide photos access in settings to proceed with KYC verification.", preferredStyle: .alert)
                              self.present(alertController, animated: true, completion: nil)}
                   }})
           }
           else if photos == .authorized{
           debugPrint("Print")
        }
           else if photos == .restricted{
            debugPrint("Restricted")
            let alertController = UIAlertController(title: "Access Denied", message:"Photos permission allows us to access the photos you select for KYC.So, please provide photos access in settings to proceed with KYC verification.", preferredStyle: .alert)
            self.present(alertController, animated: true, completion: nil)
           }else if photos == .denied{
            debugPrint("Denied")
            let alertController = UIAlertController(title: "Access Denied", message:"Photos permission allows us to access the photos you select for KYC.So, please provide photos access in settings to proceed with KYC verification.", preferredStyle: .alert)
            self.present(alertController, animated: true, completion: nil)
        }
        switch AVCaptureDevice.authorizationStatus(for: .video) {
              case .authorized: // The user has previously granted access to the camera.
           debugPrint("gotit")
              
              case .notDetermined: // The user has not yet been asked for camera access.
                  AVCaptureDevice.requestAccess(for: .video) { granted in
                      DispatchQueue.main.async {

                      if granted {
                       debugPrint("gotit 2")
                      }else{
                      let alertController = UIAlertController(title: "Access Denied", message:"Camera permission allows us to capture your image and use it for verification with the other selected images.So, please provide Camera access in settings to proceed with KYC verification.", preferredStyle: .alert)
                       self.present(alertController, animated: true, completion: nil)
                  
                   }
                  }
                  }
              
              case .denied:
               debugPrint("Rejected")// The user has previously denied access.
                let alertController = UIAlertController(title: "Access Denied", message:"Camera permission allows us to capture your image and use it for verification with the other selected images.So, please provide Camera access in settings to proceed with KYC verification.", preferredStyle: .alert)
                      self.present(alertController, animated: true, completion: nil)
          
                  return

              case .restricted:
                debugPrint("Restricetd")// The user can't grant access due to restrictions.
                let alertController = UIAlertController(title: "Access Denied", message:"Camera permission allows us to capture your image and use it for verification with the other selected images.So, please provide Camera access in settings to proceed with KYC verification.", preferredStyle: .alert)
                       self.present(alertController, animated: true, completion: nil)

                  return
          }
    }
    @objc func back_go(_ sender: Any){
         self.dismiss(animated: false, completion: nil)
    }
    override func viewWillAppear(_ animated: Bool) {
      counter_check()
      super.viewWillAppear(animated)
    }
    @objc func aadhar_f(_ sender: Any){
        debugPrint("button clicked")
         let alert_gallery_afront = UIAlertController(title: "Aadhaar Front", message: "\n\n\n\n\n\nNot Provided\n\n\n\n\n\n\n\n", preferredStyle: .alert)
           //alert.isModalInPopover = true
        var imageiew_afront = UIImageView(frame: CGRect(x: 10, y: 20, width: 250 , height: 240))
        imageiew_afront.image = globalImage_afront1
        debugPrint(globalImage_afront1)
        alert_gallery_afront.view.addSubview(imageiew_afront)
        alert_gallery_afront.addAction(UIAlertAction(title: "Close", style: .cancel, handler: { (UIAlertAction) in
        }))
        self.present(alert_gallery_afront, animated: true, completion: nil)
    }
    @objc func selfie_only(_ sender: Any){
        let alert = UIAlertController(title: "Selfie", message: "\n\n\n\n\n\nNot Provided\n\n\n\n\n\n\n\n", preferredStyle: .alert)
        var imageiew = UIImageView(frame: CGRect(x: 10, y: 20, width: 250 , height: 240))
        imageiew.image = globalImage_selfie
        debugPrint(globalImage_selfie)
        alert.view.addSubview(imageiew)
        alert.addAction(UIAlertAction(title: "Close", style: .cancel, handler: { (UIAlertAction) in
        }))
        self.present(alert, animated: true, completion: nil)
    }
    @objc func aadhar_b(_ sender: Any){
        debugPrint("button clicked")
        let alert_gallery_aback = UIAlertController(title: "Aadhaar Back", message: "\n\n\n\n\n\nNot Provided\n\n\n\n\n\n\n\n", preferredStyle: .alert)
        var imageiew_aback = UIImageView(frame: CGRect(x: 10, y: 20, width: 250 , height: 240))
           imageiew_aback.image = globalImage_aback1
        debugPrint(globalImage_aback1)
        alert_gallery_aback.view.addSubview(imageiew_aback)
        alert_gallery_aback.addAction(UIAlertAction(title: "Close", style: .cancel, handler: { (UIAlertAction) in
        }))
        self.present(alert_gallery_aback, animated: true, completion: nil)
    }
    @IBAction func select_af(_ sender: Any) {
        imagePicker_aadharfront =  UIImagePickerController()
        imagePicker_aadharfront.delegate = self
        imagePicker_aadharfront.allowsEditing = false
        imagePicker_aadharfront.sourceType = .photoLibrary
        get_into = "a_front"
        present(imagePicker_aadharfront, animated: true, completion: nil)
    }
    @IBAction func select_ab(_ sender: Any) {
        imagePicker_aadharback =  UIImagePickerController()
        imagePicker_aadharback.delegate = self
        imagePicker_aadharback.allowsEditing = false
        imagePicker_aadharback.sourceType = .photoLibrary
        get_into = "a_back"
        present(imagePicker_aadharback, animated: true, completion: nil)
    }
    @IBAction func selfie_sido(_ sender: Any) {
        selfiePicker =  UIImagePickerController()
        selfiePicker.delegate = self
        selfiePicker.allowsEditing = false
        selfiePicker.sourceType = .camera
        get_into = "camera"
        present(selfiePicker, animated: true, completion: nil)
    }
    
    @IBAction func uploadeer(_ sender: Any) {
        if (globalImage_afront1 == nil){
            self.Toast_validation(Title: "Upload Aadhaar card front image", Text: "", delay: 3)
        }else if(globalImage_aback1 == nil){
            self.Toast_validation(Title: "Upload Aadhaar card back image", Text: "", delay: 3)
        }else if (globalImage_selfie == nil){
            self.Toast_validation(Title: "Take a selfie", Text: "", delay: 3)
        }else{
            fileupload_student()
        }
        
    }
    func Toast_validation(Title:String ,Text:String, delay:Int) -> Void {
        let alert = UIAlertController(title: Title, message: Text, preferredStyle: .alert)
        self.present(alert, animated: true)
        let deadlineTime = DispatchTime.now() + .seconds(delay)
        DispatchQueue.main.asyncAfter(deadline: deadlineTime, execute: {
            alert.dismiss(animated: true, completion: nil)
          //  self.performSegue(withIdentifier: "settings_student_to_studentdashboard", sender: self)
        })
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
                    else{
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
            self.performSegue(withIdentifier: "studentkyc_to_home", sender: nil)
        })
    }
    public func activity_log(){
        let headers: HTTPHeaders = [
            .authorization(UserDefaults.standard.string(forKey: "token") as! String)
        ]
        
        let parameters = ["activity_id": "107" ,"os": "iOS"]

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
    public func fileupload_student(){
        self.Toast12(Title: "Please Wait....", Text: "", delay: 2)

      let headers: HTTPHeaders = [
             .authorization(UserDefaults.standard.object(forKey: "token") as! String)
          ]

        let parameters = ["os": "iOS"]
              AF.upload(
                  multipartFormData: { multipartFormData in
                      
                      for (key, value) in parameters {
                          multipartFormData.append((value.data(using: String.Encoding.utf8)!), withName: key)
                                 }
                    multipartFormData.append(self.globalImage_selfie!.jpegData(compressionQuality: 0.5)!, withName: "selfie" , fileName: AppDelegate.Nexdha_student.phone+"_s.jpeg", mimeType: "image/jpeg")
                    multipartFormData.append(self.globalImage_afront1!.jpegData(compressionQuality: 0.5)!, withName: "aadhaar_front" , fileName: AppDelegate.Nexdha_student.phone+"_af.jpeg", mimeType: "image/jpeg")
                    multipartFormData.append(self.globalImage_aback1!.jpegData(compressionQuality: 0.5)!, withName: "aadhaar_back" , fileName: AppDelegate.Nexdha_student.phone+"_ab.jpeg", mimeType: "image/jpeg")
              },
                  to: AppDelegate.Nexdha_student.server+"/api/FileUploadView", method: .post  ,headers: headers)
                  .responseJSON { response in
                        debugPrint("Resssssssssss")
                        debugPrint(response)
                        switch response.result{
                                      case .success(let value):
                                          let json = JSON(value)
                                          let status = json["status"].stringValue
                            
                                          if status == "Success"{
                                            let alertController = UIAlertController(title: "Upload Success", message:
                                                                                                        "We will verify KYC and update you soon.", preferredStyle: .alert)
                                            alertController.addAction(UIAlertAction(title: "Close", style: .default,handler: self.alertaction(_:)))
                                            self.present(alertController, animated: true, completion: nil)
                                          }else{
                                            let alertController = UIAlertController(title: "Upload Failed", message:
                                                                                                        "There was an error during upload. Please try again or contact support.", preferredStyle: .alert)
                                            alertController.addAction(UIAlertAction(title: "Close", style: .default,handler: self.alertaction(_:)))
                                            self.present(alertController, animated: true, completion: nil)
                                          }
                                      case.failure(let error):
                                          print(error)
                                      }
                  
                           }
    
        
    }
    @objc func alertaction(_ sender: Any) {
        debugPrint("alert action")
       self.performSegue(withIdentifier: "settings_student_to_studentdashboard", sender: self)
        
    }
    func Toast12(Title:String ,Text:String, delay:Int) -> Void {
        let alert = UIAlertController(title: Title, message: Text, preferredStyle: .alert)
        self.present(alert, animated: true)
        let deadlineTime = DispatchTime.now() + .seconds(delay)
        DispatchQueue.main.asyncAfter(deadline: deadlineTime, execute: {
            alert.dismiss(animated: true, completion: nil)
        })
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
        debugPrint("Thissssss")
      if get_into == "a_front"{
            view_preview_one.textColor = UIColor(red: 0.00, green: 0.50, blue: 0.50, alpha: 1.00)
            imagePicker_aadharfront.dismiss(animated: true)
            debugPrint("a_front")
            let convert_aadhaar_f =  info[.originalImage] as? UIImage
            globalImage_afront1 = convert_aadhaar_f!.wxCompress()
            let imgData_1 = NSData(data: globalImage_afront1!.jpegData(compressionQuality: 1)!)
            var imageSize_1: Int = imgData_1.count
            print("aadhaar front size in KB: %f ", Double(imageSize_1) / 1000.0)
        }else if get_into == "a_back"{
            view_preview_two.textColor = UIColor(red: 0.00, green: 0.50, blue: 0.50, alpha: 1.00)
            imagePicker_aadharback.dismiss(animated: true)
            debugPrint("a_back")
            //imageView.image = info[.originalImage] as? UIImage
            let convert_aadhaar_back = info[.originalImage] as? UIImage
            globalImage_aback1 = convert_aadhaar_back!.wxCompress()
            let imgData_1 = NSData(data: globalImage_aback1!.jpegData(compressionQuality: 1)!)
            var imageSize_1: Int = imgData_1.count
            print("aadhaar back size in KB: %f ", Double(imageSize_1) / 1000.0)
        }
       else if get_into == "camera"{
            view_preview_three.textColor = UIColor(red: 0.00, green: 0.50, blue: 0.50, alpha: 1.00)
            selfiePicker.dismiss(animated: true)
            debugPrint("camera")
            let convertstart = info[.originalImage] as? UIImage
            globalImage_selfie = convertstart!.wxCompress()
            let imgData_1 = NSData(data: globalImage_selfie!.jpegData(compressionQuality: 1)!)
            var imageSize_1: Int = imgData_1.count
            print("camera image size in KB: %f ", Double(imageSize_1) / 1000.0)
        }
        if get_into != nil{
            final_submit.backgroundColor = UIColor(red: 0.00, green: 0.50, blue: 0.50, alpha: 1.00)
        }
        }
    func fetchData(nameImage : String) -> UIImage{
            let docDir = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            let filePath = docDir.appendingPathComponent(nameImage);
            if FileManager.default.fileExists(atPath: filePath.path){
                if let containOfFilePath = UIImage(contentsOfFile : filePath.path){
                    debugPrint("This is path")
                    debugPrint(containOfFilePath)
                    return containOfFilePath;
                }
            }
            return UIImage();
        }
}
