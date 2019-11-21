//
//  UIView+Constrains.swift
//  OLXTrack
//
//  Created by abuzeid on 11/20/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    /// set the constrains of subview to it's parent view
    /// - Parameter insets: the margin needed between the view and i'ts subview
    func equalToSuperViewEdges(insets: UIEdgeInsets = .zero) {
        guard let parent = self.superview else {
            return
        }
        translatesAutoresizingMaskIntoConstraints = false
        leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant: insets.left).isActive = true
        trailingAnchor.constraint(equalTo: parent.trailingAnchor, constant: insets.right).isActive = true
        topAnchor.constraint(equalTo: parent.topAnchor, constant: insets.top).isActive = true
        bottomAnchor.constraint(equalTo: parent.bottomAnchor, constant: insets.bottom).isActive = true
    }
}
