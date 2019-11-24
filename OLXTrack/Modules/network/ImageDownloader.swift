//
//  ImageDownloader.swift
//  OLXTrack
//
//  Created by abuzeid on 11/21/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import UIKit
typealias DownloadImageCompletion = ((UIImage?, Bool) -> Void)
protocol ImageDownloaderType {
    func downloadImageWith(url: URL, placeholder: UIImage?, imageView: UIImageView, completion: DownloadImageCompletion?) -> Disposable
}

public protocol Disposable {
    func dispose()
}

extension URLSessionDataTask: Disposable {
    public func dispose() {
        cancel()
    }
}

// TODO: Add Image Local Caching
public final class ImageDownloader: ImageDownloaderType {
    func downloadImageWith(url: URL, placeholder: UIImage?, imageView: UIImageView, completion: DownloadImageCompletion? = nil) -> Disposable {
        imageView.image = placeholder
        let dataTask = URLSession.shared.dataTask(with: url) { [weak imageView] data, _, _ in
            guard let imageView = imageView else { return }
            if let data = data,
                let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    imageView.image = image
                }
                completion?(image, true)
            }
            completion?(nil, false)
        }
        dataTask.resume()
        return dataTask
    }
}
