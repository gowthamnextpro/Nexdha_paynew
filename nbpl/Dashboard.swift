//
//  Dashboard.swift
//  nbpl
//
//  Created by Nexdha on 03/06/22.
//

import Foundation
import UIKit
import Alamofire
import AVFoundation
import SwiftyJSON
import DynamicBottomSheet
import Then
import BLTNBoard
import CoreLocation

class Dashboard: UIViewController , UITextFieldDelegate, UIGestureRecognizerDelegate, CLLocationManagerDelegate {
    @IBOutlet var main_view: UIView!
    @IBOutlet weak var logo_check: UIImageView!
    @IBOutlet weak var enterupis: UIStackView!
    @IBOutlet weak var scaned: UIStackView!
    @IBOutlet weak var viewer: UIStackView!
    @IBOutlet weak var welcome_name: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var amont_due: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var due_layout: UIStackView!
    @IBOutlet weak var layouts: UIStackView!
    @IBOutlet weak var request_amount: UIButton!
    @IBOutlet weak var btn_stacks: UIStackView!
    @IBOutlet weak var camera_access: UIImageView!
    @IBOutlet weak var cred: UILabel!
    @IBOutlet weak var enter_upi: UIStackView!
    @IBOutlet weak var dropdown: UIImageView!
    @IBOutlet weak var feedback_student: UIImageView!
    @IBOutlet weak var info_only: UIImageView!
    @IBOutlet weak var due_views1: UIStackView!
    var credits: [String] = [String]()
    var name_cred = [""]
    var count = 0
    var location_count = Int(0)
    var lat_long = ""
    let locationManager = CLLocationManager()
    @IBOutlet weak var bottom: NSLayoutConstraint!
    @IBOutlet weak var height: NSLayoutConstraint!
    @IBOutlet weak var leading: NSLayoutConstraint!
    @IBOutlet weak var trailing: NSLayoutConstraint!
    @IBOutlet weak var bottom_view: UIView!
    @IBOutlet weak var Paying: UIButton!
  //  private var isBottomSheetShown = false
    lazy var moodselectionVc = UIStoryboard(name: "Main" , bundle: nil).instantiateViewController(withIdentifier: "view_from_bottom")
    private lazy var boardManager: BLTNItemManager = {
      let item = BLTNPageItem(title: "")
       // item.image = UIImage(named: "scan50")
        item.actionButtonTitle = "Scan & Pay"
        item.alternativeButtonTitle = "Enter UPI id"
     //   item.descriptionText = "Hello"
       // item.performSelector(inBackground: <#T##Selector#>, with: <#T##Any?#>).backgroundColor = UIColor(red: 1.00, green: 0.00, blue: 0.00, alpha: 1.00)
        definesPresentationContext = true

        
        item.actionHandler = { _ in
            
            self.didtappedcontinued()
        }
        item.alternativeHandler = { _ in
            
            self.didnottapped()
        }
        return BLTNItemManager(rootItem: item)
    }()

    func didtappedcontinued(){
        print("123")
        self.dismiss(animated: true, completion: nil)
        openCamera()
    //    self.performSegue(withIdentifier: "newdashboard_to_scanner", sender: nil)
    }
    func didnottapped(){
      //  self.performSegue(withIdentifier: "new_dashboard_to_enterupi", sender: self)
        print("Hello")
        self.dismiss(animated: true, completion: nil)
        self.performSegue(withIdentifier: "enter_upi", sender: nil)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
           return .lightContent
       }
    override func viewDidLoad() {
        super.viewDidLoad()
        due_views1.isHidden = true
        // Create a CLLocationManager and assign a delegate
        
      //  self.performSegue(withIdentifier: "student_dashboard_to_newdashboard", sender: nil)
        feedback_student.isHidden = true
        start_location_grasp()
        user_details()
        let alert_dismiss = UITapGestureRecognizer(target: self, action: #selector(pay_back_clicked(_:)))
        main_view.addGestureRecognizer(alert_dismiss)
        let info_due = UITapGestureRecognizer(target: self, action: #selector(info(_:)))
        info_only.addGestureRecognizer(info_due)
        let feed = UITapGestureRecognizer(target: self, action: #selector(feedback(_:)))
        feedback_student.addGestureRecognizer(feed)
     /*   let hide = UITapGestureRecognizer(target: self, action: #selector(hide_dismiss(_:)))
        dropdown.addGestureRecognizer(hide)*/
    /*    bottom_view.isHidden = true
      //  bottom_view.layer.cornerRadius = 20
        bottom_view.clipsToBounds = true
        bottom_view.clipsToBounds = true
        bottom_view.layer.cornerRadius = 25
        bottom_view.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        bottom_view.layer.backgroundColor = UIColor(red: 0.10, green: 0.10, blue: 0.10, alpha: 1.00).cgColor*/
      //  bottom_view.isHidden = true
     /* let bottomSheet = MyStackViewBottomSheetViewController()
               DispatchQueue.main.async {
                   self.present(bottomSheet, animated: true)
               }*/
       // self.bottom_view.layer.cornerRadius = 20
       // self.bottom_view.clipsToBounds = true
        crdit_student()
        due()
        counter_check()
        btn_stacks.isHidden = true
        due_layout.layer.cornerRadius = 20
        main_view.backgroundColor = UIColor.init(red: 0.07, green: 0.07, blue: 0.07, alpha: 1.00)
     //   layouts.backgroundColor = UIColor.init(red: 0.13, green: 0.09, blue: 0.75, alpha: 1.00)
            //  due_layout.backgroundColor = UIColor.init(red: 0.45, green: 0.44, blue: 0.68, alpha: 1.00)
        request_amount.applyGradient_dashboard(colors: [UIColor.magenta.cgColor, UIColor(red: 0.12, green: 0.48, blue: 0.40, alpha: 1.00).cgColor])
        let rectShape = CAShapeLayer()
        rectShape.bounds = self.request_amount.frame
        rectShape.position = self.request_amount.center
        rectShape.path = UIBezierPath(roundedRect: self.request_amount.bounds, byRoundingCorners: [.bottomLeft , .bottomRight ], cornerRadii:
                                        CGSize(width: 20, height: 20)).cgPath
       // .topLeft
        self.request_amount.layer.backgroundColor = UIColor.green.cgColor
        //Here I'm masking the textView's layer with rectShape layer
        self.request_amount.layer.mask = rectShape
      /*  let payment_back_var = UITapGestureRecognizer(target: self, action: #selector(pay_back_clicked(_:)))
        camera_access.addGestureRecognizer(payment_back_var)*/
     /*  let payment_back_var1 = UITapGestureRecognizer(target: self, action: #selector(logo_clicked(_:)))
       logo_check.addGestureRecognizer(payment_back_var1)*/
        // self.Paying.backgroundColor = .blue
       // self.Paying.setImage( "scan50", for: .normal)
      //  Paying.setImage(UIImage(named: "scan50"), for: .normal)
     //   Paying.imageEdgeInsets = UIEdgeInsets(top: 30, left: 30, bottom: 30, right: 30)
        /*    let payment_back_var1 = UITapGestureRecognizer(target: self, action: #selector(dismiss_bottom(_:)))
        viewer.addGestureRecognizer(payment_back_var1)    */
      /*  let scan_upi = UITapGestureRecognizer(target: self, action: #selector(scan_upi(_:)))
        scaned.addGestureRecognizer(scan_upi)*/
       /* let enter_upi = UITapGestureRecognizer(target: self, action: #selector(enter_upi(_:)))
        enterupis.addGestureRecognizer(enter_upi)*/
   //     self.tabBarController!.tabBar.isTranslucent = false
        let token =  UserDefaults.standard.string(forKey: "token")
        print("B1")
        print(token)
        print("B2")
        // Initialize gradient layer.
        let gradientLayer: CAGradientLayer = CAGradientLayer()
        // Set frame of gradient layer.
        gradientLayer.frame = layouts.bounds
        layouts.clipsToBounds = true
        let topColor: CGColor = UIColor(red: 0.14, green: 0.14, blue: 0.20, alpha: 1.00).cgColor
        let middleColor: CGColor = UIColor(red: 0.31, green: 0.31, blue: 0.36, alpha: 1.00).cgColor
        let bottomColor: CGColor = UIColor(red: 0.52, green: 0.52, blue: 0.52, alpha: 1.00).cgColor
        gradientLayer.colors = [topColor, middleColor, bottomColor]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        layouts.layer.cornerRadius = 25
        layouts.layer.insertSublayer(gradientLayer, at: 0)
        let gradientLayer1: CAGradientLayer = CAGradientLayer()
        gradientLayer1.frame = due_layout.bounds
        due_layout.clipsToBounds = true
        let topColor1: CGColor = UIColor(red: 0.14, green: 0.14, blue: 0.20, alpha: 1.00).cgColor
        let middleColor1: CGColor = UIColor(red: 0.31, green: 0.31, blue: 0.36, alpha: 1.00).cgColor
        let bottomColor1: CGColor = UIColor(red: 0.52, green: 0.52, blue: 0.52, alpha: 1.00).cgColor
        gradientLayer1.colors = [topColor1, middleColor1, bottomColor1]
        gradientLayer1.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer1.endPoint = CGPoint(x: 1.0, y: 0.5)
        due_layout.layer.cornerRadius = 25
        due_layout.layer.insertSublayer(gradientLayer1, at: 0)
        Paying.layer.cornerRadius = 25
        Paying.clipsToBounds = false
    }
    override func viewDidAppear(_ animated: Bool) {
      //   self.trailing.constant = self.view.frame.width
      //   self.bottom_view.isHidden = true
        start_location_grasp()
        }
    @objc func dismiss_bottom(_ sender: Any){
       //bottom_view.isHidden = true
    }
    @objc func scan_upi(_ sender: Any){
   //
    }
    @objc func enter_upi(_ sender: Any){
     //   bottom_view.isHidden = true
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
         if let location = locations.last {
            if location_count < 1{
                debugPrint("Lat : \(location.coordinate.latitude) \nLng : \(location.coordinate.longitude)")
                lat_long = String(location.coordinate.latitude)+","+String(location.coordinate.longitude)
              //  update_location_in_usertable()
                print("*******")
                print(lat_long)
                AppDelegate.Nexdha_student.location  = lat_long
                print("#####################")
                location_count = location_count+1
                user_details()
              
            }
        }
    }
    public func start_location_grasp(){
                  let locStatus = CLLocationManager.authorizationStatus()
                      switch locStatus {
                         case .notDetermined:
                            locationManager.requestWhenInUseAuthorization()
                         return
                         case .denied, .restricted:
                      /*     let alert = UIAlertController(title: "Location Services are disabled", message: "Please enable Location Services in your Settings", preferredStyle: .alert)
                           // let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                           // alert.addAction(okAction)
                            present(alert, animated: true, completion: nil)*/
                          //   self.handleDismiss()
                             let alertController = UIAlertController (title: "Permission denied", message: "Nexdha pay does not have permission to access you Location.please go to settings and enable it", preferredStyle: .alert)

                                let settingsAction = UIAlertAction(title: "Settings", style: .default) { (_) -> Void in

                                    guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
                                        return
                                    }
                                    if UIApplication.shared.canOpenURL(settingsUrl) {
                                        UIApplication.shared.open(settingsUrl, completionHandler: { (success) in
                                            print("Settings opened: \(success)") // Prints true
                                            if(success == true){
                                              //  self.performSegue(withIdentifier: "scans", sender: nil)
                                                self.start_location_grasp()
                                            }
                                            else{
                                                let alertController = UIAlertController (title: "Permission denied", message: "Nexdha pay does not have permission to access you Location.please go to settings and enable it", preferredStyle: .alert)
                                                   
                                                alertController.addAction(UIAlertAction(title: "ok", style: .default, handler: { action in

                                                   }))
                                                   
                                                   self.present(alertController, animated: true, completion: nil)
                                            }
                                        })
                                    }
                                }
                                alertController.addAction(settingsAction)
                                let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
                                alertController.addAction(cancelAction)
                                print(cancelAction)
                                self.present(alertController, animated: true, completion: nil)
        
                         return
                         case .authorizedAlways, .authorizedWhenInUse:
                           update_location()
                         break
                      }
              
                      //location end
    }
    public func update_location(){
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationManager.startUpdatingLocation()
    }
    @objc func logo_clicked(_ sender: Any){
        self.performSegue(withIdentifier: "dashboard_testui", sender: nil)
    }
  
    private var isBottomSheetShown = false
    @IBAction func payed(_ sender: Any) {
    //  boardManager.showBulletin(above: self)
        start_location_grasp()
        if let sheet = moodselectionVc.sheetPresentationController{
               sheet.detents = [.medium()]
            sheet.prefersScrollingExpandsWhenScrolledToEdge = false
            sheet.prefersGrabberVisible = true
         //   sheet.preferredCornerRadius = 20
          //  sheet.largestUndimmedDetentIdentifier = .medium
            main_view.layer.shadowColor = UIColor.darkGray.cgColor
        }
     //   moodselectionVc.isModalInPresentation = true
        self.present(moodselectionVc,animated: true, completion: nil)
   /*DispatchQueue.main.async {
           
                         let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
                         if let subview = alert.view.subviews.first, let actionSheet = subview.subviews.first {
                         for innerView in actionSheet.subviews {
                         innerView.backgroundColor = UIColor(red: 0.10, green: 0.10, blue: 0.10, alpha: 1.00)
                         innerView.layer.cornerRadius = 15.0
                         innerView.clipsToBounds = true
                         }
                         }
                         alert.addAction(UIAlertAction(title: "Scan & Pay", style: .default, handler: { (_) in
                             self.didtappedcontinued()
                             print("User click Approve button")
                           //  alert.dismiss(animated: true, completion: nil)
                         }))
                       //  alert.view.subviews.first?.subviews.first?.subviews.first?.backgroundColor = UIColor(red: 0.10, green: 0.10, blue: 0.10, alpha: 1.00)
                          alert.addAction(UIAlertAction(title: "Enter UPI id", style: .default, handler: { (_) in
                            self.didnottapped()
                            print("User click Edit button")
                          //  alert.dismiss(animated: true, completion: nil)
                         }))
                            alert.view.superview?.isUserInteractionEnabled = true
                            self.present(alert, animated: true, completion: {
                             print("completion block")
                         })
        /*    func alerts(_ sender: Any){
                alert.dismiss(animated: true, completion: nil)
            }*/
       
 
        }*/
        
        
        
     /* if(isBottomSheetShown){
            UIView.animate(withDuration: 0.3, animations:{
                self.height.constant = 0
                self.view.layoutIfNeeded()
            }){ (status) in
            self.isBottomSheetShown = false
            self.bottom_view.isHidden = false

            }
        }else{
            UIView.animate(withDuration: 0.3, animations: {
                self.height.constant = 200
                self.view.layoutIfNeeded()
            }){(status) in
             //   self.bottom_view.isHidden = true
                self.isBottomSheetShown = true
            }
        }*/
    }
    @objc func hide_dismiss(_ sender: Any){
      /*  if(isBottomSheetShown){
            UIView.animate(withDuration: 0.3, animations:{
                self.height.constant = 0
                self.view.layoutIfNeeded()
            }){ (status) in
            self.dropdown.isHidden = true
            self.isBottomSheetShown = false
            self.bottom_view.isHidden = false

            }
        }else{
            UIView.animate(withDuration: 0.3, animations: {
                self.height.constant = 200
                self.view.layoutIfNeeded()
            }){(status) in
             //   self.bottom_view.isHidden = true
                self.isBottomSheetShown = true
            }
        }*/
    }
    @objc func feedback(_ sender: Any){
        self.performSegue(withIdentifier: "dashboard_to_feedback", sender: nil)
    }
    
    @objc func info(_ sender: Any){
        let alert = UIAlertController(title:"Credits" , message: "Credits Will be Provided to you Once your KYC gets Verified By Our Team.You can Spend Your credits in Stores You Purchase items.The Bill for Your Spent Amount Will be Generated Twice Every Month. Your Bill date can be Seen in the Settings Page. The Credits will be Automatically Refilled Once the bill is Paid by Your Parent. The Bill will be Generated With 24 % Per annum. Excess of Generation + Two days - Total of Three Days Will Be Given as Due Date For Paying the Entire Bill. The Bill Amount has to be Paid in Full , Partial Payment are Not Allowed / Accepted. If the time Exceeds the Due Date late fee of 0.0027 % will be charged Per Day.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
    
    @objc func pay_back_clicked(_ sender: Any){
    //    self.dismiss(animated: false, completion: nil)

        moodselectionVc.dismiss(animated: false, completion: nil)
     //   moodselectionVc.isModalInPresentation = false
        /* if(isBottomSheetShown){
            UIView.animate(withDuration: 0.3, animations:{
                self.height.constant = 0
                self.view.layoutIfNeeded()
            }){ (status) in
            self.dropdown.isHidden = true
            self.isBottomSheetShown = false
            self.bottom_view.isHidden = false

            }
        }else{
            UIView.animate(withDuration: 0.3, animations: {
                self.height.constant = 200
                self.view.layoutIfNeeded()
            }){(status) in
             //   self.bottom_view.isHidden = true
                self.isBottomSheetShown = true
            }
        }*/
     //  boardManager.showBulletin(above: self)

      //  openCamera()
        

        
        
      // bottom_view.isHidden = false

    /*    self.leading.constant = 20
        self.trailing.constant = 20
        self.top.constant = 20
        self.bottom.constant = 50*/

     /*  if (isBottomSheetShown)
             /*  {
                   // hide the bottom sheet
                  UIView.animate(withDuration: 0.2, animations: {
                       
                       self.height.constant = 250
                       self.view.layoutIfNeeded()
                       print("A1")
                   }) { (status) in
                       self.isBottomSheetShown = false
                      UIView.animate(withDuration: 0.2, animations: {
                           self.height.constant = 0
                           self.leading.constant = 20
                           self.trailing.constant = self.view.frame.width
                           self.view.layoutIfNeeded()
                           print("A2")
                         /* self.isBottomSheetShown = true
                          UIView.animate(withDuration: 0.1, animations: {
                              self.height.constant = 250
                              self.view.layoutIfNeeded()
                              print("A5")*/
                       }) { (status) in
                           // not to be used
                           self.isBottomSheetShown = false

                           print("A3")

                       }
                       // completion code
                   }
               }*/
        {
                   // show the bottom sheet
                   UIView.animate(withDuration: 0.2, animations: {
                       self.height.constant = 250
                       self.trailing.constant = 20
                       self.view.layoutIfNeeded()
                       print("A4")
                   }) { (status) in
                       // completion code
                       self.isBottomSheetShown = true
                       UIView.animate(withDuration: 0.2, animations: {
                           self.height.constant = 250
                           self.view.layoutIfNeeded()
                           print("A5")
                       }) { (status) in
                           print("A6")
                           self.isBottomSheetShown = false


                       }
                   }
               }
        else {
                   // show the bottom sheet
                   UIView.animate(withDuration: 0.2, animations: {
                       self.height.constant = 250
                       self.trailing.constant = 20
                       self.view.layoutIfNeeded()
                       print("A4")
                   }) { (status) in
                       // completion code
                       self.isBottomSheetShown = true
                       UIView.animate(withDuration: 0.2, animations: {
                           self.height.constant = 250
                           self.view.layoutIfNeeded()
                           print("A5")
                       }) { (status) in
                           print("A6")
                           self.isBottomSheetShown = false


                       }
                   }
               }*/
        
        
        ////checking
      /*  if (isBottomSheetShown)
               {
                   // hide the bottom sheet
                   UIView.animate(withDuration: 0.3, animations: {
                       
                       self.height.constant = 0
                       self.view.layoutIfNeeded()
                       print("apple")
                   }) { (status) in
                       self.isBottomSheetShown = false
                       print("orange")

                      
                       // completion code
                   }
               }
               else{
                   // show the bottom sheet
                   
                   UIView.animate(withDuration: 0.3, animations: {
                       self.height.constant = 400
                     //  self.trailing.constant = 10
                       self.view.layoutIfNeeded()
                       print("fruit")

                   }) { (status) in
                       self.isBottomSheetShown = false


                       }
                   }*/
               }
               
        
        
        
               
    
  /*  @IBAction func history(_ sender: Any) {
    //self.performSegue(withIdentifier: "dash_transactionhistory", sender: nil)
    }*/
    private func user_details(){
        let headers: HTTPHeaders = [
            .authorization(UserDefaults.standard.object(forKey: "token") as! String)
        ]
        print("get user details")
        print(AppDelegate.Nexdha_student.location)
        print("get user12233323232")
        let parameters = ["location": AppDelegate.Nexdha_student.location]
               AF.request(AppDelegate.Nexdha_student.server+"/api/getuserdetails2", method: .post, parameters: parameters , headers: headers).responseJSON { response in
                           //debugPrint(response)
                switch response.result{
                case .success(let value):
                    let json = JSON(value)
                    print("a1")
                    print(json)
                    print("a23")
                    let status = json["name"].string
                    let kyc = json["kyc"].string
                    AppDelegate.Nexdha_student.kyc = kyc!
                  //  self.welcome_name.text = status!
                    self.name.text = status!
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
            self.performSegue(withIdentifier: "dash_code_home", sender: nil)
        })
    }
    override func viewWillAppear(_ animated: Bool) {
      counter_check()
      start_location_grasp()
      moodselectionVc.dismiss(animated: false, completion: nil)
      super.viewWillAppear(animated)
    }
    private func due(){
        let headers: HTTPHeaders = [
            .authorization(UserDefaults.standard.object(forKey: "token") as! String)
        ]
   
                
               AF.request(AppDelegate.Nexdha_student.server+"/api/due", method: .post,headers: headers ).responseJSON { response in
                           //debugPrint(response)
                switch response.result{
                case .success(let value):
                    let json = JSON(value)
                    print("a1")
                    print(json)
                    print("a23")
                    let status = json["amount"].string
                    let status1 = json["date"].string
                    self.date.text = status1!
                    self.amont_due.text = "₹" + " " + status!

                case.failure(let error):
                    print(error)
                }
                       }
    }
    public func activity_log(){
        let headers: HTTPHeaders = [
            .authorization(UserDefaults.standard.string(forKey: "token") as! String)
        ]
        
        let parameters = ["activity_id": "100" ,"os": "iOS"]

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
    public func crdit_student(){
        let headers: HTTPHeaders = [
            .authorization(UserDefaults.standard.object(forKey: "token") as! String)
        ]
             AF.request(AppDelegate.Nexdha_student.server+"/api/credit_details", method: .post, headers: headers).responseJSON { response in
                // debugPrint(response)
                 switch response.result{
                               case .success(let value):
                                   let json = JSON(value).arrayValue
                                    print("12314546545")
                                    print(json)
                                    print("==============")

                                for name in json {
                                    //print("Hello, \(name)!")
                                    //print("\(name["purpose"])")
                                    self.credits.append("\(name["total_credits"])")
                                    print(self.credits)
                                    let joinedArray = self.credits.joined(separator: "")
                                    print(joinedArray)
                                    self.cred.text =  "₹" + " " + joinedArray

                                  //  cred.text = self.credits

                                }
                    
                               case.failure(let error):
                                   print(error)
                               }
           
                    }
         }
    

    
    private func openCamera() {
          switch AVCaptureDevice.authorizationStatus(for: .video) {
          case .authorized:  // the user has already authorized to access the camera.
         //     self.setupCaptureSession()
              print("Redirecting to scanner")
              self.performSegue(withIdentifier: "scans", sender: nil)
          case .notDetermined: // the user has not yet asked for camera access.
              AVCaptureDevice.requestAccess(for: .video) { (granted) in
                  DispatchQueue.main.async {

                  if granted { // if user has granted to access the camera.
                      print("the user has granted to access the camera")

                      DispatchQueue.main.async {
                    //      self.setupCaptureSession()
                       //   self.performSegue(withIdentifier: "to_scan", sender: self)
                        //  self.bottom_view.isHidden = true
                          self.performSegue(withIdentifier: "scans", sender: nil)
                      }
                  } else {
                      print("the user has not granted to access the camera")
                   //   self.handleDismiss()
                      let alertController = UIAlertController (title: "Permission denied", message: "Nexdha pay does not have permission to access you camera.please go to settings and enable it", preferredStyle: .alert)

                         let settingsAction = UIAlertAction(title: "Settings", style: .default) { (_) -> Void in

                             guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
                                 return
                             }

                             if UIApplication.shared.canOpenURL(settingsUrl) {
                                 UIApplication.shared.open(settingsUrl, completionHandler: { (success) in
                                     print("Settings opened: \(success)") // Prints true
                                     if(success == true){
                                         self.performSegue(withIdentifier: "scans", sender: nil)
                                     }
                                     else{
                                         let alertController = UIAlertController (title: "Permission denied", message: "Nexdha pay does not have permission to access you camera.please go to settings and enable it", preferredStyle: .alert)
                                            
                                         alertController.addAction(UIAlertAction(title: "ok", style: .default, handler: { action in

                                            }))
                                            
                                            self.present(alertController, animated: true, completion: nil)
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
              
              let alertController = UIAlertController (title: "Permission denied", message: "Nexdha pay does not have permission to access you camera.please go to settings and enable it", preferredStyle: .alert)
              let settingsAction = UIAlertAction(title: "Settings", style: .default) { (_) -> Void in

                  guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
                      return
                  }

                  if UIApplication.shared.canOpenURL(settingsUrl) {
                      UIApplication.shared.open(settingsUrl, completionHandler: { (success) in
                          print("Settings opened: \(success)") // Prints true
                          if(success == true){
                              self.performSegue(withIdentifier: "scans", sender: nil)
                          }
                          else{
                              let alert =  UIAlertController (title: "Permission denied", message: "Nexdha pay does not have permission to access you camera.please go to settings and enable it", preferredStyle: .alert)
                                 
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
              
              
              let alertController = UIAlertController (title: "Permission denied", message: "Nexdha pay does not have permission to access you camera.please go to settings and enable it", preferredStyle: .alert)
                 let settingsAction = UIAlertAction(title: "Settings", style: .default) { (_) -> Void in

                     guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
                         return
                     }

                     if UIApplication.shared.canOpenURL(settingsUrl) {
                         UIApplication.shared.open(settingsUrl, completionHandler: { (success) in
                             print("Settings opened: \(success)") // Prints true
                             if(success == true){
                                 self.performSegue(withIdentifier: "scans", sender: nil)
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
