//
//  DynamicWidthCellLayout.swift
//  OLXTrack
//
//  Created by abuzeid on 11/22/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import Foundation
import UIKit

@objc enum CellWidthType: Int {
    case fillWidth
    case mostVisited
    case normal

    var widthFactor: CGFloat {
        switch self {
        case .fillWidth:
            return 1
        case .mostVisited:
            return 2 / 3
        case .normal:
            return 1 / 3
        }
    }
    var margin:CGFloat{
        switch self {
        case .fillWidth:
            return 0
        case .mostVisited:
            return 3
        case .normal:
            return 6//ends with 9
        }
    }
}

@objc protocol DynamicWidthCellLayoutDelegate: NSObjectProtocol {
    func collectionView(_ collectionView: UICollectionView, widthForItemAt indexPath: IndexPath) -> CellWidthType
}

class DynamicWidthCellLayout: UICollectionViewLayout {
    @IBOutlet weak var delegate: DynamicWidthCellLayoutDelegate?

    /// The calculated layout attributes
    private var layoutAttributes = [UICollectionViewLayoutAttributes]()

    /// The total height of the content
    private var contentHeight: CGFloat = 0
private let itemPadding = CGFloat(8)
    /// The total width of the content
    private var contentWidth: CGFloat {
        guard let collectionView = collectionView else {
            return 0
        }
        let insets = collectionView.contentInset
        return collectionView.bounds.width - (insets.left + insets.right)
    }

   
    private func cellSize(from widthType: CellWidthType) -> CGSize {
        let aspectRatio: CGFloat = UIDevice.current.userInterfaceIdiom == .pad ? 124 / 380 : 156 / 328
        return CGSize(width: (contentWidth * widthType.widthFactor) - widthType.margin,
                      height: contentWidth * 0.5 * aspectRatio)
    }

    /// The total size of the content
    override var collectionViewContentSize: CGSize {
        return CGSize(width: contentWidth, height: contentHeight)
    }

    override func prepare() {
        layoutAttributes.removeAll()
        contentHeight = 0
        guard let collectionView = collectionView,
            collectionView.numberOfSections >= 1,
            layoutAttributes.isEmpty else { return }
        // Keep a reference of the tile sizes
        // for each cell calucate the layout attributes of it
        for item in 0 ..< collectionView.numberOfItems(inSection: 0) {
            let indexPath = IndexPath(item: item, section: 0)
            // Caclulate the size of the cell at the specified index
            let widthType = delegate?.collectionView(collectionView, widthForItemAt: indexPath) ?? .fillWidth
            let cellSize = self.cellSize(from: widthType)
            // Calculate the origin of the cell at the specified index
            let originX: CGFloat
            let originY: CGFloat
            if item - 1 >= 0, layoutAttributes.count > item - 1 { // not zero and not next attribute
                let previousCellFrame = layoutAttributes[item - 1].frame
                if previousCellFrame.maxX + cellSize.width > contentWidth {
                    // new y line
//                    if previousCellFrame.maxY + cellSize.height > contentHeight {
                        originX = 0
                        originY = contentHeight + itemPadding
//                    } else {
//                        originX = 0
//                        originY = previousCellFrame.maxY + 8
//                    }
                } else {
                    originX = previousCellFrame.maxX  + itemPadding
                    originY = previousCellFrame.minY
                }
            } else {
                originX = 0
                originY = 0
            }
            let origin = CGPoint(x: originX, y: originY)
            // Calculate the frame of the cell at the specified index
            let frame = CGRect(origin: origin, size: cellSize)
            let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            attributes.frame = frame
            layoutAttributes.append(attributes)
            contentHeight = max(contentHeight, frame.maxY)
        }
    }

    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var visibleLayoutAttributes: [UICollectionViewLayoutAttributes] = []

        // Loop through the cache and look for items in the rect
        for attributes in layoutAttributes {
            if attributes.frame.intersects(rect) {
                visibleLayoutAttributes.append(attributes)
            }
        }
        return visibleLayoutAttributes
    }

    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        guard layoutAttributes.count > indexPath.item else { return nil }
        return layoutAttributes[indexPath.item]
    }
}
