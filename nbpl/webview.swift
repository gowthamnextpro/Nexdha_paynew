//
//  webview.swift
//  nbpl
//
//  Created by Nexdha on 14/06/22.
//

import Foundation
import UIKit
import WebKit
import Alamofire
import SwiftyJSON

class webview: UIViewController,WKUIDelegate{
    var webView: WKWebView!
    var web_url_segue = ""
    
override func viewDidLoad() {
    super.viewDidLoad()
    self.navigationController?.setNavigationBarHidden(false, animated: true)
    let myURL = URL(string:web_url_segue)
    let myRequest = URLRequest(url: myURL!)
    webView.load(myRequest)
    debugPrint(web_url_segue)
    counter_check()

    }
    override func viewWillAppear(_ animated: Bool) {
      counter_check()
      super.viewWillAppear(animated)
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
            self.performSegue(withIdentifier: "settings_to_home", sender: nil)
        })
    }
    override func loadView() {
       let webConfiguration = WKWebViewConfiguration()
       webView = WKWebView(frame: .zero, configuration: webConfiguration)
       webView.uiDelegate = self
       view = webView
    }
}
