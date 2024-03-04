//
//  Constant.swift
//  DynamicHome
//
//  Created by Ranjit Mahto on 03/02/24.
//

enum Constant {
    enum API {
        static let bannerRequestURL = "https://staging-main-www.zoodmall.com/interface/home.php?marketCode-UZ" 
        //"https://d26k5.wiremockapi.cloud/home?marketCode=UZ"
        static let productRequestURL = "https://staging-main-www.zoodmall.com/interface/products.php?page=1&productTagld=13&marketCode=UZ"
        //"https://d26k5.wiremockapi.cloud/productlist?page=1&productTagId=13&marketCode=UZ"
        
        static func productRequestUrl(pageNo: Int) -> String {
            return  "https://staging-main-www.zoodmall.com/interface/products.php?page=\(pageNo)&productTagld=13&marketCode=UZ"
            //"https://d26k5.wiremockapi.cloud/productlist?page=\(pageNo)&productTagId=13&marketCode=UZ"
        }
    }
}

enum EventStatus {
    case startLoading
    case stopLoading
    case dataLoaded
    case error(Error?)
}
