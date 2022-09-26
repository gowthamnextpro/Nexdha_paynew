//
//  terms_view.swift
//  nbpl
//
//  Created by Nexdha on 25/07/22.
//

import Foundation
import UIKit
import Alamofire
import AVFoundation
import SwiftyJSON
import TTGSnackbar
class terms_view: UIViewController , UITextFieldDelegate{
    @IBOutlet weak var reader: UIButton!
    @IBOutlet weak var closer: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        closer.layer.cornerRadius = 25
        reader.layer.cornerRadius = 25
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
           return .lightContent
       }
    @IBAction func readmore(_ sender: Any) {
        if let link1 = URL(string: "https://www.machpay.nexdha.com/_files/ugd/323de2_ee1fae5611e14fc7ab68872573bb252a.pdf") {
          UIApplication.shared.open(link1)
        }
    }
    @IBAction func close(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
