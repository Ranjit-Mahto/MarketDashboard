//
//  APIManager.swift
//  DynamicHome
//
//  Created by Ranjit Mahto on 03/02/24.
//

import Foundation

enum DataError:Error {
    case invalidResponse
    case invalidURL
    case invalidData
    case decodingError(_ error: Error?)
}

//typealias Handler = (Result<ProductResponse, DataError>) -> Void

final class APIManager {
    
    static let shared = APIManager()
    private init(){}
    
    func fetchBanners(completionHandler : @escaping (Result<BannerResponse, DataError>) -> Void) {
        
        guard let url = URL(string: Constant.API.bannerRequestURL) else {
            completionHandler(.failure(.invalidURL))
            return
        }
        
        //print("RequestURL:-", url)
        
        URLSession.shared.dataTask(with: url) {(responseData, responseURL, responseError) in
            guard let responseData, responseError == nil else {
                completionHandler(.failure(.invalidData))
                return
            }
            
            //print("ResponseData:-", responseData)
            
            
            guard let respose = responseURL as? HTTPURLResponse, 200 ... 299 ~= respose.statusCode else {
                completionHandler(.failure(.invalidResponse))
                return
            }
            
            //print("ResponseStatusCode:-", respose.statusCode)
            //let jsonData = try? JSONSerialization.jsonObject(with: responseData, options: .mutableContainers)
            //print("ResponseJsonData:-", jsonData!)
            
            do {
                let banners = try JSONDecoder().decode(BannerResponse.self, from: responseData)
                completionHandler(.success(banners))
            }catch let error {
                print("DecodingError:-",error)
                completionHandler(.failure(.decodingError(error)))
            }
            
        }.resume()
        
    }
    
    func fetchProducts(page:Int, completionHandler : @escaping (Result<ProductResponse, DataError>) -> Void) {
        
        guard let url = URL(string: Constant.API.productRequestUrl(pageNo: page)) else {
            completionHandler(.failure(.invalidURL))
            return
        }
        //print("RequestURL:-", url)
        
        URLSession.shared.dataTask(with: url) {(responseData, responseURL, responseError) in
            guard let responseData, responseError == nil else {
                completionHandler(.failure(.invalidData))
                return
            }
            
            //print("ResponseData:-", responseData)
            
            guard let respose = responseURL as? HTTPURLResponse, 200 ... 299 ~= respose.statusCode else {
                completionHandler(.failure(.invalidResponse))
                return
            }
            
            //print("ResponseStatusCode:-", respose.statusCode)
           // let jsonData = try? JSONSerialization.jsonObject(with: responseData, options: .mutableContainers)
           // print("ResponseJsonData:-", jsonData!)
            
            do {
                let product = try JSONDecoder().decode(ProductResponse.self, from: responseData)
                completionHandler(.success(product))
            }catch let error {
                print("DecodingError:-",error)
                completionHandler(.failure(.decodingError(error)))
            }
            
        }.resume()
        
    }
}
