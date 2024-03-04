//
//  ProductResponse.swift
//  DynamicHome
//
//  Created by Ranjit Mahto on 02/02/24.
//

import Foundation

// MARK: - RootModel
struct ProductResponse: Codable {
    
    var errorCode: String
    var data: ProductData
    var message: String
    
    enum CodingKeys: String, CodingKey {
        case errorCode = "ErrorCode"
        case data = "Data"
        case message = "Message"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        errorCode = try container.decode(String.self, forKey: .errorCode)
        data = try container.decode(ProductData.self, forKey: .data)
        message = try container.decode(String.self, forKey: .message)
    }
    
}

// MARK: - Data
struct ProductData: Codable {
    
    var pagination: Pagination
    var marketList: [MarketList]
    
    enum CodingKeys: String, CodingKey {
        case pagination = "Pagination"
        case marketList
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        pagination = try container.decode(Pagination.self, forKey: .pagination)
        marketList = try container.decode([MarketList].self, forKey: .marketList)
    }
    
}

// MARK: - Pagination
struct Pagination: Codable {
    
    var totalPage: Int
    var page: Int
    var totalCount: Int
    var rowsPerPage: Int
    
    enum CodingKeys: String, CodingKey {
        case totalPage
        case page
        case totalCount
        case rowsPerPage
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        totalPage = try container.decode(Int.self, forKey: .totalPage)
        page = try container.decode(Int.self, forKey: .page)
        totalCount = try container.decode(Int.self, forKey: .totalCount)
        rowsPerPage = try container.decode(Int.self, forKey: .rowsPerPage)
    }
}

// MARK: - MarketList
struct MarketList: Codable {
    
    var name: String
    var localPrice: Int
    var ratingEmoji: String
    var sponsorProductID: Int
    var productID: Int
    var localCrossedPrice: Int
    var brand: String
    var rank: Double
    var imgURL: String
    
    enum CodingKeys: String, CodingKey {
        case name
        case localPrice
        case ratingEmoji
        case sponsorProductID = "sponsorProductId"
        case productID = "productId"
        case localCrossedPrice
        case brand
        case rank
        case imgURL = "imgUrl"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        localPrice = try container.decode(Int.self, forKey: .localPrice)
        ratingEmoji = try container.decode(String.self, forKey: .ratingEmoji)
        sponsorProductID = try container.decode(Int.self, forKey: .sponsorProductID)
        productID = try container.decode(Int.self, forKey: .productID)
        localCrossedPrice = try container.decode(Int.self, forKey: .localCrossedPrice)
        brand = try container.decode(String.self, forKey: .brand)
        rank = try container.decode(Double.self, forKey: .rank)
        imgURL = try container.decode(String.self, forKey: .imgURL)
    }
    
}
