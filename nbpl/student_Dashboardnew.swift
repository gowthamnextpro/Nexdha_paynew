//
//  student_Dashboardnew.swift
//  NexdhaPay
//
//  Created by Nexdha on 19/09/22.
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

class student_Dashboardnew: UIViewController  {
    @IBOutlet weak var progressBar: ProgressBar!
    // var circularProgressBarView: CircularProgressBarView!
    // var circularViewDuration: TimeInterval = 2
    
    var countFired: CGFloat = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        //  CircularProgress.setprogress(0.3, UIColor.blue, "3000")
        //  CircularProgress.animate(0.9, duration: 2)
        
        /*     Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { (timer) in
         self.countFired += 1
         
         
         DispatchQueue.main.async {
         self.progressBar.progress = min(CGFloat(0.03 * self.countFired), 1)
         
         
         if self.progressBar.progress == 1{
         timer.invalidate()
         }
         }
         
         }*/

        
    }
    
    
    private func showCase() {
        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { (timer) in
            self.countFired += 1
            
            DispatchQueue.main.async {
                self.progressBar.progress = min(CGFloat(0.04 * self.countFired), 1)
                //    self.progressBar2.progress = min(CGFloat(0.03 * self.countFired), 1)
                //    self.progressBar3.progress = min(CGFloat(0.02 * self.countFired), 1)
                
                if self.progressBar.progress == 1 {
                    timer.invalidate()
                }
            }
        }
    }
}
