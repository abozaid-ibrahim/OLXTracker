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
    case lastCell
    case mostVisited
    case normal

    var widthFactor: CGFloat {
        switch self {
        case .lastCell:
            return 1
        case .mostVisited:
            return 2 / 3
        case .normal:
            return 1 / 3
        }
    }

    var margin: CGFloat {
        switch self {
        case .lastCell:
            return 0
        case .mostVisited:
            return 3
        case .normal:
            return 6
        }
    }
}

@objc protocol DynamicWidthCellLayoutDelegate: NSObjectProtocol {
    func collectionView(_ collectionView: UICollectionView, widthForItemAt indexPath: IndexPath) -> CellWidthType
}

class DynamicWidthCellLayout: UICollectionViewLayout {
    @IBOutlet weak var delegate: DynamicWidthCellLayoutDelegate?
    private var layoutAttributes = [UICollectionViewLayoutAttributes]()

    private var contentHeight: CGFloat = 0
    private let itemPadding = CGFloat(8)
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

    override var collectionViewContentSize: CGSize {
        return CGSize(width: contentWidth, height: contentHeight)
    }

    override func prepare() {
        layoutAttributes.removeAll()
        contentHeight = 0
        guard let collectionView = collectionView,
            collectionView.numberOfSections >= 1,
            layoutAttributes.isEmpty else { return }
        for item in 0 ..< collectionView.numberOfItems(inSection: 0) {
            let indexPath = IndexPath(item: item, section: 0)
            let widthType = delegate?.collectionView(collectionView, widthForItemAt: indexPath) ?? .lastCell
            var cellSize = self.cellSize(from: widthType)

            /// Calculate the origin of the cell at the specified index
            let originX: CGFloat
            let originY: CGFloat
            if item - 1 >= 0, layoutAttributes.count > item - 1 {
                let previousCellFrame = layoutAttributes[item - 1].frame
                calculateLastCellWidth(type: widthType, prevCellMaxX: previousCellFrame.maxX, cellSize: &cellSize)
                if previousCellFrame.maxX + cellSize.width > contentWidth {
                    originX = 0
                    originY = contentHeight + itemPadding
                } else {
                    originX = previousCellFrame.maxX + itemPadding
                    originY = previousCellFrame.minY
                }
            } else {
                originX = 0
                originY = 0
            }
            let origin = CGPoint(x: originX, y: originY)
            /// Calculate the frame of the cell at the specified index
            let frame = CGRect(origin: origin, size: cellSize)
            let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            attributes.frame = frame
            layoutAttributes.append(attributes)
            contentHeight = max(contentHeight, frame.maxY)
        }
    }

    func calculateLastCellWidth(type: CellWidthType, prevCellMaxX: CGFloat, cellSize: inout CGSize) {
        if CellWidthType.lastCell == type {
            if prevCellMaxX + cellSize.width > contentWidth {
                let newW = contentWidth - prevCellMaxX
                if newW >= self.cellSize(from: .normal).width {
                    cellSize = CGSize(width: newW, height: cellSize.height)
                }
            }
        }
    }

    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var visibleLayoutAttributes: [UICollectionViewLayoutAttributes] = []

        /// Loop through the cache and look for items in the rect
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
