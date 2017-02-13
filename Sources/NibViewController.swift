//
//  NibViewController.swift
//  NibViewController
//
//  Created by Domas on 10/02/2017.
//  Copyright © 2016 Trafi. All rights reserved.
//

import UIKit

public protocol NibViewController {
    associatedtype ViewType: NibLoadable
}

public extension NibViewController where Self: UIViewController {
    var ui: ViewType {
        guard let ui = view as? ViewType else {
            fatalError("'\(type(of: self))' 'view' type did not match the 'ViewType' declared in conformance to 'NibViewController' protocol.Found \(type(of: view)) instead of expected '\(ViewType.self)'")
        }
        return ui
    }
}
