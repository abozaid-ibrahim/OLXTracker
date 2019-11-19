//
//  APIClient.swift
//  OLXTrack
//
//  Created by abuzeid on 11/19/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//
import Foundation
protocol ApiClient {
    func getData<T: Decodable>(of request: RequestBuilder) -> Observable<T?>
}

/// api handler, wrapper for the Url session
final class HTTPClient: ApiClient {
    func getData<T: Decodable>(of request: RequestBuilder) -> Observable<T?> {
        log(.info, String(describing: request.task.url))
        let x: T? = excute(request).value.map { $0.toModel() } ?? nil
        let obs = Observable<T?>(nil)
        obs.next(x)
        return obs
    }
    
    /// fire the http request and return observable of the data or emit an error
    /// - Parameter request: the request that have all the details that need to call the remote api
    private func excute(_ request: RequestBuilder) -> Observable<Data?> {
        let obs = Observable<Data?>(nil)
        let task = URLSession.shared.dataTask(with: request.task) { data, response, error in
            if let error = error {
                //                    observer.onError(error)
                return
            }
            guard let httpResponse = response as? HTTPURLResponse,
                (200 ... 299).contains(httpResponse.statusCode) else {
                    //                    observer.onError(NetworkFailure.generalFailure)
                    return
            }
            log(.info,String(data: data!, encoding: .utf8) ?? "")
            obs.next(data)
        }
        task.resume()
        return obs
    }
}
