//
//  BlogViewController.swift
//  nbpl
//
//  Created by Nexdha on 24/06/22.
//
import UIKit

import Foundation
class BlogViewController: UIViewController {
    
    @IBOutlet var blogNameLabel: UILabel!
    
    var blogName = String()

    override func viewWillAppear(_ animated: Bool) {
        blogNameLabel.text = blogName
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
