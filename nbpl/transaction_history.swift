//
//  transaction_history.swift
//  nbpl
//
//  Created by Nexdha on 06/06/22.
//

import UIKit
import Alamofire
import SwiftyJSON
@available(iOS 13.0, *)
class transaction_history: UITableViewController {
    var count = 0

    struct tran_list {
        var place: String
        var amount: String
        var date: String
        var settlement_status: String
    }
    var transactionlist_from_api = [
      //  tran_list(place: "", amount: "", date: "" , settlement_status: "")
        tran_list(place: "", amount: "", date: "" ,settlement_status: "")

    ]
    override func viewDidLoad() {
        super.viewDidLoad()
        transaction_student()
        print("kaira")
        counter_check()
    }
    override func viewWillAppear(_ animated: Bool) {
      counter_check()
      super.viewWillAppear(animated)
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
            self.performSegue(withIdentifier: "history_to_home", sender: nil)
        })
    }
    public func activity_log(){
        let headers: HTTPHeaders = [
            .authorization(UserDefaults.standard.string(forKey: "token") as! String)
        ]
        
        let parameters = ["activity_id": "101" ,"os": "iOS"]

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
    public func transaction_student(){
        let headers: HTTPHeaders = [
            .authorization(UserDefaults.standard.object(forKey: "token") as! String)
        ]
             AF.request(AppDelegate.Nexdha_student.server+"/api/transaction_data", method: .post, headers: headers).responseJSON { response in
                // debugPrint(response)
                 switch response.result{
                               case .success(let value):
                                   let json = JSON(value).arrayValue
                                  // debugPrint(json)
                                   if json == []{
                                 //   debugPrint("Nothing")
                                       self.transactionlist_from_api.append(tran_list(place: "No transaction Done", amount: "", date: "", settlement_status: ""))
                                   }else {
                                    for name in json{
                                        self.transactionlist_from_api.append(tran_list(place: "\(name["place"])", amount: "\(name["amount"])", date: "\(name["created_at"])", settlement_status: "\(name["settlement_status"])"))
                                    }
                                   }
                                   self.transactionlist_from_api.remove(at: 0)
                                /*   for name in json{
                                       self.transactionlist_from_api.append(tran_list(id: "\(name["transaction_id"])", type: "\(name["state"])", date: "\(name["udf5"])", name: "\(name["udf3"])", amount: "\(name["amount"])", status: "\(name["response_message"])", eta: "\(name["address_line_1"])"))
                                      
                                   }
                                   self.transactionlist_from_api.remove(at: 0) */
                                   self.tableView .reloadData()
                                     //  let json = JSON(value).arrayValue
                                      // debugPrint(username)
                                    
                                   
                               case.failure(let error):
                                   print(error)
                               }
           
                    }
         }

override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    // #warning Incomplete implementation, return the number of rows
    return transactionlist_from_api.count
}
    override var preferredStatusBarStyle: UIStatusBarStyle {
           return .lightContent
       }
override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "Trans_history", for: indexPath)as! Trans_history
   cell.view_of_colors?.backgroundColor = UIColor(red: 0.18, green: 0.18, blue: 0.18, alpha: 1.00)
    print("****")
    print(cell)
    // Configure the cell...
  //  cell.date?.textColor = UIColor(red: 0.18, green: 0.18, blue: 0.18, alpha: 1.00)
    let assignText = transactionlist_from_api[indexPath.row]
    cell.place?.text = assignText.place
    cell.amount?.text = assignText.amount
    let dates = assignText.date
    let date_only = dates.components(separatedBy: "T")
    let d_ate    = date_only[0]
    print(d_ate)
    cell.date?.text = d_ate
    
    if (assignText.settlement_status) == "success" {
        cell.status?.textColor =  UIColor(red: 0.00, green: 1.00, blue: 0.20, alpha: 1.00)
        cell.status?.text = assignText.settlement_status
     /*   if Double(assignText.amount) != nil {
        debugPrint(assignText.amount)
            let amount_convertion = String(format: "%.2f", Double(assignText.amount)!)
            cell.amount?.text = "-" + "₹" + " " + amount_convertion
       }*/

    }else if (assignText.settlement_status) == "Pending"{
        cell.status?.textColor = UIColor(red: 0.00, green: 0.67, blue: 1.00, alpha: 1.00)
        cell.status?.text = assignText.settlement_status
       /* if Double(assignText.amount) != nil {
        debugPrint(assignText.amount)
            let amount_convertion = String(format: "%.2f", Double(assignText.amount)!)
            cell.amount?.text = "-" + "₹" + " " + amount_convertion
       }*/
    }else{
        cell.status?.textColor =  UIColor(red: 0.97, green: 0.11, blue: 0.11, alpha: 1.00)
        cell.status?.text = assignText.settlement_status
    }
    if Double(assignText.amount) != nil {
    debugPrint(assignText.amount)
        let amount_convertion = String(format: "%.2f", Double(assignText.amount)!)
        cell.amount?.text = "₹" + " " + amount_convertion
   }
    //cell.transaction_amount_text?.text = assignText.amount
   
   // cell.transaction_status_text?.text = assignText.status
   
   /* if indexPath.row % 2 == 0 {
        cell.history_content.layer.backgroundColor = UIColor(red:235/255, green:245/255, blue:249/255, alpha: 1).cgColor
    }else{
        cell.history_content.layer.backgroundColor = UIColor(red:255/255, green:255/255, blue:255/255, alpha: 1).cgColor
    }*/
    cell.stacked.layer.cornerRadius = 15
    cell.stacked.layer.backgroundColor = UIColor(red: 0.10, green: 0.10, blue: 0.10, alpha: 1.00).cgColor



    return cell
    
}


/*
// Override to support conditional editing of the table view.
override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
    // Return false if you do not want the specified item to be editable.
    return true
}
*/
override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
return ""
}
/*
// Override to support editing the table view.
override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    if editingStyle == .delete {
        // Delete the row from the data source
        tableView.deleteRows(at: [indexPath], with: .fade)
    } else if editingStyle == .insert {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
}
*/

/*
// Override to support rearranging the table view.
override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

}
*/

/*
// Override to support conditional rearranging of the table view.
override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
    // Return false if you do not want the item to be re-orderable.
    return true
}
*/

/*
// MARK: - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    // Get the new view controller using segue.destination.
    // Pass the selected object to the new view controller.
}
*/

}

class Trans_history : UITableViewCell{
    @IBOutlet weak var stacked: UIStackView!
    @IBOutlet weak var status: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var view_of_colors: UIView!
    @IBOutlet weak var amount: UILabel!
    @IBOutlet weak var place: UILabel!
}
