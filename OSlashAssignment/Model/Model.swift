//
//  Model.swift
//  OSlashAssignment
//
//  Created by SIMON on 19/11/22.
//

import Foundation
import UIKit
protocol ModelDelegate : NSObject
{
    func reloadView()
}
class Model
{
    let requestHandler = URLRequestHandler()
    var photosList : [PhotosType] = []
    var fetchCycleLimit = 2
    var fetchCycleCurrent = 0
    weak var presenterDelegate : ModelDelegate?
    
    init()
    {
        self.getRandomPhotos()
    }
    deinit
    {
        
    }
    func reloadView()
    {
        presenterDelegate?.reloadView()
    }
    func getRandomPhotos()
    {
        if fetchCycleCurrent <= fetchCycleLimit{
            let randomWidth = Int.random(in: 2..<10)
            let randomHeight = Int.random(in: 2..<10)
            self.requestHandler.makeServerCall(urlString: "\(URLApiConstants.randomPhotoURL)\(randomWidth * 100)/\(randomHeight * 100)", completion: {(data,resp,success) in
                print("photo fetch resp recieved")
                if success{
                    DispatchQueue.main.async {
                        if self.fetchCycleCurrent <= self.fetchCycleLimit{
                            if let img = UIImage(data: data)
                            {
                                if !self.photosList.contains(where: {$0.data == data})
                                {
                                    print("photo added = ",self.photosList.count)
                                    self.photosList.append(PhotosType(photoId: UUID().uuidString, photo: img, thumbnail: self.resizeToThumbnail(image: img, targetSize: CGSize(width: 300, height: 300)) ?? img, url: resp.url?.absoluteString ?? "", data: data))
                                    self.fetchCycleCurrent = self.fetchCycleCurrent + 1
                                }
                                self.reloadView()
                                self.getRandomPhotos()
                            }
                        }
                    }

                }
                else{

                }
            })
        }

    }
    func resizeToThumbnail(image: UIImage, targetSize: CGSize) -> UIImage? {
        let size = image.size
        
        let widthRatio  = targetSize.width  / size.width
        let heightRatio = targetSize.height / size.height
        
        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio, height: size.height * widthRatio)
        }
        
        let rect = CGRect(origin: .zero, size: newSize)
        
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }
}
