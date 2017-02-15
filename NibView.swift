//
//  NibView.swift
//  NibView
//
//  Created by Domas on 10/02/2017.
//  Copyright © 2016 Trafi. All rights reserved.
//

import UIKit

open class NibView: UIView, NibLoadable {
    
    open class var nibName: String {
        return String(describing: self)
    }
    
    open override func awakeAfter(using aDecoder: NSCoder) -> Any? {
        return nibLoader.awakeAfter(using: aDecoder, super.awakeAfter(using: aDecoder))
    }
    
    // MARK: - Interface builder
    
    #if TARGET_INTERFACE_BUILDER
    
        public override init(frame: CGRect) {
            super.init(frame: frame)
            nibLoader.initWithFrame()
        }
        
        public required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
        }
        
        open override func prepareForInterfaceBuilder() {
            super.prepareForInterfaceBuilder()
            nibLoader.prepareForInterfaceBuilder()
        }
        
        open override func setValue(_ value: Any?, forKeyPath keyPath: String) {
            super.setValue(value, forKeyPath: keyPath)
            nibLoader.setValue(value, forKeyPath: keyPath)
        }

    #endif
}
