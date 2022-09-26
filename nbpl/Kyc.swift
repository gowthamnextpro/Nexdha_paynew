//
//  Kyc.swift
//  nbpl
//
//  Created by Nexdha on 18/07/22.
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


class Kyc: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet weak var upload4: UIButton!
    @IBOutlet weak var upload2: UIButton!
    @IBOutlet weak var upload3: UIButton!
    @IBOutlet weak var upload1: UIButton!
    
    @IBOutlet weak var anime: AnimationView!
    @IBOutlet weak var back_image: UIImageView!
    @IBOutlet weak var submit: UIButton!

    @IBOutlet weak var view_preview4: UILabel!
    @IBOutlet weak var view_preview3: UILabel!
    @IBOutlet weak var view_preview2: UILabel!
    @IBOutlet weak var view_preview1: UILabel!
    
    @IBOutlet weak var sub_btn: UIButton!
    
    @IBOutlet weak var h1_view: UIStackView!
    @IBOutlet weak var h2_view: UIStackView!
    
    
    
    var open_please = ""
    var count = 0
    var imagePicker = UIImagePickerController()
    var globalImage:UIImage? = nil
    
    var imagePicker_gallery = UIImagePickerController()
    var globalImage_gallery:UIImage? = nil
    
    var imagePicker_afront = UIImagePickerController()
    var globalImage_afront:UIImage? = nil
    
    var imagePicker_aback = UIImagePickerController()
    var globalImage_aback:UIImage? = nil
    override var preferredStatusBarStyle: UIStatusBarStyle {
           return .lightContent
       }
    override func viewDidLoad() {
        super.viewDidLoad()
        counter_check()
        h1_view.layer.cornerRadius = 25
        h2_view.layer.cornerRadius = 25
        upload1.layer.cornerRadius = 20
        upload2.layer.cornerRadius = 20
        upload3.layer.cornerRadius = 20
        upload4.layer.cornerRadius = 20
        submit.layer.cornerRadius  = 25
        let alert_dismiss_kyc = UITapGestureRecognizer(target: self, action: #selector(back_go(_:)))
        back_image.addGestureRecognizer(alert_dismiss_kyc)
        
        let pan_view = UITapGestureRecognizer(target: self, action: #selector(view_pan(_:)))
        view_preview1.addGestureRecognizer(pan_view)
        let af = UITapGestureRecognizer(target: self, action: #selector(aadhar_f(_:)))
        view_preview2.addGestureRecognizer(af)
        let ab = UITapGestureRecognizer(target: self, action: #selector(aadhar_b(_:)))
        view_preview3.addGestureRecognizer(ab)
        let selfie_view = UITapGestureRecognizer(target: self, action: #selector(selfie_only(_:)))
        view_preview4.addGestureRecognizer(selfie_view)
        
        
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
    override func viewWillAppear(_ animated: Bool) {
      counter_check()
      super.viewWillAppear(animated)
    }
    @IBAction func selfie(_ sender: Any) {
        imagePicker =  UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .camera
        open_please = "camera"
        present(imagePicker, animated: true, completion: nil)
    }
    @IBAction func aadhar_front(_ sender: Any) {
        imagePicker_afront =  UIImagePickerController()
        imagePicker_afront.delegate = self
        imagePicker_afront.allowsEditing = false
        imagePicker_afront.sourceType = .photoLibrary
        open_please = "a_front"
        present(imagePicker_afront, animated: true, completion: nil)
    }
    @IBAction func aadhar_back(_ sender: Any) {
        imagePicker_aback =  UIImagePickerController()
        imagePicker_aback.delegate = self
        imagePicker_aback.allowsEditing = false
        imagePicker_aback.sourceType = .photoLibrary
        open_please = "a_back"
        present(imagePicker_aback, animated: true, completion: nil)
    }
    @IBAction func pan_open(_ sender: Any) {
        imagePicker_gallery =  UIImagePickerController()
        imagePicker_gallery.delegate = self
        imagePicker_gallery.allowsEditing = false
        imagePicker_gallery.sourceType = .photoLibrary
        open_please = "gallery"
        present(imagePicker_gallery, animated: true, completion: nil)
    }
    @objc func back_go(_ sender: Any){
         self.dismiss(animated: false, completion: nil)
    }
    @objc func aadhar_f(_ sender: Any){
        debugPrint("button clicked")
         let alert_gallery_afront = UIAlertController(title: "Aadhaar Front", message: "\n\n\n\n\n\nNot Provided\n\n\n\n\n\n\n\n", preferredStyle: .alert)
           //alert.isModalInPopover = true
        var imageiew_afront = UIImageView(frame: CGRect(x: 10, y: 20, width: 250 , height: 240))
           imageiew_afront.image = globalImage_afront
        debugPrint(globalImage_afront)
        alert_gallery_afront.view.addSubview(imageiew_afront)
        alert_gallery_afront.addAction(UIAlertAction(title: "Close", style: .cancel, handler: { (UIAlertAction) in
        }))
        self.present(alert_gallery_afront, animated: true, completion: nil)
    }
    @objc func selfie_only(_ sender: Any){
        let alert = UIAlertController(title: "Selfie", message: "\n\n\n\n\n\nNot Provided\n\n\n\n\n\n\n\n", preferredStyle: .alert)
        var imageiew = UIImageView(frame: CGRect(x: 10, y: 20, width: 250 , height: 240))
        imageiew.image = globalImage
        debugPrint(globalImage)
        alert.view.addSubview(imageiew)
        alert.addAction(UIAlertAction(title: "Close", style: .cancel, handler: { (UIAlertAction) in
        }))
        self.present(alert, animated: true, completion: nil)
    }
    @objc func aadhar_b(_ sender: Any){
        debugPrint("button clicked")
        let alert_gallery_aback = UIAlertController(title: "Aadhaar Back", message: "\n\n\n\n\n\nNot Provided\n\n\n\n\n\n\n\n", preferredStyle: .alert)
        var imageiew_aback = UIImageView(frame: CGRect(x: 10, y: 20, width: 250 , height: 240))
           imageiew_aback.image = globalImage_aback
        debugPrint(globalImage_aback)
        alert_gallery_aback.view.addSubview(imageiew_aback)
        alert_gallery_aback.addAction(UIAlertAction(title: "Close", style: .cancel, handler: { (UIAlertAction) in
        }))
        self.present(alert_gallery_aback, animated: true, completion: nil)
    }
    
    @objc func view_pan(_ sender: Any){
        debugPrint("button clicked")
        let alert_gallery = UIAlertController(title: "PAN", message: "\n\n\n\n\n\nNot Provided\n\n\n\n\n\n\n\n", preferredStyle: .alert)
          //alert.isModalInPopover = true
        var imageiew_gallery = UIImageView(frame: CGRect(x: 10, y: 20, width: 250 , height: 240))
        imageiew_gallery.image = globalImage_gallery
        debugPrint(globalImage_gallery)
        alert_gallery.view.addSubview(imageiew_gallery)
        alert_gallery.addAction(UIAlertAction(title: "Close", style: .cancel, handler: { (UIAlertAction) in
       }))
       self.present(alert_gallery, animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
        debugPrint("Thissssss")
       if open_please == "gallery"{
            view_preview1.textColor = UIColor(red: 0.00, green: 0.50, blue: 0.50, alpha: 1.00)
            imagePicker_gallery.dismiss(animated: true)
            debugPrint("gallery")
            let convert_gallery = info[.originalImage] as? UIImage
            globalImage_gallery = convert_gallery!.wxCompress()
            let imgData_1 = NSData(data: globalImage_gallery!.jpegData(compressionQuality: 1)!)
            var imageSize_1: Int = imgData_1.count
            print("pan image size in KB: %f ", Double(imageSize_1) / 1000.0)
        }else if open_please == "a_front"{
            view_preview2.textColor = UIColor(red: 0.00, green: 0.50, blue: 0.50, alpha: 1.00)
            imagePicker_afront.dismiss(animated: true)
            debugPrint("a_front")
            let convert_aadhaar_f =  info[.originalImage] as? UIImage
            globalImage_afront = convert_aadhaar_f!.wxCompress()
            let imgData_1 = NSData(data: globalImage_afront!.jpegData(compressionQuality: 1)!)
            var imageSize_1: Int = imgData_1.count
            print("aadhaar front size in KB: %f ", Double(imageSize_1) / 1000.0)
        }else if open_please == "a_back"{
            view_preview3.textColor = UIColor(red: 0.00, green: 0.50, blue: 0.50, alpha: 1.00)
            imagePicker_aback.dismiss(animated: true)
            debugPrint("a_back")
            //imageView.image = info[.originalImage] as? UIImage
            let convert_aadhaar_back = info[.originalImage] as? UIImage
            globalImage_aback = convert_aadhaar_back!.wxCompress()
            let imgData_1 = NSData(data: globalImage_aback!.jpegData(compressionQuality: 1)!)
            var imageSize_1: Int = imgData_1.count
            print("aadhaar back size in KB: %f ", Double(imageSize_1) / 1000.0)
        }
       else if open_please == "camera"{
            view_preview4.textColor = UIColor(red: 0.00, green: 0.50, blue: 0.50, alpha: 1.00)
            imagePicker.dismiss(animated: true)
            debugPrint("camera")
            let convertstart = info[.originalImage] as? UIImage
            globalImage = convertstart!.wxCompress()
            let imgData_1 = NSData(data: globalImage!.jpegData(compressionQuality: 1)!)
            var imageSize_1: Int = imgData_1.count
            print("camera image size in KB: %f ", Double(imageSize_1) / 1000.0)
        }
        if open_please != nil{
            submit.backgroundColor = UIColor(red: 0.00, green: 0.50, blue: 0.50, alpha: 1.00)
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
    @IBAction func upload(_ sender: Any) {
        if (globalImage_gallery == nil) {
            self.Toast1(Title: "Upload PAN card Image", Text: "", delay: 3)
        }else if (globalImage_afront == nil){
            self.Toast1(Title: "Upload Aadhaar card front image", Text: "", delay: 3)
        }else if(globalImage_aback == nil){
            self.Toast1(Title: "Upload Aadhaar card back image", Text: "", delay: 3)
        }else if (globalImage == nil){
            self.Toast1(Title: "Take a selfie", Text: "", delay: 3)
        }else{
            fileupload()
        }
    }
    func Toast1(Title:String ,Text:String, delay:Int) -> Void {
        let alert = UIAlertController(title: Title, message: Text, preferredStyle: .alert)
        self.present(alert, animated: true)
        let deadlineTime = DispatchTime.now() + .seconds(delay)
        DispatchQueue.main.asyncAfter(deadline: deadlineTime, execute: {
            alert.dismiss(animated: true, completion: nil)
          //  self.performSegue(withIdentifier: "kyc_to_parentdashboard", sender: self)
        })
    }
    func Toast12(Title:String ,Text:String, delay:Int) -> Void {
        let alert = UIAlertController(title: Title, message: Text, preferredStyle: .alert)
        self.present(alert, animated: true)
        let deadlineTime = DispatchTime.now() + .seconds(delay)
        DispatchQueue.main.asyncAfter(deadline: deadlineTime, execute: {
            alert.dismiss(animated: true, completion: nil)
        })
    }
    public func activity_log(){
        let headers: HTTPHeaders = [
            .authorization(UserDefaults.standard.string(forKey: "token") as! String)
        ]
        
        let parameters = ["activity_id": "203" ,"os": "iOS"]

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
    public func fileupload(){
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
                    multipartFormData.append(self.globalImage!.jpegData(compressionQuality: 0.5)!, withName: "selfie" , fileName: AppDelegate.Nexdha_student.phone+"_s.jpeg", mimeType: "image/jpeg")
                    multipartFormData.append(self.globalImage_gallery!.jpegData(compressionQuality: 0.5)!, withName: "pan" , fileName: AppDelegate.Nexdha_student.phone+"_p.jpeg", mimeType: "image/jpeg")
                    multipartFormData.append(self.globalImage_afront!.jpegData(compressionQuality: 0.5)!, withName: "aadhaar_front" , fileName: AppDelegate.Nexdha_student.phone+"_af.jpeg", mimeType: "image/jpeg")
                    multipartFormData.append(self.globalImage_aback!.jpegData(compressionQuality: 0.5)!, withName: "aadhaar_back" , fileName: AppDelegate.Nexdha_student.phone+"_ab.jpeg", mimeType: "image/jpeg")
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
            self.performSegue(withIdentifier: "parentkyc_to_home", sender: nil)
        })
    }
    @objc func alertaction(_ sender: Any) {
        debugPrint("alert action")
       self.performSegue(withIdentifier: "kyc_to_parentdashboard", sender: self)
        
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        debugPrint("Cancelled")
       dismiss(animated: true, completion: nil)
    }
    }



