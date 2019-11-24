//
//  Observable.swift
//  OLXTrack
//
//  Created by abuzeid on 11/19/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import Foundation
/// An Observable will give  any  subscriber  the most  recent element
/// and  everything that  is  emitted  by that  sequence after the  subscription  happened.
class MObservable<T> {
    private var observers = [UUID: (T?) -> Void]()
    private var _value: T? {
        didSet {
            observers.values.forEach { $0(_value) }
        }
    }

    var value: T? {
        return _value
    }

    init(_ value: T?) {
        _value = value
    }

    init() {
        // nothing todo
    }

    func subscribe(_ observer: @escaping ((T?) -> Void)) {
        observers[UUID()] = observer
        observer(value)
    }

    func next(_ newValue: T) {
        _value = newValue
    }
}
