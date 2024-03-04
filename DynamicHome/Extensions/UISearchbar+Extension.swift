//
//  UISearchbar+Extension.swift
//  DynamicHome
//
//  Created by Ranjit Mahto on 04/02/24.
//

import Foundation
import UIKit

extension UISearchBar {
    
    func changeSearchBarColor(fieldColor: UIColor, backColor: UIColor, borderColor: UIColor?) {
        UIGraphicsBeginImageContext(bounds.size)
        backColor.setFill()
        UIBezierPath(rect: bounds).fill()
        setBackgroundImage(UIGraphicsGetImageFromCurrentImageContext()!, for: UIBarPosition.any, barMetrics: .default)
        
        let newBounds = bounds.insetBy(dx: 0, dy: 8)
        fieldColor.setFill()
        let path = UIBezierPath(roundedRect: newBounds, cornerRadius: newBounds.height / 2)
        
        if let borderColor = borderColor {
            borderColor.setStroke()
            path.lineWidth = 1 / UIScreen.main.scale
            path.stroke()
        }
        
        path.fill()
        setSearchFieldBackgroundImage(UIGraphicsGetImageFromCurrentImageContext()!, for: UIControl.State.normal)
        
        UIGraphicsEndImageContext()
    }
}
