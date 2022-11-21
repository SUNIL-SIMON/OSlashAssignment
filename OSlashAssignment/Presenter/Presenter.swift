//
//  Presenter.swift
//  OSlashAssignment
//
//  Created by SIMON on 19/11/22.
//

import Foundation
import UIKit
class Presenter : UIViewController, ModelDelegate, PhotosCollectionViewDelegate, PhotosExpandedViewDelegate{

    let photosView = PhotosCollectionView()
    let photoExpandedView = PhotosExpandedView()
    let model = Model()
    init()
    {
        super.init(nibName: nil, bundle: nil)
        print("Class Presenter init/deinit +")
        self.view .backgroundColor = .red
        self.view = photosView
        model.presenterDelegate = self
        photosView.presenterDelegate = self
        
        let titleView = UIView()
        let titleLabel = UILabel()
        let descriptionLabel = UILabel()
        titleView.addSubview(titleLabel)
        titleLabel.text = "Photos App"
        titleLabel.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        titleLabel.frame = CGRect(x: 0, y: 0, width: 400, height: 20)
        titleLabel.textColor = .systemBlue
//        titleLabel.textAlignment = .center
        titleView.addSubview(descriptionLabel)
        descriptionLabel.text = "Image will download as you scroll, there is no limit"
        descriptionLabel.font = UIFont.systemFont(ofSize: 12, weight: .light)
        descriptionLabel.frame = CGRect(x: 0, y: 20, width: 400, height: 20)
        descriptionLabel.textColor = .systemBlue
//        descriptionLabel.textAlignment = .center
        titleView.frame.size =  CGSize(width: 400, height: 40)
//        titleView.backgroundColor = .red
        self.navigationItem.titleView = titleView
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit
    {
        print("Class Presenter init/deinit -")
    }
    func reloadView() {
        photosView.reloadData()
    }
    func getPhotosList() -> [PhotosType] {
        return model.photosList
    }
    func getMorePhotos()
    {
        self.model.fetchCycleCurrent = 0
        self.model.getRandomPhotos()
    }
    func openExpandedView(photo : PhotosType)
    {
        let viewController = UIViewController()
        photoExpandedView.imageView.image = photo.photo
        photoExpandedView.presenterDelegate = self
        viewController.modalPresentationStyle = .fullScreen
        viewController.view = photoExpandedView
        self.navigationController?.present(viewController, animated: true)
    }
    func closeExpandedView() {
        self.navigationController?.dismiss(animated: true)
    }
}
