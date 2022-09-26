//
//  gradientview.swift
//  Nexdha's BNPL
//
//  Created by Nexdha on 26/05/22.
//

import Foundation
import UIKit
class GradientButton: UIButton {
    
    var startColor: UIColor = UIColor.yellow
    var endColor  : UIColor = UIColor.orange
    
    init(frame: CGRect, startColor: UIColor, endColor: UIColor) {
        super.init(frame: frame)
        self.startColor = startColor
        self.endColor   = endColor
        createGradient()
        setCornerRadius()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func createGradient() {
        let gradientColors: [CGColor] = [startColor.cgColor, endColor.cgColor]
        let gradientLayer: CAGradientLayer = CAGradientLayer()
        gradientLayer.colors = gradientColors
        gradientLayer.frame = bounds
        layer.insertSublayer(gradientLayer, at: 0)
    }
    
    func setCornerRadius() {
        layer.masksToBounds = true
        layer.cornerRadius  = 10
        layer.borderColor   = UIColor.red.cgColor
        layer.borderWidth   = 1
    }
}
