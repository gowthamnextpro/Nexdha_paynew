//
//  Modalviewcontroller.swift
//  nbpl
//
//  Created by Nexdha on 11/06/22.
//

import Foundation
import Alamofire
import SwiftyJSON
import AVFoundation
import Lottie



class Modalviewcotroller: UIViewController {
 
    @IBOutlet weak var enter_upi_grad: UIButton!
    @IBOutlet weak var sp_pay_grad: UIButton!
    
    @IBOutlet weak var scan: AnimationView!
    @IBOutlet weak var stack_view: UIStackView!
    @IBOutlet weak var enter_upi: UIStackView!
    @IBOutlet weak var scaned: UIStackView!
   // var animationView : AnimationView?
    @IBOutlet weak var divider: UIView!
    lazy var moodselectionVc = UIStoryboard(name: "Main" , bundle: nil).instantiateViewController(withIdentifier: "enterupipage")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sp_pay_grad.new_grad(colors: [UIColor(red: 0.24, green: 0.08, blue: 0.58, alpha: 1.00).cgColor, UIColor.magenta.cgColor])
        sp_pay_grad.clipsToBounds = true
        sp_pay_grad.layer.cornerRadius = 25
        enter_upi_grad.new_grad(colors: [UIColor.magenta.cgColor, UIColor(red: 0.24, green: 0.08, blue: 0.58, alpha: 1.00).cgColor])
        enter_upi_grad.clipsToBounds = true
        enter_upi_grad.layer.cornerRadius = 25


        
        scan.isHidden = false
        scan?.contentMode = .scaleAspectFit
        scan?.loopMode =  .loop
        scan?.animationSpeed = 0.85
     //   animationview?.backgroundColor = UIColor(red: 0.00, green: 0.00, blue: 0.00, alpha: 1.00)
        scan?.play()
        divider.backgroundColor = UIColor(red: 0.18, green: 0.18, blue: 0.18, alpha: 1.00)
       /* let scan_upi = UITapGestureRecognizer(target: self, action: #selector(scan_upi(_:)))
        scaned.addGestureRecognizer(scan_upi)
        
        
        let enterupi = UITapGestureRecognizer(target: self, action: #selector(stacks(_:)))
        enter_upi.addGestureRecognizer(enterupi)*/
        
        
        
     /*  self.sp_pay_grad.layer.cornerRadius = self.sp_pay_grad.frame.height/3
        self.sp_pay_grad.clipsToBounds = true

        let gradient = CAGradientLayer()
        gradient.frame =  CGRect(origin: CGPoint.zero, size: self.sp_pay_grad.frame.size)
        gradient.colors =  [UIColor.blue.cgColor, UIColor.green.cgColor]

        let shape = CAShapeLayer()
        shape.lineWidth = 1
      //  shape.path = UIBezierPath(roundedRect: self.sp_pay_grad.bounds.insetBy(dx: 2.5, dy: 2.5), cornerRadius: 15.0).cgPath

        shape.path = UIBezierPath(roundedRect: self.sp_pay_grad.bounds, cornerRadius: self.sp_pay_grad.layer.cornerRadius).cgPath

        shape.strokeColor = UIColor.black.cgColor
        shape.fillColor = UIColor.clear.cgColor
        gradient.mask = shape

        self.sp_pay_grad.layer.addSublayer(gradient)*/
        //sp_pay_grad.setGradientBorderWidthColor
        
       
      /*  let gradient = CAGradientLayer()
           gradient.frame =  CGRect(origin: CGPoint.zero, size: self.sp_pay_grad.frame.size)
           gradient.colors = [UIColor.blue.cgColor, UIColor.green.cgColor]

           let shape = CAShapeLayer()
           shape.lineWidth = 2
           shape.path = UIBezierPath(roundedRect: self.sp_pay_grad.bounds, cornerRadius: 22).cgPath
           shape.strokeColor = UIColor.black.cgColor
           shape.fillColor = UIColor.clear.cgColor
           gradient.mask = shape

           self.sp_pay_grad.layer.addSublayer(gradient)*/

        
        
        
        
     /*   let gradientColor = CAGradientLayer()
        gradientColor.frame =  CGRect(origin: CGPoint.zero, size: sp_pay_grad.frame.size)
        gradientColor.colors = [UIColor.red.cgColor, UIColor.blue.cgColor, UIColor.green.cgColor]
        let shape = CAShapeLayer()
        shape.lineWidth = 3
        shape.path = UIBezierPath(rect: sp_pay_grad.bounds).cgPath
        shape.strokeColor = UIColor.black.cgColor
        shape.fillColor = UIColor.clear.cgColor
        gradientColor.mask = shape
        sp_pay_grad.clipsToBounds = true
        sp_pay_grad.layer.addSublayer(gradientColor)*/
       
    }
    @IBAction func scanpay(_ sender: Any) {
        moodselectionVc.dismiss(animated: true , completion: nil)
        openCamera()
        
    }
    @IBAction func enter_pay(_ sender: Any) {
        moodselectionVc.dismiss(animated: true , completion: nil)
        self.performSegue(withIdentifier: "enter_upi_page", sender: nil)
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
           return .lightContent
       }
    @objc func scan_upi(_ sender: Any){
        moodselectionVc.dismiss(animated: true , completion: nil)
        openCamera()
    }
  
    @objc func stacks(_ sender: Any){
       
       /* if let sheet = moodselectionVc.sheetPresentationController{
               sheet.detents = [.medium()]
            sheet.prefersScrollingExpandsWhenScrolledToEdge = false
            sheet.prefersGrabberVisible = true
            sheet.preferredCornerRadius = 50
            sheet.largestUndimmedDetentIdentifier = .medium
        }
        
        self.present(moodselectionVc,animated: true, completion: nil)*/
        moodselectionVc.dismiss(animated: true , completion: nil)
        self.performSegue(withIdentifier: "enter_upi_page", sender: nil)

        
    }

       
    private func openCamera() {
          switch AVCaptureDevice.authorizationStatus(for: .video) {
          case .authorized:  // the user has already authorized to access the camera.
         //     self.setupCaptureSession()
              print("Redirecting to scanner")
              self.performSegue(withIdentifier: "modalviews_scanner", sender: nil)
          case .notDetermined: // the user has not yet asked for camera access.
              AVCaptureDevice.requestAccess(for: .video) { (granted) in
                  DispatchQueue.main.async {

                  if granted { // if user has granted to access the camera.
                      print("the user has granted to access the camera")

                      DispatchQueue.main.async {
                    //      self.setupCaptureSession()
                       //   self.performSegue(withIdentifier: "to_scan", sender: self)
                        //  self.bottom_view.isHidden = true
                          self.performSegue(withIdentifier: "modalviews_scanner", sender: nil)
                      }
                  } else {
                      print("the user has not granted to access the camera")
                   //   self.handleDismiss()
                      let alertController = UIAlertController (title: "Camera Permission", message: "Allow the Camera Permission", preferredStyle: .alert)

                         let settingsAction = UIAlertAction(title: "Settings", style: .default) { (_) -> Void in

                             guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
                                 return
                             }

                             if UIApplication.shared.canOpenURL(settingsUrl) {
                                 UIApplication.shared.open(settingsUrl, completionHandler: { (success) in
                                     print("Settings opened: \(success)") // Prints true
                                     if(success == true){
                                         self.performSegue(withIdentifier: "modalviews_scanner", sender: nil)
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
                         print(cancelAction)
                         self.present(alertController, animated: true, completion: nil)
                  }
              }
              }
          case .denied:
              print("the user has denied previously to access the camera.")
             // self.handleDismiss()
              
           let alertController = UIAlertController (title: "Camera Permission", message: "Allow the Camera Permission", preferredStyle: .alert)

              let settingsAction = UIAlertAction(title: "Settings", style: .default) { (_) -> Void in

                  guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
                      return
                  }

                  if UIApplication.shared.canOpenURL(settingsUrl) {
                      UIApplication.shared.open(settingsUrl, completionHandler: { (success) in
                          print("Settings opened: \(success)") // Prints true
                          if(success == true){
                              self.performSegue(withIdentifier: "modalviews_scanner", sender: nil)
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
              print(cancelAction)

              self.present(alertController, animated: true, completion: nil)
          case .restricted:
              print("the user can't give camera access due to some restriction.")
            //  self.handleDismiss()
              
              
              let alertController = UIAlertController (title: "Camera Permission", message: "Allow the Camera Permission", preferredStyle: .alert)

                 let settingsAction = UIAlertAction(title: "Settings", style: .default) { (_) -> Void in

                     guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
                         return
                     }

                     if UIApplication.shared.canOpenURL(settingsUrl) {
                         UIApplication.shared.open(settingsUrl, completionHandler: { (success) in
                             print("Settings opened: \(success)") // Prints true
                             if(success == true){
                                 self.performSegue(withIdentifier: "modalviews_scanner", sender: nil)
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
                 print(cancelAction)

                 self.present(alertController, animated: true, completion: nil)
              
          default:
              print("something has wrong due to we can't access the camera.")
              let alert = UIAlertController(title: "Camera permission", message: "something has wrong due to we can't access the camera.", preferredStyle: .alert)
              // let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
              // alert.addAction(okAction)
               present(alert, animated: true, completion: nil)
           //   self.handleDismiss()
          }
      }
}
