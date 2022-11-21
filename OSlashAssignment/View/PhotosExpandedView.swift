//
//  PhotosExpandedView.swift
//  OSlashAssignment
//
//  Created by SIMON on 19/11/22.
//

import Foundation
import UIKit
protocol PhotosExpandedViewDelegate : NSObject
{
    func closeExpandedView()
}
class PhotosExpandedView : UIView{
    
    let closeButton = UIButton()
    var imageView = UIImageView()
    weak var presenterDelegate : PhotosExpandedViewDelegate?
    init()
    {
        super.init(frame: .zero)
        print("Class PhotoExpandedView init/deinit +")
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit
    {
        print("Class PhotoExpandedView init/deinit -")
    }
    func setupViews()
    {
        self.backgroundColor = .white
        
        self.addSubview(closeButton)
        closeButton.setImage(UIImage(systemName: "xmark.circle.fill"), for: .normal)
        closeButton.addTarget(self, action: #selector(closeThisView), for: .touchUpInside)
        
        self.addSubview(imageView)
        imageView.contentMode = .scaleAspectFit
        
        addLayoutConstraints()
    }
    func addLayoutConstraints()
    {
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        closeButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10).isActive = true
        closeButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 40).isActive = true
        closeButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        closeButton.widthAnchor.constraint(equalToConstant: 30).isActive = true
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10).isActive = true
        imageView.topAnchor.constraint(equalTo: closeButton.bottomAnchor, constant: 10).isActive = true
        imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
        imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10).isActive = true
    }
    @objc func closeThisView()
    {
        presenterDelegate?.closeExpandedView()
    }
}
