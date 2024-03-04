//
//  UIImageView+Extension.swift
//  DynamicHome
//
//  Created by Ranjit Mahto on 03/02/24.
//

import UIKit
import Kingfisher

extension UIImageView {
    func setImage(with urlString:String) {
        guard let url = URL(string: urlString) else {
            return
        }
        
        let resource = ImageResource(downloadURL: url, cacheKey: urlString)
        kf.indicatorType = .activity
        kf.setImage(with: resource)
    }
}
