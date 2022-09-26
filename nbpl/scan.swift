//
//  scan.swift
//  nbpl
//
//  Created by Nexdha on 03/06/22.
//

import Foundation
import UIKit
import Alamofire
import AVFoundation
import SwiftyJSON
import CryptoKit
class scan: UIViewController , AVCaptureMetadataOutputObjectsDelegate{
  
    var emptyString = ""
    var emptyString_name = ""
    var hello1 = ""
    var hello2 = ""
    var hello3 = ""
    var hello4 = ""
    var inputString = ""
    var typedata_for_upi: [String] = [String]()
    var upi_id = ""

    @IBOutlet weak var bhimupi_color_bg: UIImageView!
    let session = AVCaptureSession()
    var previewLayer = AVCaptureVideoPreviewLayer()
    var count = 0
    @IBOutlet weak var back_from_scan: UIImageView!
    @IBOutlet weak var cancel: UILabel!
    @IBOutlet weak var scan_qr: UIImageView!
    override var preferredStatusBarStyle: UIStatusBarStyle {
           return .lightContent
       }
    override func viewDidLoad() {
        super.viewDidLoad()
        bhimupi_color_bg.backgroundColor = UIColor(red: 0.07, green: 0.07, blue: 0.07, alpha: 1.00)
        let scan = UITapGestureRecognizer(target: self, action: #selector(scanned(_:)))
        back_from_scan.addGestureRecognizer(scan)
        counter_check()
        let captureDevice = AVCaptureDevice.default(for: AVMediaType.video)
        if AVCaptureDevice.authorizationStatus(for: AVMediaType.video) ==  AVAuthorizationStatus.authorized {
            // Already Authorized
            print("hiiii")
           /* let alert = UIAlertController(title: "when to alloww", message:
                  "this are 1", preferredStyle: .actionSheet)
            
            alert.addAction(UIAlertAction(title: "ok", style: .default, handler: { action in
              //  self.session.startRunning()
            }))
            
            self.present(alert, animated: true, completion: nil)*/
         /*   let alertController = UIAlertController (title: "Title", message: "Go to Settings?", preferredStyle: .alert)

            let settingsAction = UIAlertAction(title: "Settings", style: .default) { (_) -> Void in

                guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
                    return
                }
                if UIApplication.shared.canOpenURL(settingsUrl) {
                    UIApplication.shared.open(settingsUrl, completionHandler: { (success) in
                        print("Settings opened: \(success)") // Prints true
                        if(success == true){
                            self.performSegue(withIdentifier: "to_scan", sender: nil)
                        }
                        else{
                            let alert = UIAlertController(title: "please allow the permission to proceed further", message:
                                     "CAMERA PERMISSION", preferredStyle: .actionSheet)
                               
                               alert.addAction(UIAlertAction(title: "ok", style: .default, handler: { action in

                               }))
                               
                               self.present(alert, animated: true, completion: nil)
                        }
                    })
                }
            }
            alertController.addAction(settingsAction)
            let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
            alertController.addAction(cancelAction)
            present(alertController, animated: true, completion: nil)*/
        } else {
            AVCaptureDevice.requestAccess(for: AVMediaType.video, completionHandler: { (granted: Bool) -> Void in
               if granted == true {
                   // User granted
                /*   let alert = UIAlertController(title: "caheck", message:
                         "check this", preferredStyle: .actionSheet)
                   
                   alert.addAction(UIAlertAction(title: "ok", style: .default, handler: { action in
                     //  self.session.startRunning()
                   }))
                   
                   self.present(alert, animated: true, completion: nil)*/
                   print("123")
               } else {
                /*   let alert = UIAlertController(title: "camera permission to allow", message:
                         "please", preferredStyle: .actionSheet)
                   alert.addAction(UIAlertAction(title: "ok", style: .default, handler: { action in
                     //  self.session.startRunning()
                   }))
                   self.present(alert, animated: true, completion: nil)
                   print("546546545445")*/
                   // User rejected
               }
           })
        }

        do {
            let input = try AVCaptureDeviceInput(device: captureDevice!)
            session.addInput(input)
        } catch {
            print("Error capturing QRCode")
        }
        ///thiss

        let output = AVCaptureMetadataOutput()
        session.addOutput(output)
        
        output.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
        output.metadataObjectTypes = [AVMetadataObject.ObjectType.qr]
        
        
        previewLayer = AVCaptureVideoPreviewLayer(session: session)
        previewLayer.frame = view.layer.bounds
     
        //Aakash Changed
        //previewLayer.frame = view.layer.bounds
        //Change ended
        ///thiss

     ///   self.previewLayer.frame = self.view.layer.frame

///thiss
       // view.layer.addSublayer(previewLayer)
        
        //Aakash Changed
        scan_qr.layer.addSublayer(previewLayer)
        //Change Ended
      //  img_scan.layer.borderWidth = 2
        //img_scan.layer.cornerRadius = 10
     //   img_scan.layer.masksToBounds = (300 != 0)
     //   img_scan.layer.shadowOffset.height = 150
   
     //   img_scan.layer.borderColor = UIColor.lightGray.cgColor
        self.view.bringSubviewToFront(scan_qr)
        session.startRunning()
   ///this
        ////////////////for check the design
       /* previewLayer = AVCaptureVideoPreviewLayer(session: session)
        view.layer.addSublayer(previewLayer)
        previewLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
        previewLayer.frame = view.layer.frame*/
    //   previewLayer.frame = self.view.layer.frame
    //   previewLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
      //  previewLayer.connection?.videoOrientation = .portrait
        ///thiss

        //Aakash Changed
       self.scan_qr.layer.addSublayer(previewLayer)
        //Change Ended
        
      
        
     /*   //portrait orientation, status bar is shown
        additionalSafeAreaInsets.top = 24.0
        additionalSafeAreaInsets.bottom = 34.0

        //portrait orientation, status bar is hidden
        additionalSafeAreaInsets.top = 44.0
        additionalSafeAreaInsets.bottom = 34.0

        //landscape orientation
        additionalSafeAreaInsets.left = 44.0
        additionalSafeAreaInsets.bottom = 21.0
        additionalSafeAreaInsets.right = 44.0*/
        
        ///thiss

        
      /*  let cgRect = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height)
                let myView = UIImageView()
        //view.contentMode = .scaleAspectFit

       view.frame = cgRect
       view.backgroundColor = UIColor.clear
       view.isOpaque = false
       view.layer.cornerRadius = 0
       view.layer.borderColor =  UIColor.lightGray.cgColor
       view.layer.borderWidth = 20

       view.layer.masksToBounds = false*/

     
     
      //  view.addSublayer(session.layer)
                // Bring the camera button to front
        //        view.bringSubview(toFront: cameraButton)
        
        ///////////for check the design
        ///
        ///
        ///////this

    }
    public func activity_log(){
        let headers: HTTPHeaders = [
            .authorization(UserDefaults.standard.string(forKey: "token") as! String)
        ]
        
        let parameters = ["activity_id": "104" ,"os": "iOS"]

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
    override func viewWillAppear(_ animated: Bool) {
      counter_check()
      super.viewWillAppear(animated)
    }
    func Toast(Title:String ,Text:String, delay:Int) -> Void {
        let alert = UIAlertController(title: Title, message: Text, preferredStyle: .alert)
        self.present(alert, animated: true)
        let deadlineTime = DispatchTime.now() + .seconds(delay)
        DispatchQueue.main.asyncAfter(deadline: deadlineTime, execute: {
            alert.dismiss(animated: true, completion: nil)
            self.performSegue(withIdentifier: "scan_to_home", sender: nil)
        })
    }
    @objc func scanned(_ sender: Any) {
        print("||||||||")
    ///    self.performSegue(withIdentifier: "scan_to_dashboard", sender: nil)
        self.dismiss(animated: true, completion: nil)
    }
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
         if let metaDataObject = metadataObjects.first {
             guard let readableObject = metaDataObject as? AVMetadataMachineReadableCodeObject else {
                 return
             }
           /*  let alert = UIAlertController(title: "QRCode", message: readableObject.stringValue, preferredStyle: .actionSheet)
             
             alert.addAction(UIAlertAction(title: "ok", style: .default, handler: { action in
               self.session.startRunning()
                 
              //   self.performSegue(withIdentifier: "nft_page", sender: self)

             }))
             present(alert, animated: true, completion: nil)*/
             let inputString = readableObject.stringValue!
             print(inputString)
             let splits = inputString.components(separatedBy: "?")
             let first_split = splits[0]
             print(first_split)
             let first_split1 = splits[1]
             print(first_split1)
             let first_split_check = first_split1.components(separatedBy: "&")
             print(first_split_check)
             let final = first_split_check[0]
             print(final)
             let final1 = first_split_check[1]
             print(final1)
           //  typedata_for_upi = characters
        /*    let splits = inputString?.components(separatedBy: "tr=")
             print(splits)
             let firstName = splits?[0]
             print("this is first")
             let splits1 = firstName?.components(separatedBy: "&pn=")
             print("B1")
             print(splits1)
             let next_one = splits1?[0]
             let next_one2 = splits1?[1]
             print("v1")
             print(next_one)
             print("12345")
             print(next_one2)
             let named = next_one2?.components(separatedBy: "&")
             print(named)
             let hello_wellfire = named?[0]
             print("vee")
             let splits121 = next_one2?.components(separatedBy: "&mc")
             print("welcome")
             print(splits121)
             let name_from_scan = splits121?[0]
           //  let trimmed = name_from_scan?.trimmingCharacters(in: .whitespacesAndNewlines)
             let newString = hello_wellfire?.replacingOccurrences(of: "%20", with: " ", options: .literal, range: nil)
             emptyString_name = newString!
             print(name_from_scan)
             print("only_one")
             print(next_one2)
             print("u1")
             print(next_one)
             let splits_for_final = next_one?.components(separatedBy: "pa=")
             print(splits_for_final)
             let firstName_only_for_you = splits_for_final?[0]
             let firstName_only_for_you_one = splits_for_final?[1]
             print("elon")
             print(firstName_only_for_you)
             print("Jack")
             print(firstName_only_for_you_one)
             let newString_id = firstName_only_for_you_one?.replacingOccurrences(of: "%20", with: " ", options: .literal, range: nil)
             //let trimmed1 = firstName_only_for_you_one?.trimmingCharacters(in: .whitespacesAndNewlines)
             emptyString = newString_id!//////////noted this final upi
             print("12345")
             print(emptyString)
             print("string of empty")
             print("only_two")
             let next_two = splits1?[1]
             print("only_one")
             print(next_two)
             print("s2")
             print("s3")
             print("this is second")
             print("this is three")
             let lastName =  splits1?[1]
             print(firstName) /// needed
             print(lastName)*/
             
             for i in first_split_check{
                 print("123456")
                 print(i)
                 print("final")
                 if i.contains("pa=") {
                     print("s1")
                     print(i)
                     print("s2")
                     let final = i.components(separatedBy: "=")
                     let upi_id_final = final[0]
                     print(upi_id_final)
                     upi_id = final[1]
                 }
                // ("\(name["status"])")
                // type_array[name] = name*/
             }
             self.Upi_trans()

           /*  let alert = UIAlertController(title: "UPI Verified", message: upi_id, preferredStyle: .actionSheet)
             alert.addAction(UIAlertAction(title: "Pay", style: .default, handler:  { action in
             self.Upi_trans()
                             }))
             alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler:
                             { action in
             self.performSegue(withIdentifier: "scan_to_dash_only", sender: nil)
                 self.session.stopRunning()
                             }))
             self.present(alert, animated: true, completion: nil)*/
            
             
            /*  let image = UIImageView(image: UIImage(named: "check"))
             alert.view.addSubview(image)
             image.translatesAutoresizingMaskIntoConstraints = false
             alert.view.addConstraint(NSLayoutConstraint(item: image, attribute: .centerX, relatedBy: .equal, toItem: alert.view, attribute: .centerX, multiplier: 1, constant: 350))
             alert.view.addConstraint(NSLayoutConstraint(item: image, attribute: .centerY, relatedBy: .equal, toItem: alert.view, attribute: .centerY, multiplier: 1, constant: 0))
             alert.view.addConstraint(NSLayoutConstraint(item: image, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 20.0))
             alert.view.addConstraint(NSLayoutConstraint(item: image, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 20.0))*/
             
             
             
         }else{
            // self.performSegue(withIdentifier: "scan_to_view_controller", sender: self)
         }
     }
    public func Upi_trans(){
     //   let first_name = firstname.text
      
        debugPrint("this is upi")
      
        let headers: HTTPHeaders = [
            .authorization(UserDefaults.standard.object(forKey: "token") as! String)
                ]
        debugPrint(headers)
         print(emptyString)
        
        let inputString1 = "kmKHO0vpCxUK5m9fAs0Z"
        let inputString2 = "upi" + upi_id + inputString1
        print(inputString2)
        let inputData = Data(inputString2.utf8)
        let hashed = SHA512.hash(data: inputData)
        print(hashed.description)
        let hash = hashed.compactMap { String(format: "%02x", $0) }.joined()
        print(hash)
        
        let parameters = ["upi_id": upi_id,"account_type":"upi", "name" : hash]
        debugPrint(parameters)
        
         
        AF.request(AppDelegate.Nexdha_student.server+"/api/upi_verifyy", method: .post, parameters: parameters, headers: headers).responseJSON { response in
                    debugPrint(response)
            switch response.result{
                            case .success(let value):
                                let json = JSON(value)
                                //self.Toast(Title: "DONE", Text: json["status"]["BRANCH"].string!, delay: 3)
                                print(json)
                                let add_status = json["statuss"]
                                let add_status1 = json["name"]
                                print(add_status1)
                              //  AppDelegate.Nexdha_student.Upi_name  = hello2.emptyString_name
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
                                if add_status == "success" {
                               //     self.progress_bar.isHidden = true
                               //     self.progress_bar.stopAnimating()
                                //    self.Toast(Title: "DONE", Text: "Beneficiary Saved", delay: 3)
                                    self.session.stopRunning()
                                    AppDelegate.Nexdha_student.Upi_name = add_status1.stringValue
                                    AppDelegate.Nexdha_student.Upi_id   = self.upi_id
                                self.performSegue(withIdentifier: "scanner_to_detailedpay", sender: nil)
                                }else{
                                    self.session.stopRunning()
                                  //  self.progress_bar.isHidden = true
                                 //   self.progress_bar.stopAnimating()
                                    self.Toast(Title: "Error", Text: add_status.rawValue as! String, delay: 3)
                }
                               
                            case.failure(let error):
                                print(error)
                            }
            
            
                }
    }

}
