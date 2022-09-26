//
//  parent_history.swift
//  nbpl
//
//  Created by Nexdha on 14/07/22.
//

import Foundation
import UIKit
import Alamofire
import SwiftyJSON
@available(iOS 13.0, *)
class parent_history: UIViewController, UITextFieldDelegate, UIGestureRecognizerDelegate {
    @IBOutlet weak var table2: UITableView!
    @IBOutlet weak var p2: UIStackView!
    @IBOutlet weak var main_vertical: UIStackView!
    @IBOutlet weak var table1: UITableView!
    @IBOutlet weak var repayment_history: UIButton!
    @IBOutlet weak var bill_history: UIButton!
    @IBOutlet weak var i2: UIStackView!
    @IBOutlet weak var i1: UIStackView!
    @IBOutlet weak var v1: UIView!
    @IBOutlet weak var v2: UIView!
    var count = 0
    struct billhistory {
         var amt: String
         var status: String
         var bill_Number: String
         var bill_generation_date:String
         var bll_due_date:String
     }
    struct repayments_history {
         var card_number: String
         var amount: String
         var date: String
         var status:String
     }
    var billhistory_api = [
        billhistory(amt: "", status: "", bill_Number: "" ,bill_generation_date:"",bll_due_date: "")
    ]
    var repay_history = [
        repayments_history(card_number: "", amount: "", date: "" ,status:"")
    ]
    override func viewDidLoad() {
        super.viewDidLoad()
       // p2.isHidden = true
        counter_check()
        juniors()
        juniors1()
      //main_vertical.isHidden = true
        self.table1.delegate = self
        self.table1.dataSource = self
        self.table2.delegate = self
        self.table2.dataSource = self
  
        bill_history.isUserInteractionEnabled = false
        i1.transform = CGAffineTransform.init(translationX: 0, y: 0)
        v1.isHidden = false
        v2.isHidden = true      ///// use
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
           return .lightContent
    }
    override func viewWillAppear(_ animated: Bool) {
      counter_check()
   //   bill_history.isUserInteractionEnabled = false
      v1.isHidden = false      /////////////usage
      v2.isHidden = true           ///// use///// use
      super.viewWillAppear(animated)
         if i1.isHidden == false{      //// use
      v1.isHidden = false
       v2.isHidden = true   ///// use
      bill_history.isUserInteractionEnabled = true
      }
      else if i2.isHidden == false {
            v2.isHidden = false ///// use
            v1.isHidden = true
            repayment_history.isUserInteractionEnabled = true
      }
     //   i2.transform = CGAffineTransform.init(translationX: -500, y: 0)
    }
    @IBAction func b1(_ sender: Any) {
        print("*********************")
     // i1.transform = i1.transform.translatedBy(x: 0, y: 0)  ///// using
      //i2.transform = i2.transform.translatedBy(x: 0, y: 0)
    //   i1.transform = CGAffineTransform(translationX: 3000, y: 3000)   ///// using
      // i1.transform.d
      v2.isHidden = true ///// use
      v1.isHidden = false
      repayment_history.isUserInteractionEnabled = true
        repayment_history.titleLabel!.textColor = UIColor.gray

        UIView.animate(withDuration: 0.5) { [self] in
            i1.transform = i1.transform.translatedBy(x: 0, y: 0)
            i1.transform = CGAffineTransform.init(translationX: 0, y: 0)
          //  i2.transform = i2.transform.translatedBy(x: 0, y: 0)
            i2.transform = CGAffineTransform.init(translationX: 500, y: 0)//////// use
            i2.isHidden = true ///// use
            i1.isHidden = false
        }
    }
    @IBAction func b2(_ sender: Any) {
        print("#####################")
        //i1.transform = i1.transform.translatedBy(x: 0, y: 0)
        //i2.transform = i2.transform.translatedBy(x: 3000, y: 3000)
        //i2.transform = i2.transform.translatedBy(x: 0, y: 0)
        //i1.transform = view.transform.scaledBy(x: 2, y: 2)
        //i1.transform = CGAffineTransform(scaleX: 2.0, y: 2.0)
        //i1.transform = i1.transform.translatedBy(x: 0, y: 0)///// using
        //i2.transform = i2.transform.translatedBy(x: 0, y: 0)
        // i1.transform = CGAffineTransform(translationX: -3000, y: 0)///// using
        bill_history.isUserInteractionEnabled = true
        bill_history.titleLabel!.textColor = UIColor.gray


        v1.isHidden = true
        v2.isHidden = false  ///// use
        UIView.animate(withDuration: 0.5) { [self] in
          //  i1.transform = i1.transform.translatedBy(x: 0, y: 0)
          //  i1.transform = CGAffineTransform(translationX: 0, y: 0)
            i2.transform = CGAffineTransform(translationX: 0, y: 0)  ///// use
           // i1.transform = CGAffineTransform(translationX: 500, y: 0)
            i1.transform = CGAffineTransform.init(translationX: -500, y: 0)
            i1.isHidden = true
            i2.isHidden = false  ///// use
        }
    }
    public func activity_log(){
        let headers: HTTPHeaders = [
            .authorization(UserDefaults.standard.string(forKey: "token") as! String)
        ]
        let parameters = ["activity_id": "201" ,"os": "iOS"]
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
    
    public func juniors1(){
        let headers: HTTPHeaders = [
            .authorization(UserDefaults.standard.object(forKey: "token") as! String)
        ]
        let parameters = ["d1": "paymentHistory"]
        AF.request(AppDelegate.Nexdha_student.server+"/api/juniorBills", method: .post, parameters:parameters, headers: headers).responseJSON { response in
                // debugPrint(response)
                 switch response.result{
                               case .success(let value):
                                   let json = JSON(value).arrayValue
                                   debugPrint(json)
                                   if json == []{
                                 //   debugPrint("Nothing")
                                       self.repay_history.append(repayments_history(card_number: "No Data", amount: "No Data", date: "No Data" ,status:"No Data"))
                                   }else {
                                    for name in json{
                                        self.repay_history.append(repayments_history(card_number:"\(name["card_masked"])", amount:"\(name["bill_value"])", date: "\(name["payment_date"])",status:"\(name["payment_status"])"))
                                      //  self.Beneficiaries_from_api_name.append("\(name["name"])")
                                     //   self.Beneficiaries_from_api_amt.append("\(name["total_bill_value"])")
                                   //     self.Beneficiaries_from_api_latefee.append("\(name["late_fee"])")
                                  //      self.Beneficiaries_from_api_bill_value.append("\(name["bill_value"])")
                                 //       self.Beneficiaries_from_api_bill_number.append("\(name["bill_number"])")
                                        print("Work here repay")
                                        print(self.repay_history)
                                        print("Work here1")
                                    }
                                   }
                                   self.repay_history.remove(at: 0)
                                   self.table2?.reloadData()   // ...and it is also visible here.
                                /*   for name in json{
                                       self.transactionlist_from_api.append(tran_list(id: "\(name["transaction_id"])", type: "\(name["state"])", date: "\(name["udf5"])", name: "\(name["udf3"])", amount: "\(name["amount"])", status: "\(name["response_message"])", eta: "\(name["address_line_1"])"))
                                      
                                   }
                                   self.transactionlist_from_api.remove(at: 0) */
                                   self.table2.reloadData()
                                     //  let json = JSON(value).arrayValue
                                      // debugPrint(username)
                               case.failure(let error):
                                   print(error)
                               }
           
                    }
         }
    public func juniors(){
        let headers: HTTPHeaders = [
            .authorization(UserDefaults.standard.object(forKey: "token") as! String)
        ]
        let parameters = ["d1": "bill"]
        AF.request(AppDelegate.Nexdha_student.server+"/api/juniorBills", method: .post, parameters:parameters, headers: headers).responseJSON { response in
                // debugPrint(response)
                 switch response.result{
                               case .success(let value):
                                   let json = JSON(value).arrayValue
                                   debugPrint(json)
                                   if json == []{
                                 //   debugPrint("Nothing")
                                       
                                       self.billhistory_api.append(billhistory(amt:"No Data", status: "No Data", bill_Number: "No Data" ,bill_generation_date:"No Data",bll_due_date: "No Data"))
                                   }else {
                                    for name in json{
                                        self.billhistory_api.append(billhistory(amt:"\(name["bill_value"])", status:"\(name["bill_status"])", bill_Number: "\(name["bill_number"])",bill_generation_date:"\(name["bill_generation_date"])",bll_due_date: "\(name["due_date"])"))
                                      //  self.Beneficiaries_from_api_name.append("\(name["name"])")
                                     //   self.Beneficiaries_from_api_amt.append("\(name["total_bill_value"])")
                                   //     self.Beneficiaries_from_api_latefee.append("\(name["late_fee"])")
                                  //      self.Beneficiaries_from_api_bill_value.append("\(name["bill_value"])")
                                 //       self.Beneficiaries_from_api_bill_number.append("\(name["bill_number"])")
                                        print("Work here")
                                        print(self.billhistory_api)
                                        print("Work here1")
                                    }
                                   }
                                   self.billhistory_api.remove(at: 0)
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
 
    public func counter_check(){
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
            self.performSegue(withIdentifier: "PARENT_HISTORY_TO_HOME", sender: nil)
        })
    }
}
extension parent_history:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
           if tableView == table1{
            let cell = tableView.dequeueReusableCell(withIdentifier: "bill_history_reuse", for: indexPath)as! bill_history_class
            let assignText = billhistory_api[indexPath.row]
            cell.amt?.text = "₹" + " " + assignText.amt
            cell.status?.text = assignText.status
            cell.bill_due_date?.text = assignText.bll_due_date
            cell.bill_generation_date?.text = assignText.bill_generation_date
            cell.bill_number?.text = assignText.bill_Number
            print("cc2casa")
            print(cell.bill_number.text)
            cell.stacked.layer.cornerRadius = 15
            cell.stacked.layer.backgroundColor = UIColor(red: 0.10, green: 0.10, blue: 0.10, alpha: 1.00).cgColor
            return cell
           }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "repay_table", for: indexPath)as! repayment_only
            let assignText = repay_history[indexPath.row]
            cell.card_masked?.text = assignText.card_number
            cell.status?.text = assignText.status
            cell.date?.text = assignText.date
            cell.amount?.text = "₹" + " " + assignText.amount
            cell.stacked1.layer.cornerRadius = 15
            cell.stacked1.layer.backgroundColor = UIColor(red: 0.10, green: 0.10, blue: 0.10, alpha: 1.00).cgColor
            return cell
          }
       
        }
    
/*   @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
            let imgView = tapGestureRecognizer.view as! UIImageView
            print("your taped image view tag is : \(imgView.tag)")
            let indexPath = IndexPath(row: 0, section: 0)
            let cell = table1.cellForRow(at: indexPath)
            print(billhistory_api[imgView.tag])
        }*/
   
      func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
          if tableView == table1{
              return billhistory_api.count
          } else if tableView == table2 {
              return repay_history.count
           print("A2")
         }

        return billhistory_api.count
    }
}
class bill_history_class : UITableViewCell {
    @IBOutlet weak var stacked: UIStackView!
    @IBOutlet weak var bill_due_hori: UIStackView!
    @IBOutlet weak var bill_generation_hori: UIStackView!
    @IBOutlet weak var bill_horizon: UIStackView!
    @IBOutlet weak var drop: UIImageView!
    @IBOutlet weak var amt: UILabel!
    @IBOutlet weak var bill_due_date: UILabel!
    @IBOutlet weak var bill_generation_date: UILabel!
    @IBOutlet weak var bill_number: UILabel!
    @IBOutlet weak var status: UILabel!
}
class repayment_only  : UITableViewCell{
    @IBOutlet weak var stacked1: UIStackView!
    @IBOutlet weak var card_masked: UILabel!
    @IBOutlet weak var status: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var amount: UILabel!
}
