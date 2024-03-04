//
//  BannerViewCell.swift
//  DynamicHome
//
//  Created by Ranjit Mahto on 02/02/24.
//

import UIKit

class BannerViewCell: UICollectionViewCell {
    
    @IBOutlet weak var viewBg: UIView!
    var timer = Timer()
    var counter = 0

    var bannerViewModels:[BannerViewModal] = []
    
    private var collectionView: UICollectionView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setUpCollectionView()
        setUpTimer()
    }

    private func setUpCollectionView() {
        
        let flowLayout: UICollectionViewFlowLayout = {
            let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = .horizontal
            layout.minimumInteritemSpacing = 0
            layout.minimumLineSpacing = 0
            layout.sectionInset = UIEdgeInsets(top:0.0, left: 0.0, bottom: 0.0, right: 0.0)
            layout.estimatedItemSize = .zero
            return layout
        }()
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        
        let scrollCellNib = UINib(nibName: "ScrollableViewCell", bundle: nil)
        collectionView.register(scrollCellNib, forCellWithReuseIdentifier:"ScrollableCell")
        
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.backgroundColor = UIColor.green
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        viewBg.addSubview(collectionView)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: viewBg.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: viewBg.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: viewBg.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: viewBg.bottomAnchor)
        ])
        
        collectionView.reloadData()
    }
    
    func setUpTimer(){
        DispatchQueue.main.async {
            self.timer = Timer.scheduledTimer(withTimeInterval: 2.0, repeats: true) { timer in
                //self.collectionView?.reloadData()
                self.changeBannerImage()
            }
        }
    }
    
    @objc func changeBannerImage() {
        if counter < bannerViewModels.count {
            let index = IndexPath(item: counter, section: 0)
            self.collectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
            counter += 1
        }else {
            counter = 0
            let index = IndexPath(item: counter, section: 0)
            self.collectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
        }
    }
}

extension BannerViewCell : UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return bannerViewModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier:"ScrollableCell", for: indexPath) as! ScrollableViewCell
        //cell.imgView.backgroundColor = UIColor.random
        cell.scrollBannerVM = bannerViewModels[indexPath.row]
        return cell
    }
    
}

extension BannerViewCell : UICollectionViewDelegate {
    
}

extension BannerViewCell : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let itemWidth = collectionView.bounds.width
        return CGSize(width: itemWidth, height: 150)
    }
    
    func getImageHeightFromPreImageSize(imageWidth:String, imageHeight:String) -> CGFloat{
        
        //convert str to CGfloat
        let strImgWidth = imageWidth
        guard let floatWidth = NumberFormatter().number(from: strImgWidth) else { return 0}
        
        let strImgHeight = imageHeight
        guard let floatHeight = NumberFormatter().number(from: strImgHeight) else { return 0}
        
        let flWidth = CGFloat(truncating: floatWidth)
        let flHeight = CGFloat(truncating: floatHeight)
        let aspectRatio = flHeight/flWidth
        let imageHeight = UIScreen.main.bounds.width * aspectRatio
        
        print(imageHeight)
        
        return imageHeight
    }
}



