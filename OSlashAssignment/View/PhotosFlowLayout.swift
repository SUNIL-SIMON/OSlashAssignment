//
//  PhotosFlowLayout.swift
//  OSlashAssignment
//
//  Created by SIMON on 19/11/22.
//

import Foundation
import UIKit
protocol PhotosFlowLayoutDelegate : NSObject{
    
    func collectionView(_ collectionView: UICollectionView, heightForItemAt indexPath: IndexPath, with width: CGFloat) -> CGFloat
}

public class PhotosFlowLayout: UICollectionViewLayout {
    
    weak var delegate : PhotosFlowLayoutDelegate?
   
    public var numberOfColumns = 2
    
    var cachedAttributes = [UICollectionViewLayoutAttributes]()
    
    private var contentHeight: CGFloat = 0.0
    private var contentWidth: CGFloat {
        return collectionView!.bounds.width
    }
    
    override public var collectionViewContentSize: CGSize {
        return CGSize(width: contentWidth, height: contentHeight)
    }
    
    override public func prepare() {
        if cachedAttributes.isEmpty && delegate != nil{
            let columnWidth = contentWidth / CGFloat(numberOfColumns)
            var xOffset = [CGFloat]()
            for column in 0 ..< numberOfColumns {
                xOffset.append(CGFloat(column) * columnWidth )
            }
            var yOffset = [CGFloat](repeating: 0, count: numberOfColumns)
            var col = 0
            for item in 0 ..< collectionView!.numberOfItems(inSection: 0) {
                
                let indexPath = IndexPath(item: item, section: 0)
                
                let width = columnWidth
                
                let cardHeight = delegate!.collectionView(collectionView!, heightForItemAt: indexPath, with: width)
                let height = cardHeight
                
                let nextCol = col >= (numberOfColumns - 1) ? 0 : col+1
                if  yOffset[col] - yOffset[nextCol] > (height / 2) && item > 0
                {
                    col = col >= (numberOfColumns - 1) ? 0 : col+1
                }
                let frame = CGRect(x: xOffset[col], y: yOffset[col], width: columnWidth, height: height)
                
                
                let insetFrame = frame//.insetBy(dx: cellPadding, dy: cellPadding)
                
                let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
                attributes.frame = insetFrame
                cachedAttributes.append(attributes)
                
                contentHeight = max(contentHeight, frame.maxY)
                yOffset[col] = yOffset[col] + height
                
                col = col >= (numberOfColumns - 1) ? 0 : col+1
            }
        }
        else{
        }
    }
    
    override public func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var layoutAttributes = [UICollectionViewLayoutAttributes]()
        for attributes in cachedAttributes {
            if attributes.frame.intersects(rect) {
                layoutAttributes.append(attributes)
            }
        }
        return layoutAttributes
    }
    func getPerspectiveSize(image: UIImage)->CGFloat
    {
        let widthRatio  = ((contentWidth / CGFloat(numberOfColumns)) - 20)  / image.size.width
        let height = image.size.height * widthRatio
        return height + 20
    }
}
