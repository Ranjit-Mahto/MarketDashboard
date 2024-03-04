//
//  ScrollableViewCell.swift
//  DynamicHome
//
//  Created by Ranjit Mahto on 02/02/24.
//

import UIKit

class ScrollableViewCell: UICollectionViewCell {
    
    @IBOutlet weak var bgView : UIView!
    @IBOutlet weak var imgView : UIImageView!
    
    var scrollBannerVM:BannerViewModal? {
        didSet {
            populateBanner()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    
    func populateBanner() {
        guard let scrollBannerVM else {return}
        imgView.setImage(with: scrollBannerVM.imageURL)
    }

}
