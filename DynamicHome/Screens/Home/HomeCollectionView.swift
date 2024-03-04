//
//  HomeCollectionView.swift
//  DynamicHome
//
//  Created by Ranjit Mahto on 03/02/24.
//

import Foundation
import UIKit

extension HomeViewController : UICollectionViewDataSource  {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if section == 0 {
            return homeViewModel.bnrViewModels.count > 0 ? 1 : 0
        }
        return allLoadedProductModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BannerCell", for: indexPath) as! BannerViewCell
            cell.bannerViewModels = homeViewModel.bnrViewModels
            return cell
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCell", for: indexPath) as! ProductViewCell
        cell.productVM =  allLoadedProductModels[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "CollectionHeaderCell", for: indexPath) as! CollectionHeaderView
            headerView.lblTitle.text = "Recommended"
            return headerView
        case UICollectionView.elementKindSectionFooter:
            let footerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "CollectionFooterCell", for: indexPath) as! CollectionFooterView
            
            if isMoreProductsAvailable {
                footerView.lblTitle.text = "Lode More Products"
            }else{
                footerView.lblTitle.text = "No More Products"
            }
            return footerView
            
        default:
            return UICollectionReusableView()
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        let itemWidth = collectionView.bounds.width
        
        if section == 0 {
            return CGSize(width: itemWidth, height: 0)
        }
        
        return CGSize(width: itemWidth, height: 30)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        let itemWidth = collectionView.bounds.width
        
        if section == 0 {
            return CGSize(width: itemWidth, height: 0)
        }
        
        return CGSize(width: itemWidth, height: 30)
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        //print("offesetY : \(offsetY) | contentHeight: \(contentHeight)")
        
        if offsetY > contentHeight - scrollView.frame.height {
            print("load more data...................")
            loadMoreData(page: 1)
        }
    }
}

extension HomeViewController : UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        // add the code here to perform action on the cell
    }
}

extension HomeViewController : UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if indexPath.section == 0 {
            let itemWidth = collectionView.bounds.width
            return CGSize(width: itemWidth, height: 150)
        }
        
        //calculate item size
        let itemWidth = collectionView.bounds.width
        let numberOfItemPerRow: CGFloat = 2
        let spacing:CGFloat = flowLayout.minimumInteritemSpacing
        let availableWidth = itemWidth - spacing * (numberOfItemPerRow + 1)
        let itemDimension = floor(availableWidth/numberOfItemPerRow)
        
        return CGSize(width: itemDimension, height: itemDimension + 50)
    }
}
