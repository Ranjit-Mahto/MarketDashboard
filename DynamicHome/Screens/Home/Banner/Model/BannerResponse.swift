//
//  BannerResponse.swift
//  DynamicHome
//
//  Created by Ranjit Mahto on 02/02/24.
//

import Foundation

// MARK: - RootModel
struct BannerResponse: Codable {
    
    var data: BannerData
    var errorCode: String
    var message: String
    
    enum CodingKeys: String, CodingKey {
        case data = "Data"
        case errorCode = "ErrorCode"
        case message = "Message"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        message = try container.decode(String.self, forKey: .message)
        data = try container.decode(BannerData.self, forKey: .data)
        errorCode = try container.decode(String.self, forKey: .errorCode)
    }
    
    // MARK: - Data
    struct BannerData: Codable {
        
        var mainBanner: [MainBanner]
        var promotionalBanner: [PromotionalBanner]
        var recommended: Recommended
        var brandZoneBanner: [BrandZoneBanner]
        var promotionalBanner2: [PromotionalBanner2]
        
        enum CodingKeys: String, CodingKey {
            case mainBanner
            case promotionalBanner
            case recommended
            case brandZoneBanner
            case promotionalBanner2
        }
        
        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            mainBanner = try container.decode([MainBanner].self, forKey: .mainBanner)
            promotionalBanner = try container.decode([PromotionalBanner].self, forKey: .promotionalBanner)
            brandZoneBanner = try container.decode([BrandZoneBanner].self, forKey: .brandZoneBanner)
            recommended = try container.decode(Recommended.self, forKey: .recommended)
            promotionalBanner2 = try container.decode([PromotionalBanner2].self, forKey: .promotionalBanner2)
        }
    }
}


// MARK: - PromotionalBanner
struct PromotionalBanner: Codable {
    
    var isClickable: Bool
    var deeplink: String
    var deeplinkArr: DeeplinkArr
    var type: String
    var id: Int
    var imageURL: String
    
    enum CodingKeys: String, CodingKey {
        case isClickable
        case deeplink
        case deeplinkArr
        case type
        case id
        case imageURL = "imageUrl"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        type = try container.decode(String.self, forKey: .type)
        isClickable = try container.decode(Bool.self, forKey: .isClickable)
        imageURL = try container.decode(String.self, forKey: .imageURL)
        deeplinkArr = try container.decode(DeeplinkArr.self, forKey: .deeplinkArr)
        deeplink = try container.decode(String.self, forKey: .deeplink)
    }
    
    // MARK: - DeeplinkArr
    struct DeeplinkArr: Codable {
        
        var type: String
        var offerID: Int
        var filterCount: Int
        var lang: String
        var marketCode: String
        var offerInfo: OfferInfo
        
        enum CodingKeys: String, CodingKey {
            case type
            case offerID = "offerId"
            case filterCount
            case lang
            case marketCode
            case offerInfo
        }
        
        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            type = try container.decode(String.self, forKey: .type)
            offerID = try container.decode(Int.self, forKey: .offerID)
            filterCount = try container.decode(Int.self, forKey: .filterCount)
            lang = try container.decode(String.self, forKey: .lang)
            marketCode = try container.decode(String.self, forKey: .marketCode)
            offerInfo = try container.decode(OfferInfo.self, forKey: .offerInfo)
        }
        
        // MARK: - OfferInfo
        struct OfferInfo: Codable {
            
            var id: Int
            var description: String
            var validTo: Int
            var shortDescription: String
            var validFrom: Int
            var name: String
            var image: String
            
            enum CodingKeys: String, CodingKey {
                case id
                case description
                case validTo = "valid_to"
                case shortDescription = "short_description"
                case validFrom = "valid_from"
                case name
                case image
            }
            
            init(from decoder: Decoder) throws {
                let container = try decoder.container(keyedBy: CodingKeys.self)
                id = try container.decode(Int.self, forKey: .id)
                description = try container.decode(String.self, forKey: .description)
                validTo = try container.decode(Int.self, forKey: .validTo)
                shortDescription = try container.decode(String.self, forKey: .shortDescription)
                validFrom = try container.decode(Int.self, forKey: .validFrom)
                name = try container.decode(String.self, forKey: .name)
                image = try container.decode(String.self, forKey: .image)
            }
            
        }
        
    }
    
}

// MARK: - MainBanner
struct MainBanner: Codable {
    
    var isClickable: Bool
    var deeplink: String
    var deeplinkArr: DeeplinkArr
    var type: String
    var id: Int
    var imageURL: String
    
    enum CodingKeys: String, CodingKey {
        case isClickable
        case deeplink
        case deeplinkArr
        case type
        case id
        case imageURL = "imageUrl"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        type = try container.decode(String.self, forKey: .type)
        deeplinkArr = try container.decode(DeeplinkArr.self, forKey: .deeplinkArr)
        deeplink = try container.decode(String.self, forKey: .deeplink)
        id = try container.decode(Int.self, forKey: .id)
        isClickable = try container.decode(Bool.self, forKey: .isClickable)
        imageURL = try container.decode(String.self, forKey: .imageURL)
    }
    
    // MARK: - DeeplinkArr
    struct DeeplinkArr: Codable {
        
        var type: String
        var tags: [String]?
        var filterCount: Int
        var lang: String
        var marketCode: String
        
        enum CodingKeys: String, CodingKey {
            case type
            case tags
            case filterCount
            case lang
            case marketCode
        }
        
        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            type = try container.decode(String.self, forKey: .type)
            tags = try container.decodeIfPresent([String].self, forKey: .tags)
            filterCount = try container.decode(Int.self, forKey: .filterCount)
            lang = try container.decode(String.self, forKey: .lang)
            marketCode = try container.decode(String.self, forKey: .marketCode)
        }
    }
}

// MARK: - BrandZoneBanner
struct BrandZoneBanner: Codable {
    
    var id: Int
    var deeplinkArr: DeeplinkArr
    var deeplink: String
    var isClickable: Bool
    var imageURL: String
    var type: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case deeplinkArr
        case deeplink
        case isClickable
        case imageURL = "imageUrl"
        case type
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        type = try container.decode(String.self, forKey: .type)
        isClickable = try container.decode(Bool.self, forKey: .isClickable)
        imageURL = try container.decode(String.self, forKey: .imageURL)
        deeplinkArr = try container.decode(DeeplinkArr.self, forKey: .deeplinkArr)
        deeplink = try container.decode(String.self, forKey: .deeplink)
    }
    
    // MARK: - DeeplinkArr
    struct DeeplinkArr: Codable {
        
        var lang: String
        var tags: [String]?
        var offerInfo: OfferInfo?
        var filterCount: Int
        var type: String
        var marketCode: String
        var offerID: Int?
        
        enum CodingKeys: String, CodingKey {
            case lang
            case tags
            case offerInfo
            case filterCount
            case type
            case marketCode
            case offerID = "offerId"
        }
        
        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            lang = try container.decode(String.self, forKey: .lang)
            tags = try container.decodeIfPresent([String].self, forKey: .tags)
            offerInfo = try container.decodeIfPresent(OfferInfo.self, forKey: .offerInfo)
            filterCount = try container.decode(Int.self, forKey: .filterCount)
            type = try container.decode(String.self, forKey: .type)
            marketCode = try container.decode(String.self, forKey: .marketCode)
            offerID = try container.decodeIfPresent(Int.self, forKey: .offerID)
        }
        
        // MARK: - OfferInfo
        struct OfferInfo: Codable {
            
            var id: Int
            var validTo: Int
            var name: String
            var description: String
            var validFrom: Int
            var shortDescription: String
            var image: String
            
            enum CodingKeys: String, CodingKey {
                case id
                case validTo = "valid_to"
                case name
                case description
                case validFrom = "valid_from"
                case shortDescription = "short_description"
                case image
            }
            
            init(from decoder: Decoder) throws {
                let container = try decoder.container(keyedBy: CodingKeys.self)
                id = try container.decode(Int.self, forKey: .id)
                validTo = try container.decode(Int.self, forKey: .validTo)
                name = try container.decode(String.self, forKey: .name)
                description = try container.decode(String.self, forKey: .description)
                validFrom = try container.decode(Int.self, forKey: .validFrom)
                shortDescription = try container.decode(String.self, forKey: .shortDescription)
                image = try container.decode(String.self, forKey: .image)
            }
        }
    }
}

// MARK: - PromotionalBanner2
struct PromotionalBanner2: Codable {
    
    var id: Int
    var deeplinkArr: DeeplinkArr
    var isClickable: Bool
    var deeplink: String
    var imageURL: String
    var type: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case deeplinkArr
        case isClickable
        case deeplink
        case imageURL = "imageUrl"
        case type
    }
    
    // MARK: - DeeplinkArr
    struct DeeplinkArr: Codable {
        
        var filterCount: Int
        var offerInfo: OfferInfo
        var marketCode: String
        var lang: String
        var type: String
        var offerID: Int
        
        enum CodingKeys: String, CodingKey {
            case filterCount
            case offerInfo
            case marketCode
            case lang
            case type
            case offerID = "offerId"
        }
        
        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            filterCount = try container.decode(Int.self, forKey: .filterCount)
            offerInfo = try container.decode(OfferInfo.self, forKey: .offerInfo)
            marketCode = try container.decode(String.self, forKey: .marketCode)
            lang = try container.decode(String.self, forKey: .lang)
            type = try container.decode(String.self, forKey: .type)
            offerID = try container.decode(Int.self, forKey: .offerID)
        }
        
        // MARK: - OfferInfo
        struct OfferInfo: Codable {
            
            var validTo: Int
            var id: Int
            var description: String
            var shortDescription: String
            var validFrom: Int
            var name: String
            var image: String
            
            enum CodingKeys: String, CodingKey {
                case validTo = "valid_to"
                case id
                case description
                case shortDescription = "short_description"
                case validFrom = "valid_from"
                case name
                case image
            }
            
            init(from decoder: Decoder) throws {
                let container = try decoder.container(keyedBy: CodingKeys.self)
                validTo = try container.decode(Int.self, forKey: .validTo)
                id = try container.decode(Int.self, forKey: .id)
                description = try container.decode(String.self, forKey: .description)
                shortDescription = try container.decode(String.self, forKey: .shortDescription)
                validFrom = try container.decode(Int.self, forKey: .validFrom)
                name = try container.decode(String.self, forKey: .name)
                image = try container.decode(String.self, forKey: .image)
            }
        }
        
    }
}

// MARK: - Recommended
struct Recommended: Codable {
    
    var name: String
    var productTagID: Int
    
    enum CodingKeys: String, CodingKey {
        case name
        case productTagID = "productTagId"
    }
}
