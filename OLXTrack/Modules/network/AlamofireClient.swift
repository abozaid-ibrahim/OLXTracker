//
//  AlamofireClient.swift
//  OLXTrack
//
//  Created by abuzeid on 11/19/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

//import Foundation
//import Alamofire
//
///// api handler, wrapper for the Url session
//final class AlamofireClient: ApiClient {
//    private let disposeBag = DisposeBag()
//    func getData<T: Decodable>(of request: RequestBuilder) -> Observable<T?> {
//        log(.info, (String(describing: request.task.url)))
//        return excute(request).map { $0?.toModel() }.filterNil()
//    }
//
//    /// fire the http request and return observable of the data or emit an error
//    /// - Parameter request: the request that have all the details that need to call the remote api
//    private func excute(_ request: RequestBuilder) -> Observable<Data?> {
//        return RxAlamofire.requestData(request.task).map{$0.1}
//   
//    }
//}
