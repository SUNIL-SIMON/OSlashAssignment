//
//  PhotosCollectionView.swift
//  OSlashAssignment
//
//  Created by SIMON on 19/11/22.
//

import Foundation
import UIKit
protocol PhotosCollectionViewDelegate : NSObject
{
    func getPhotosList()->[PhotosType]
    func getMorePhotos()
    func openExpandedView(photo : PhotosType)
}
class PhotosCollectionView : UICollectionView,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource,UICollectionViewDelegate,PhotosFlowLayoutDelegate
{
    
    let collectionViewLayout1 = PhotosFlowLayout()
    var photosList : [PhotosType] = []
    weak var presenterDelegate : PhotosCollectionViewDelegate?
    
    init()
    {
        
        super.init(frame: .zero, collectionViewLayout: collectionViewLayout1)
        print("Class PhotosView init/deinit +")
        collectionViewLayout1.delegate = self
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit
    {
        print("Class PhotosView init/deinit -")
    }
    
    func setupViews()
    {
        
        backgroundColor = .white
        
        
        
        self.register(PhotosCollectionVewCell.self, forCellWithReuseIdentifier: "DEFAULT")
        self.alwaysBounceVertical = true
        self.showsHorizontalScrollIndicator = false
        self.delegate = self
        self.dataSource = self
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return photosList.count + 1
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            var cell = self.dequeueReusableCell(withReuseIdentifier: "DEFAULT", for: indexPath) as! PhotosCollectionVewCell?
        if cell == nil
        {
            cell = PhotosCollectionVewCell.init(frame: .zero)
        }
        if indexPath.row == photosList.count
        {
            cell?.label.text = ""
            cell?.photoImageView.image = nil
            presenterDelegate?.getMorePhotos()
        }
        else if photosList.count - indexPath.row == 10
        {
            cell?.label.text = "Image count : \(indexPath.row)"
            cell?.photoImageView.image = photosList[indexPath.row].thumbnail
            presenterDelegate?.getMorePhotos()
        }
        else{
            cell?.label.text = "Image count : \(indexPath.row)"
            cell?.photoImageView.image = photosList[indexPath.row].thumbnail
        }
        return cell!
    }
    func collectionView(_ collectionView: UICollectionView, heightForItemAt indexPath: IndexPath, with width: CGFloat) -> CGFloat {
        if indexPath.row == photosList.count
        {
            return 0
        }
        else{
            return collectionViewLayout1.getPerspectiveSize(image: photosList[indexPath.row].thumbnail)
        }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenterDelegate?.openExpandedView(photo: photosList[indexPath.row])
    }
    override func reloadData()
    {
        photosList = presenterDelegate?.getPhotosList() ?? []
        collectionViewLayout1.cachedAttributes.removeAll()
        super.reloadData()
    }
    
    
}


