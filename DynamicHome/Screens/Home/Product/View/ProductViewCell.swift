//
//  ProductViewCell.swift
//  DynamicHome
//
//  Created by Ranjit Mahto on 02/02/24.
//

import UIKit

class ProductViewCell: UICollectionViewCell {
    
    @IBOutlet weak var viewBg : UIView!
    @IBOutlet weak var lblName : UILabel!
    
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var lblBrand: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblCrossedPrice: UILabel!
    @IBOutlet weak var lblRating: UILabel!
    
    var productVM : ProductViewModal? {
        didSet {
            configProductCellView()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configProductCellView(){
        
        guard let productVM else {return}
        lblName.text = productVM.name
        lblBrand.text = productVM.brand
        lblPrice.text =  String.localCurreny(price: productVM.localPrice)
        lblCrossedPrice.attributedText =  String.crossedCurrency(price: productVM.localCrossedPrice)
        lblRating.text = String.getEmojiRating(ratingEmoji: productVM.ratingEmoji, ratingValue: productVM.rank)
        productImageView.setImage(with: productVM.imgURL)
        
    }
}


