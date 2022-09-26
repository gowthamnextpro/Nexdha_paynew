//
//  onboarding.swift
//  nbpl
//
//  Created by Nexdha on 20/07/22.
//

import Foundation
import Foundation
import UIKit
import Alamofire
import SwiftyJSON
@available(iOS 13.0, *)
class onboarding: UIViewController, UITextFieldDelegate, UIScrollViewDelegate{
    
    @IBOutlet weak var scrollview: UIScrollView!
    @IBOutlet weak var finish: UIButton!
    @IBOutlet weak var page_contro: UIPageControl!
    var scrollWidth: CGFloat! = 0.0
    var scrollHeight: CGFloat! = 0.0
    var cont = ""

    
    var titles = ["","","",""]
    var descs = ["","","",""]
    var imgs = ["onboard 3","onboard 2","onboard 1","onboard 4"]

       override func viewDidLayoutSubviews() {
           scrollWidth = scrollview.frame.size.width
           scrollHeight = scrollview.frame.size.height
       }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.layoutIfNeeded()

        self.scrollview.delegate = self
        scrollview.isPagingEnabled = true
        scrollview.showsHorizontalScrollIndicator = false
        scrollview.showsVerticalScrollIndicator = false
        finish.isHidden = true

               //crete the slides and add them
        var frame = CGRect(x: 0, y: 0, width: 0, height: 0)
        for index in 0..<titles.count {
           
                   frame.origin.x = scrollWidth * CGFloat(index)
                   frame.size = CGSize(width: scrollWidth, height: scrollHeight)

                   let slide = UIView(frame: frame)
            
            
            
            
                   //subviews
                    let imageView = UIImageView.init(image: UIImage.init(named: imgs[index]))
                    imageView.frame = CGRect(x:0,y:0,width:UIScreen.main.bounds.width,height:scrollview.frame.size.height)
                    imageView.contentMode = .scaleAspectFit
                  /* imageView.center = CGPoint(x:scrollWidth/2,y: scrollHeight/2 - 50)
 */
                 
                   let txt1 = UILabel.init(frame: CGRect(x:32,y:imageView.frame.maxY+30,width:scrollWidth-64,height:30))
                   txt1.textAlignment = .center
                   txt1.font = UIFont.boldSystemFont(ofSize: 20.0)
                   txt1.text = titles[index]

                   let txt2 = UILabel.init(frame: CGRect(x:32,y:txt1.frame.maxY+10,width:scrollWidth-64,height:50))
                   txt2.textAlignment = .center
                   txt2.numberOfLines = 3
                   txt2.font = UIFont.systemFont(ofSize: 18.0)
                   txt2.text = descs[index]

                   slide.addSubview(imageView)
                   slide.addSubview(txt1)
                   slide.addSubview(txt2)
                    scrollview.addSubview(slide)
            
            
            //set width of scrollview to accomodate all the slides
            scrollview.contentSize = CGSize(width: scrollWidth * CGFloat(titles.count), height: scrollHeight)

                   //disable vertical scroll/bounce
                   self.scrollview.contentSize.height = 1.0

                   //initial state
            page_contro.numberOfPages = titles.count
            page_contro.currentPage = 0

}
    }
    @IBAction func page_changed(_ sender: Any) {
        if AppDelegate.Nexdha_student.usertype_otp == "junior"  {
            self.performSegue(withIdentifier: "onboard_studentdashboard", sender: self)///// for onboarding checking
        }else if AppDelegate.Nexdha_student.usertype_otp == "parent"{
            self.performSegue(withIdentifier: "onboarding_parentdashboard", sender: self)///// for onboarding checking
        }
        
    }
    
    
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
           return .lightContent
       }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        setIndiactorForCurrentPage()
    }

    func setIndiactorForCurrentPage()  {
        let page = (scrollview?.contentOffset.x)!/scrollWidth
        page_contro?.currentPage = Int(page)
        debugPrint(String(page_contro.currentPage))
        if String(page_contro.currentPage) == "3"{
            finish.isHidden = false
        }else{
            debugPrint("Dont")
        }
      
    }
}
