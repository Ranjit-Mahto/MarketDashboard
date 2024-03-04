//
//  HomeViewModel.swift
//  DynamicHome
//
//  Created by Ranjit Mahto on 04/02/24.
//

import Foundation

class HomeViewModel {
    
    var prodViewModels:[ProductViewModal] = [ProductViewModal]()
    var bnrViewModels:[BannerViewModal] = [BannerViewModal]()
    var productResponse : ProductResponse!
    var eventStatus: ((_ status:EventStatus)->Void)?
    
//    init(prodViewModels: [ProductViewModal], bnrViewModels: [BannerViewModal]) {
//        self.prodViewModels = prodViewModels
//        self.bnrViewModels = bnrViewModels
//    }
    
}

extension HomeViewModel {
    
    func populateData() {
        
        self.eventStatus?(.startLoading)
        
        let dispGroup = DispatchGroup()
        
        dispGroup.enter()
        self.getAllBanners {
            dispGroup.leave()
        }
        
        dispGroup.enter()
        self.getAllProducts(page: 1){
            dispGroup.leave()
        }
        
        dispGroup.notify(queue: .main){
            print("All Task Done")
            self.eventStatus?(.dataLoaded)
        }
    }
    
    private func getAllBanners(completion:@escaping()->Void){

        APIManager.shared.fetchBanners { responseResult in
            
            switch responseResult {
            case .success(let banners):
                //print(banners)

                let mBanners = banners.data.mainBanner.map{ baner in
                    return BannerViewModal(banner: baner)
                }
                
                let pBanner = banners.data.promotionalBanner.map{ baner in
                    return BannerViewModal(banner: baner)
                }
                
                let bzBanners = banners.data.brandZoneBanner.map { baner in
                    return BannerViewModal(banner: baner)
                }
                
                let p2Banner = banners.data.promotionalBanner2.map{ baner in
                    return BannerViewModal(banner: baner)
                }
                
                let allBanners = [ mBanners, pBanner, bzBanners, p2Banner].flatMap { $0 }
                self.bnrViewModels = allBanners

                completion()
            case .failure(let error):
                print("Response Error:::", error)
            }
        }
    }
    
    private func getAllProducts(page:Int, completion:@escaping()->Void){
        
        var products: [MarketList] = []
        
        APIManager.shared.fetchProducts(page: page) { responseResult in

            switch responseResult {
            case .success(let productReponse):
                //print(productReponse)
                products = productReponse.data.marketList
                self.productResponse = productReponse
                self.prodViewModels = products.map { prod in
                    return ProductViewModal(product: prod)
                }
                
                completion()
            case .failure(let error):
                print("Response Error:::", error)
            }
        }
    }
    

    func getMoreProducts(pageNo:Int, compleation:@escaping([ProductViewModal])->Void) {
        
        var products: [MarketList] = []
        var productViewModels:[ProductViewModal] = []
        
        APIManager.shared.fetchProducts(page: pageNo) { responseResult in
            
            switch responseResult {
            case .success(let productReponse):
                products = productReponse.data.marketList
                self.productResponse = productReponse
                productViewModels = products.map { prod in
                    return ProductViewModal(product: prod)
                }
                compleation(productViewModels)
                
            case .failure(let error):
                print(error)
            }
        }
    }
}




