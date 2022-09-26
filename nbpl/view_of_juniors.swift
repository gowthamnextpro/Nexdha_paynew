//
//  view_of_juniors.swift
//  nbpl
//
//  Created by Nexdha on 21/06/22.
//

import Foundation
import Alamofire
import SwiftyJSON
@available(iOS 13.0, *)
class view_of_juniors: UITableViewController {
   struct junior_list {
        var Name: String
        var email: String
        var phone: String
    }
    @IBOutlet weak var back: UIImageView!
    var Juniorlist_from_api = [
        junior_list(Name: "", email: "", phone: "")
    ]
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        view_of_juniordetail()
        counter_check()

        

        let payment_back_var = UITapGestureRecognizer(target: self, action: #selector(pay_back_clicked(_:)))
        back.addGestureRecognizer(payment_back_var)


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
            self.performSegue(withIdentifier: "view_of_junior_to_home", sender: nil)
        })
    }
    @objc func pay_back_clicked(_ sender: Any){
        self.dismiss(animated: true, completion: nil)
       }
    override var preferredStatusBarStyle: UIStatusBarStyle {
           return .lightContent
       }
    public func view_of_juniordetail(){
             let headers: HTTPHeaders = [
                 .authorization(UserDefaults.standard.object(forKey: "token") as! String)
             ]
        let parameters = ["view_type":"view_junior"]
        AF.request(AppDelegate.Nexdha_student.server+"/api/children", method: .post, parameters: parameters, headers: headers).responseJSON { response in
                // debugPrint(response)
                 switch response.result{
                               case .success(let value):
                                   let json = JSON(value).arrayValue
                                  // debugPrint(json)
                                   if json == []{
                                 //   debugPrint("Nothing")
                                    self.Juniorlist_from_api.append(junior_list(Name: "", email: "", phone: ""))
                                   }else {
                                    for name in json{
                                        self.Juniorlist_from_api.append(junior_list(Name: "\(name["name"])", email: "\(name["email"])", phone: "\(name["phone"])"))
                                       

                                    }
                                   }
                                   self.Juniorlist_from_api.remove(at: 0)
                                   self.tableView .reloadData()
                               case.failure(let error):
                                   print(error)
                               }
           
                    }
         }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Juniorlist_from_api.count
    }
      
      
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "view_junior_history", for: indexPath)as! transaction_view_history
        //cell.view_of_colors?.backgroundColor = UIColor(red: 0.18, green: 0.18, blue: 0.18, alpha: 1.00)
        // Configure the cell...
        let assignText = Juniorlist_from_api[indexPath.row]
       cell.name?.text = assignText.Name
       cell.email?.text = assignText.email
       cell.phone?.text = assignText.phone
       cell.total_view.backgroundColor = UIColor(red: 0.14, green: 0.14, blue: 0.20, alpha: 1.00)
       cell.total_view.layer.cornerRadius = 15
       return cell
        
    }
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return ""
    }
}
class transaction_view_history:UITableViewCell{
    @IBOutlet weak var total_view: UIStackView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var phone: UILabel!
}

