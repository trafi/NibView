//
//  NibLoadable.swift
//  NibLoadable
//
//  Created by Domas on 10/02/2017.
//  Copyright © 2016 Trafi. All rights reserved.
//

import UIKit

/**
 `NibLoadable` helps you reuse views created in .xib files.
 
 # Reference only from code
 Setup class by conforming to `NibLoadable`:
 
     class MyView: UIView, NibLoadable {}
 
 Get the view loaded from nib with a one-liner:
 
     let myView = MyView.fromNib()
 
 Setup like this will look for a file named "MyView.xib" in your project and load the view that is of type `MyView`.
 
 *Optionally* provide custom nib name (defaults to type name):
 
     class var nibName: String { return "MyCustomView" }
 
 # Refencing from IB
 
 To reference view from another .xib or .storyboard file simply subclass `NibView`:
 
     class MyView: NibView {}
 
 If subclassing is **not an option** override `awakeAfter(using:)` with a call to `nibLoader`:
 
     class MyView: SomeBaseView, NibLoadable {
         open override func awakeAfter(using aDecoder: NSCoder) -> Any? {
             return nibLoader.awakeAfter(using: aDecoder,
                                         super.awakeAfter(using: aDecoder))
         }
     }
 
 # @IBDesignable referencing from IB
 
 To see live updates and get intrinsic content size of view reference simply subclass `NibView` with `@IBDesignable` attribute:
 
     @IBDesignable
     class MyView: NibView {}
 
 If subclassing is **not an option** override functions of the view with calls to `nibLoader`:
 
     @IBDesignable
     class MyView: SomeBaseView, NibLoadable {
         
         open override func awakeAfter(using aDecoder: NSCoder) -> Any? {
             return nibLoader.awakeAfter(using: aDecoder, super.awakeAfter(using: aDecoder))
         }
         
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
 
 */
public protocol NibLoadable: class {
    static var nibName: String { get }
}

// MARK: - From Nib

public extension NibLoadable where Self: UIView {
    
    static var nibName: String {
         return String(describing: self)
    }
    
    static func fromNib() -> Self {
        guard let nib = Bundle(for: self).loadNibNamed(nibName, owner: nil, options: nil) else {
            fatalError("Failed loading the nib named \(nibName) for 'NibLoadable' view of type '\(self)'.")
        }
        guard let view = (nib.first { $0 is Self }) as? Self else {
            fatalError("Did not find 'NibLoadable' view of type '\(self)' inside '\(nibName).xib'.")
        }
        return view
    }
}

