//
//  BannerViewModel.swift
//  DynamicHome
//
//  Created by Ranjit Mahto on 03/02/24.
//

import Foundation

final class BannerViewModal {
    
    var id: Int!
    var imageURL: String!
    
    init(banner: MainBanner) {
        self.id = banner.id
        self.imageURL = banner.imageURL
    }
    
    init(banner: PromotionalBanner) {
        self.id = banner.id
        self.imageURL = banner.imageURL
    }
    
    init(banner: BrandZoneBanner) {
        self.id = banner.id
        self.imageURL = banner.imageURL
    }
    
    init(banner: PromotionalBanner2) {
        self.id = banner.id
        self.imageURL = banner.imageURL
    }
}
