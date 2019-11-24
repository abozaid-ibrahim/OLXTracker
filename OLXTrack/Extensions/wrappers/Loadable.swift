//
//  Loadable.swift
//  PersonalityTest
//
//  Created by abuzeid on 11/10/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import Foundation
import UIKit
///
protocol Loadable {
    func showLoading(show: Bool)
}

extension Loadable where Self: UIViewController {
    /// show or hide the activity loader
    /// - Parameter show: to decide to show or hide the activity indicator
    func showLoading(show: Bool) {
        if show {
            showLoading()
        } else {
            hideLoading()
        }
    }

    /// create an activity indicator and add it to my view and start animating
    private func showLoading() {
        let activityView = UIActivityIndicatorView(style: .gray)
        activityView.center = view.center
        activityView.hidesWhenStopped = true
        view.addSubview(activityView)
        activityView.startAnimating()
    }

    /// stop animation the indicator view and remove it from the parent view
    private func hideLoading() {
        guard let firstView = self.view.subviews.filter({ type(of: $0) == UIActivityIndicatorView.self }).first,
            let progress = firstView as? UIActivityIndicatorView else { return }
        progress.stopAnimating()
        progress.removeFromSuperview()
    }
}
