//
//  parent_dashboard.swift
//  nbpl
//
//  Created by Nexdha on 17/06/22.
//

import Foundation
import UIKit
import CryptoKit
import DTGradientButton
import Alamofire
import SwiftyJSON
import Lottie
import CoreLocation
class parent_dashboard: UIViewController, UITextFieldDelegate, UIGestureRecognizerDelegate, CLLocationManagerDelegate{
  
    var count = 0
    var location_count = Int(0)
    var lat_long = ""
    let locationManager = CLLocationManager()
    @IBOutlet weak var juni_btn: UIButton!
    @IBOutlet weak var animes: AnimationView!
    struct junior_parent {
        var Name: String
        var amt: String
        var late_fee: String
        var bill_value:String
        var bill_number:String
        var due_date:String
     }
    struct junior_student {
        var name_stud: String
        var balance_amt: String
        var spented_amt: String
        var due_dated:String
        var kyc_status:String
     }
   struct get_rules_api {
        var id: String
        var name: String
        var value: String
        var notes: String
    }
    var get_rules1: [String] = [String]()

    var get_rules_test_api = [
        get_rules_api(id: "", name: "", value: "", notes: "")
    ]
    var Juniorlist_from_pdashboard = [
        junior_parent(Name: "", amt: "", late_fee: "" ,bill_value:"",bill_number: "",due_date: "")
    ]
    @IBOutlet weak var paying: UIButton!
    
    var junior_stud = [
        junior_student(name_stud: "", balance_amt: "", spented_amt: "" ,due_dated:"",kyc_status: "")
    ]   //// junir_named
    
    var percentage_frompicker : Double = 0
    var Beneficiaries_from_api_name = [""]
    var Beneficiaries_from_api_amt = [""]
    var Beneficiaries_from_api_latefee = [""]
    var Beneficiaries_from_api_bill_value = [""]
    var Beneficiaries_from_api_bill_number = [""]
    var Beneficiaries_from_api_due_date1 = [""]
    @IBOutlet weak var ab_stack: UIStackView!
    @IBOutlet weak var table1: UITableView!
    @IBOutlet weak var due_amt_only: UILabel!
    @IBOutlet weak var above_table_stack: UIStackView!
    @IBOutlet weak var table: UITableView!
    @IBOutlet weak var due_layout: UIStackView!
    override var preferredStatusBarStyle: UIStatusBarStyle {
           return .lightContent
       }
    override func viewDidLoad() {
        super.viewDidLoad()
        start_location_grasp()
        self.animes.isHidden = true
        juni_btn.isHidden = true
        user_details()
   
        AppDelegate.Nexdha_student.final_pay_GW = ""
        AppDelegate.Nexdha_student.total_amt = ""
        AppDelegate.Nexdha_student.name_bill_pay_parentdashboard = ""
        AppDelegate.Nexdha_student.late_fee = ""
        AppDelegate.Nexdha_student.bill_value = ""
        AppDelegate.Nexdha_student.percentage_bill_parent_to_student = ""
        counter_check()
    ///    due()
        transaction_parent()
        get_rules()
        juniors()
        table.delegate = self
        table.dataSource = self
        table1.dataSource = self
        table1.delegate = self
       // table.layer.cornerRadius = 30
        above_table_stack.clipsToBounds = true
        above_table_stack.layer.cornerRadius = 10
        above_table_stack.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner] // Top right corner, Top left corner respectively

        
        
        ab_stack.clipsToBounds = true
        ab_stack.layer.cornerRadius = 10
        ab_stack.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        
        let token =  UserDefaults.standard.string(forKey: "token_counter_check")
        print("a586")
        print(token)
        print("varun")
        
        
       
        // Initialize gradient layer.
      /*  let gradientLayer1: CAGradientLayer = CAGradientLayer()

        // Set frame of gradient layer.
        gradientLayer1.frame = due_layout.bounds
        due_layout.clipsToBounds = true
        // Color at the top of the gradient.
        let topColor1: CGColor = UIColor(red: 0.14, green: 0.14, blue: 0.20, alpha: 1.00).cgColor
        // Color at the middle of the gradient.
        let middleColor1: CGColor = UIColor(red: 0.31, green: 0.31, blue: 0.36, alpha: 1.00).cgColor

        // Color at the bottom of the gradient.
        let bottomColor1: CGColor = UIColor(red: 0.52, green: 0.52, blue: 0.52, alpha: 1.00).cgColor
        // Set colors.
        gradientLayer1.colors = [topColor1, middleColor1, bottomColor1]

        // Set start point.
        gradientLayer1.startPoint = CGPoint(x: 0.0, y: 0.5)

        // Set end point.
        gradientLayer1.endPoint = CGPoint(x: 1.0, y: 0.5)
        due_layout.layer.cornerRadius = 25
      //  layouts.translatesAutoresizingMaskIntoConstraints = false
        // Insert gradient layer into view's layer heirarchy.
        due_layout.layer.insertSublayer(gradientLayer1, at: 0)*/
        
    }
    override func viewWillAppear(_ animated: Bool) {
      start_location_grasp()
      counter_check()
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
                print(AppDelegate.Nexdha_student.location)
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
    private func user_details(){
        let headers: HTTPHeaders = [
            .authorization(UserDefaults.standard.object(forKey: "token") as! String)
        ]
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
                  //  self.welcome_name.text = status!
                  //  self.name.text = status!
                case.failure(let error):
                    print(error)
                }
                       }
    }
    public func get_rules(){
        let headers: HTTPHeaders = [
            .authorization(UserDefaults.standard.object(forKey: "token") as! String)
        ]
        AF.request(AppDelegate.Nexdha_student.server+"/api/get_rules", method: .post, headers: headers).responseJSON { [self] response in
                // debugPrint(response)
                 switch response.result{
                               case .success(let value):
                                   let json = JSON(value).arrayValue
                                   debugPrint(json)
                                   if json == []{
                                 //   debugPrint("Nothing")
                                      // self.purposearray.append("\(name["purpose"])")

                                     //  self.get_rules.append("\(name[""])")
                                       print("no value")
                                   }else {
                                    for name in json{
                                    //   self.get_rules1.append("\(name["value"])")
                                    
                                        print("********************************************************")
                                    //    print(self.get_rules1)
                                        print("========================================================")
                                        //print(get_rules1.name[0])
                                     //   self.get_rules_test_api.append(get_rules_api(id: "\(name["id"])",name: "\(name["name"])",value: "\(name["value"])",notes: "\(name["notes"])"))
                                        self.get_rules1.append("\(name["id"])")
                                        print(json[10])
                                        let add_status1 = json[10]
                                        let status = add_status1["value"].string
                                        print("A1")
                                        print(status)
                                        AppDelegate.Nexdha_student.percentage_bill_parent_to_student = status!
                                        print("A222")
                                        print(AppDelegate.Nexdha_student.percentage_bill_parent_to_student)
                                        //let john
                                       /* if(("\(name["id"])") == "11"){
                                            print("***************************************************")
                                            print(("\(name["value"])"))
                                            print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!")

                                        }*/
                                   //   self.get_rules1.append
                                    //    self.get_rules1.append("\(name["name"])");                            self.get_rules1.append("\(name["value"])")

                                                      // self.tableView.reloadData()
                                    }
                                       self.get_rules_test_api.remove(at: 0)

                                        
                                       // let employeeName = json[name.rawValue as! Int]["name"].string ?? "N/A"
                                      //  print("encode")
                                    //    print(employeeName)
                                    //    print("decode")
                                     //   let id = json[name.rawValue as! Int]["id"].string ?? "N/A"
                                        //   print("ID: \(id)")
                                  //  }
                                   }
                                 //  self.get_rules_test_api.remove(at: 0)
                                /*   for name in json{
                                       self.transactionlist_from_api.append(tran_list(id: "\(name["transaction_id"])", type: "\(name["state"])", date: "\(name["udf5"])", name: "\(name["udf3"])", amount: "\(name["amount"])", status: "\(name["response_message"])", eta: "\(name["address_line_1"])"))
                                      
                                   }
                                   self.transactionlist_from_api.remove(at: 0) */
                                  // self.table.reloadData()
                                     //  let json = JSON(value).arrayValue
                                      // debugPrint(username)
                               case.failure(let error):
                                   print(error)
                               }
           
                    }
         }
    
    
    public func juniors(){
        print("scrolllll")
        let headers: HTTPHeaders = [
            .authorization(UserDefaults.standard.object(forKey: "token") as! String)
        ]
             AF.request(AppDelegate.Nexdha_student.server+"/api/children", method: .post, headers: headers).responseJSON { response in
                // debugPrint(response)
                 switch response.result{
                               case .success(let value):
                                   let json = JSON(value).arrayValue
                                   debugPrint(json)
                                   if json == []{
                                 //   debugPrint("Nothing")
                                       self.junior_stud.append(junior_student(name_stud: "", balance_amt: "", spented_amt: "",due_dated: "",kyc_status: ""))
                                       self.juni_btn.isHidden = false

                                   }else {
                                    for name in json{
                                        self.junior_stud.append(junior_student(name_stud:"\(name["name"])", balance_amt:"\(name["avl_credits"])", spented_amt: "\(name["spent"])",due_dated:"\(name["dueDate"])",kyc_status: "\(name["kyc"])"))
                                      //  self.Beneficiaries_from_api_name.append("\(name["name"])")
                                     //   self.Beneficiaries_from_api_amt.append("\(name["total_bill_value"])")
                                   //     self.Beneficiaries_from_api_latefee.append("\(name["late_fee"])")
                                  //      self.Beneficiaries_from_api_bill_value.append("\(name["bill_value"])")
                                 //       self.Beneficiaries_from_api_bill_number.append("\(name["bill_number"])")
                                    }
                                   }
                                   self.junior_stud.remove(at: 0)
                                   self.table1?.reloadData()   // ...and it is also visible here.
                                /*   for name in json{
                                       self.transactionlist_from_api.append(tran_list(id: "\(name["transaction_id"])", type: "\(name["state"])", date: "\(name["udf5"])", name: "\(name["udf3"])", amount: "\(name["amount"])", status: "\(name["response_message"])", eta: "\(name["address_line_1"])"))
                                   }
                                   self.transactionlist_from_api.remove(at: 0) */
                                   self.table1.reloadData()
                                     //  let json = JSON(value).arrayValue
                                      // debugPrint(username)
                               case.failure(let error):
                                   print(error)
                               }
           
                    }
         }
    public func transaction_parent(){
        let headers: HTTPHeaders = [
            .authorization(UserDefaults.standard.object(forKey: "token") as! String)
        ]
             AF.request(AppDelegate.Nexdha_student.server+"/api/view_bills", method: .post, headers: headers).responseJSON { response in
                // debugPrint(response)
                 switch response.result{
                               case .success(let value):
                                   let json = JSON(value).arrayValue
                                   debugPrint(json)
                                   if json == []{
                                   debugPrint("54+54")
                                       self.animes.isHidden = false
                                       self.animes?.contentMode = .scaleAspectFit
                                       self.animes?.loopMode =  .loop
                                       self.animes?.animationSpeed = 0.85
                                       self.animes?.play()
                                   }else {
                                    self.animes.isHidden = true
                                    for name in json{
                                        self.Juniorlist_from_pdashboard.append(junior_parent(Name:"\(name["name"])", amt:"\(name["total_bill_value"])", late_fee: "\(name["late_fee"])",bill_value:"\(name["bill_value"])",bill_number: "\(name["bill_number"])", due_date: "\(name["due_date"])"))
                                        self.Beneficiaries_from_api_name.append("\(name["name"])")
                                        self.Beneficiaries_from_api_amt.append("\(name["total_bill_value"])")
                                        self.Beneficiaries_from_api_latefee.append("\(name["late_fee"])")
                                        self.Beneficiaries_from_api_bill_value.append("\(name["bill_value"])")
                                        self.Beneficiaries_from_api_bill_number.append("\(name["bill_number"])")
                                        self.Beneficiaries_from_api_due_date1.append("\(name["due_date"])")
                                    }
                                   }
                                   self.Juniorlist_from_pdashboard.remove(at: 0)
                                   self.Beneficiaries_from_api_name.remove(at: 0)
                                   self.Beneficiaries_from_api_amt.remove(at: 0)
                                   self.Beneficiaries_from_api_latefee.remove(at: 0)
                                   self.Beneficiaries_from_api_bill_value.remove(at: 0)
                                   self.Beneficiaries_from_api_bill_number.remove(at: 0)
                                    self.Beneficiaries_from_api_due_date1.remove(at: 0)
                                   self.table?.reloadData()   // ...and it is also visible here.
                                   self.table.reloadData()
                               case.failure(let error):
                                   print(error)
                               }
           
                    }
         }


    public func activity_log(){
        let headers: HTTPHeaders = [
            .authorization(UserDefaults.standard.string(forKey: "token") as! String)
        ] 
        
        let parameters = ["activity_id": "200" ,"os": "iOS"]

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
        print("ak")
        print(UserDefaults.standard.string(forKey: "token"))
        print("ak1")
        let tokenData =  UserDefaults.standard.string(forKey: "token")
        print(tokenData)
         let newString = tokenData!.replacingOccurrences(of: "token", with: "", options: .literal, range: nil)
         print(newString)
        let headers : HTTPHeaders = [
         "Auth": newString,
        ]
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
            self.performSegue(withIdentifier: "dash_counter_viewcontroller", sender: nil)
        })
    }
    @IBAction func add_juni(_ sender: Any) {
        self.performSegue(withIdentifier: "dashboard_to_addjunior", sender: nil)
    }
}
extension parent_dashboard: UITableViewDelegate,UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            if tableView == table {
                let cell = tableView.dequeueReusableCell(withIdentifier: "new_table", for: indexPath)as! new_table
                cell.s_viewed?.layer.cornerRadius = 20
                cell.paying?.new_grad(colors: [UIColor(red: 0.24, green: 0.08, blue: 0.58, alpha: 1.00).cgColor, UIColor.magenta.cgColor])
                cell.paying.clipsToBounds = true
                cell.paying.layer.cornerRadius = 25
                print("********")
                print(cell)
                let assignText = Juniorlist_from_pdashboard[indexPath.row]
                cell.amt?.text = assignText.amt
                cell.name?.text = assignText.Name
                cell.payeds?.tag = indexPath.row
                cell.date_of_bill?.text = "Due on" + " " + assignText.due_date

                print("RSR")
                print(cell.payeds?.tag)
                cell.payeds.addTarget(self, action: #selector(connected(sender:)), for: .touchUpInside)
                
               // let info_jun = UITapGestureRecognizer(target: self, action: #selector(info_jun(_:)))
              //  junior_info.addGestureRecognizer(info_jun)
                
                let due_info1 = UITapGestureRecognizer(target: self, action: #selector(due_info(_:)))
                cell.due_info.addGestureRecognizer(due_info1)
                if Double(assignText.amt) != nil {
                debugPrint(assignText.amt)
                    let amount_convertion = String(format: "%.2f", Double(assignText.amt)!)
                    cell.amt?.text = "₹" + " " + amount_convertion
               }
                print(assignText)
                print("XRP")
                return cell
              }
            else {
                print("aakash11")
                  let cell = tableView.dequeueReusableCell(withIdentifier: "hello_junior", for: indexPath)as! junior_table
                  cell.views?.layer.cornerRadius = 20
                  print("==========")
                  print(cell)
                  let assignText1 = junior_stud[indexPath.row]
                cell.name_of_juniors?.text = assignText1.name_stud
                //  cell.spented_amount?.text = assignText1.balance_amt
                //  cell.Balance_amt?.text = assignText1.spented_amt
              //  if Double(assignText1.balance_amt) != nil {
               // debugPrint(assignText1.balance_amt)
                //    let amount_convertion = String(format: "%.2f", Double(assignText1.balance_amt)!)
                cell.spented_amount?.text = "₹" + " " + assignText1.spented_amt
               // }
              //  if Double(assignText1.spented_amt) != nil {
              //  debugPrint(assignText1.spented_amt)
              //      let amount_convertion = String(format: "%.2f", Double(assignText1.spented_amt)!)
                cell.Balance_amt?.text = "₹" + " " + assignText1.balance_amt
                cell.due_date?.text = "Next Bill Date" + " " + assignText1.due_dated
                
                let info_jun = UITapGestureRecognizer(target: self, action: #selector(info_jun(_:)))
                cell.junior_info.addGestureRecognizer(info_jun)
                if (assignText1.kyc_status) == "V" {
                    cell.kyc_status?.textColor =  UIColor(red: 0.00, green: 1.00, blue: 0.20, alpha: 1.00)
                   // cell.kyc_status?.text = assignText1.kyc_status
                    cell.kyc_status?.text = "KYC Verified"

                 /*   if Double(assignText.amount) != nil {
                    debugPrint(assignText.amount)
                        let amount_convertion = String(format: "%.2f", Double(assignText.amount)!)
                        cell.amount?.text = "-" + "₹" + " " + amount_convertion
                   }*/

                }else if (assignText1.kyc_status) == "N.V"{
                    cell.kyc_status?.textColor = UIColor(red: 0.00, green: 0.67, blue: 1.00, alpha: 1.00)
                    cell.kyc_status?.text = "KYC Not Verified"
                   /* if Double(assignText.amount) != nil {
                    debugPrint(assignText.amount)
                        let amount_convertion = String(format: "%.2f", Double(assignText.amount)!)
                        cell.amount?.text = "-" + "₹" + " " + amount_convertion
                   }*/
                }
                  return cell
              }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == table {
            return Juniorlist_from_pdashboard.count
        }else{
            return junior_stud.count
        }
    }
   
    @objc func info_jun(_ sender: Any){
        let alert = UIAlertController(title:"Junior Credits" , message: "Spent and Balance Amount of Junior is Shown Here. Bill Amount Will be Generated Twice Every Month. The Bill Generation Date is Shown in your Junior's and your Settings Page. The next bill generation date is Shown here. The Credits Will be refilled Once you Pay your Junior's bills. The Credit Amount will be allotted to your junior only after verifying their KYC.  ", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
    @objc func due_info(_ sender: Any){
        let alert = UIAlertController(title:"Due Date" , message: "Your Junior/Junior's Bill Will be Generated on the allotted bill Generation Date (Twice Every Month). The Bill will be Generated With 24 % Per annum. Excess of Generation + Two days - Total of Three Days Will Be Given as Due Date For Paying the Entire Bill. The Bill Amount has to be Paid in Full , Partial Payment are Not Allowed / Accepted. If the time Exceeds the Due Date late fee of 0.0027 % will be charged Per Day. The Credits Will be refilled Once you Pay your Junior's bills.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
    @objc func connected(sender: UIButton){
        let buttonTag = sender.tag
        print("Ajeesh")
        print(buttonTag)
        print("B")
        print(Juniorlist_from_pdashboard[sender.tag])
        print("C")
        print(Beneficiaries_from_api_name[sender.tag])
        print(Beneficiaries_from_api_amt[sender.tag])
        print(Beneficiaries_from_api_latefee[sender.tag])
        print(Beneficiaries_from_api_bill_value[sender.tag])
        print(Beneficiaries_from_api_bill_number[sender.tag])
        print(Beneficiaries_from_api_due_date1[sender.tag])
        AppDelegate.Nexdha_student.bill_number = Beneficiaries_from_api_bill_number[sender.tag]
        AppDelegate.Nexdha_student.bill_value = Beneficiaries_from_api_bill_value[sender.tag]
        AppDelegate.Nexdha_student.name_bill_pay_parentdashboard  = Beneficiaries_from_api_name[sender.tag]
        AppDelegate.Nexdha_student.final_pay_GW = Beneficiaries_from_api_amt[sender.tag]
        AppDelegate.Nexdha_student.late_fee = Beneficiaries_from_api_latefee[sender.tag]
        AppDelegate.Nexdha_student.due_date_only = Beneficiaries_from_api_due_date1[sender.tag]
        print(AppDelegate.Nexdha_student.percentage_bill_parent_to_student)
        percentage_frompicker = ( 1 + (((AppDelegate.Nexdha_student.percentage_bill_parent_to_student as! NSString).doubleValue/100)))
        print(percentage_frompicker)
        let myFloat = ((AppDelegate.Nexdha_student.bill_value as NSString).doubleValue/percentage_frompicker)
        print(myFloat)
        var formatter = NumberFormatter()
        let formattedString = formatter.string(for: myFloat)
        print(formattedString)
       // let formatted = String(format: "Angle: %.2f", formattedString!)
        AppDelegate.Nexdha_student.total_amt = formattedString!
        print(AppDelegate.Nexdha_student.final_pay_GW)
        print(AppDelegate.Nexdha_student.total_amt)
        print(AppDelegate.Nexdha_student.name_bill_pay_parentdashboard)
        print(AppDelegate.Nexdha_student.late_fee)
        print(AppDelegate.Nexdha_student.bill_value)
        print(AppDelegate.Nexdha_student.percentage_bill_parent_to_student)
        self.performSegue(withIdentifier: "parentdashboard_splitup", sender: self)
    }
}

class new_table : UITableViewCell {
    @IBOutlet weak var date_of_bill: UILabel!
    @IBOutlet weak var payeds: UIButton!
    @IBOutlet weak var amt: UILabel!
    @IBOutlet weak var paying: UIButton!
    @IBOutlet weak var due_info: UIImageView!
    @IBOutlet weak var s_viewed: UIStackView!
    @IBOutlet weak var name: UILabel!
}
class junior_table : UITableViewCell{
    @IBOutlet weak var junior_info: UIImageView!
    @IBOutlet weak var views: UIView!
    @IBOutlet weak var viewer: UIStackView!
    @IBOutlet weak var kyc_status: UILabel!
    @IBOutlet weak var due_date: UILabel!
    @IBOutlet weak var name_of_juniors: UILabel!
    @IBOutlet weak var Balance_amt: UILabel!
    @IBOutlet weak var spented_amount: UILabel!
   
}


