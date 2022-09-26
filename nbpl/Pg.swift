//
//  Pg.swift
//  nbpl
//
//  Created by Nexdha on 18/07/22.
//

import Foundation
import UIKit
import Alamofire
import AVFoundation
import SwiftyJSON
import DynamicBottomSheet
import Then
import BLTNBoard
import CashfreePGCoreSDK
import CashfreePGUISDK
import CashfreePG
import CryptoKit
class Pg: UIViewController {
    private let cfPaymentGatewayService = CFPaymentGatewayService.getInstance()

override func viewDidLoad() {
        super.viewDidLoad()
        print("B1")
        print(AppDelegate.Nexdha_student.bill_number)
     //   self.cfPaymentGatewayService.setCallback(self)
}
   
   
    @IBAction func sdk(_ sender: Any) {
      
            }
    }


