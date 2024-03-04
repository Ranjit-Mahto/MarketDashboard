//
//  HomeViewController.swift
//  DynamicHome
//
//  Created by Ranjit Mahto on 02/02/24.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var searchbar : UISearchBar!
    
     var allLoadedProductModels:[ProductViewModal]  = []
    
    let flowLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 3.5
        layout.minimumLineSpacing = 5
        layout.sectionInset = UIEdgeInsets(top:0.0, left: 0.0, bottom:0.0, right: 0.0)
        layout.estimatedItemSize = .zero
        return layout
    }()
    
    var homeViewModel = HomeViewModel()
    
    var isMoreProductsAvailable:Bool {
        
        guard allLoadedProductModels.count != 0, homeViewModel.productResponse.data.pagination.totalCount != 0 else {
            return true
        }
        
        if allLoadedProductModels.count < homeViewModel.productResponse.data.pagination.totalCount {
            return true
        }
        return false
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.setUpView()
        self.loadHomeViewData()
    }

    private func setUpView(){
        
        searchbar.changeSearchBarColor(fieldColor: .white, backColor: .systemYellow, borderColor: .black)
        
        //registercell
        let bannerCellNib = UINib(nibName: "BannerViewCell", bundle: nil)
        self.collectionView.register(bannerCellNib, forCellWithReuseIdentifier:"BannerCell")
        
        let productCellNib = UINib(nibName: "ProductViewCell", bundle: nil)
        self.collectionView.register(productCellNib, forCellWithReuseIdentifier:"ProductCell")
        
        collectionView.dataSource = self
        collectionView.delegate = self
    }
}

//MVVM
extension HomeViewController {
    
    private func loadHomeViewData() {
        
        homeViewModel.populateData()
        homeViewModel.eventStatus = { [weak self] status in
            
            guard let self else {return}
            
            switch status {
            case .startLoading:
                print("startLoading....")
            case .stopLoading:
                print("stoploading!")
            case .dataLoaded:
                print("All dataloaded...$")
                self.allLoadedProductModels.append(contentsOf: homeViewModel.prodViewModels)
                print("AllTotalData For Load:", self.allLoadedProductModels.count)
                DispatchQueue.main.async {
                    print("Load  CollectionView")
                    self.collectionView.reloadData()
                }
            case .error(let error):
                print(error!)
            }
        }
    }
    
    func loadMoreData(page:Int) {
        
        if isMoreProductsAvailable {
            
            print("Total Fetched data .... \(allLoadedProductModels.count)")
            
            let nextPage = homeViewModel.productResponse.data.pagination.page + 1
            
            homeViewModel.getMoreProducts(pageNo: nextPage) { prodViewModels in
                if prodViewModels.count > 0 {
                    self.allLoadedProductModels.append(contentsOf: prodViewModels)
                    print("AllTotalData For Load More:", self.allLoadedProductModels.count)
                    DispatchQueue.main.async {
                        self.collectionView.reloadData()
                    }
                }
            }
            
        }else{
            debugPrint("No More Data")
        }
    }
}

