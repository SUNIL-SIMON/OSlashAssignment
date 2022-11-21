//
//  PhotosCollectionVewCell.swift
//  OSlashAssignment
//
//  Created by SIMON on 19/11/22.
//

import Foundation
import UIKit
class PhotosCollectionVewCell : UICollectionViewCell
{
    var photoImageView = UIImageView()
    var label = UILabel()
    override init(frame: CGRect) {
        super.init(frame: frame)
        print("Class CrewCollectionViewCell init/deinit +")
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit
    {
        print("Class CrewCollectionViewCell init/deinit -")
    }
    func setupViews()
    {
        self.contentView.addSubview(photoImageView)
        photoImageView.contentMode = .scaleAspectFit
        photoImageView.layer.cornerRadius = 10
        photoImageView.layer.masksToBounds = true
        
        self.contentView.addSubview(label)
        label.font = UIFont.systemFont(ofSize: 10)
        label.textAlignment = .left
        label.textColor = .systemBlue
    }
    override func layoutSubviews() {
        photoImageView.frame = CGRect(x: 10, y: 10, width: self.contentView.frame.size.width - 20, height:  self.contentView.frame.size.height - 20)
        label.frame = CGRect(x: 15, y: self.contentView.frame.size.height - 10, width: self.contentView.frame.size.width - 30, height:  20)
    }

    
}
