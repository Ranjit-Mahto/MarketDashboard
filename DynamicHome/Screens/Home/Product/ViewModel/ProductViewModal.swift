//
//  ProductViewModal.swift
//  DynamicHome
//
//  Created by Ranjit Mahto on 03/02/24.
//

import Foundation

final class ProductViewModal {
    
    var productID: Int!
    var name: String!
    var localPrice: Int!
    var imgURL: String!
    var rank: Double!
    var ratingEmoji: String!
    var localCrossedPrice: Int!
    var brand: String!
    var sponsorProductID: Int!
    
    init (product: MarketList) {
        self.productID = product.productID
        self.name = product.name
        self.localPrice = product.localPrice
        self.imgURL = product.imgURL
        self.rank = product.rank
        self.ratingEmoji = product.ratingEmoji
        self.localCrossedPrice = product.localCrossedPrice
        self.brand = product.brand
        self.sponsorProductID = product.sponsorProductID
    }
    
}
