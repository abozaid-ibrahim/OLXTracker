//
//  ViewController.swift
//  OLXTrack
//
//  Created by abuzeid on 11/19/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import UIKit
class ViewController: UIViewController {

   
    let network = HTTPClient()
    override func viewDidLoad() {
        super.viewDidLoad()
        let obj: Observable<CategoryModel?> =  network.getData(of: CategoriesApi.cats(key: "", manufacturer: "", page: 0, pageSize: 12))
        
        
        log(.info,obj)
    }
    

}

