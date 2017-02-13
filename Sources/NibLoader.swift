//
//  NibLoader.swift
//  NibLoader
//
//  Created by Domas on 10/02/2017.
//  Copyright © 2016 Trafi. All rights reserved.
//

// MARK: - Public

public extension NibLoadable where Self: UIView {
    var nibLoader: IBNibLoader<Self> { return IBNibLoader(self) }
}

public struct IBNibLoader<NibLoadableView: NibLoadable> where NibLoadableView: UIView {
    
    public func awakeAfter(using aDecoder: NSCoder, _ superMethod: @autoclosure () -> Any?) -> Any? {
        guard nonPrivateSubviews.isEmpty else { return superMethod() }
        
        let nibView = type(of: view).fromNib()
        copyProperties(to: nibView)
        
        return nibView
    }
    
    public func initWithFrame() {
        #if TARGET_INTERFACE_BUILDER
            let nibView = type(of: view).fromNib()
            copyProperties(to: nibView)
            SubviewsCopier.copySubviewReferences(from: nibView, to: view)
            
            nibView.frame = view.bounds
            nibView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            view.addSubview(nibView)
        #endif
    }
    
    public func prepareForInterfaceBuilder() {
        if nonPrivateSubviews.count == 1 {
            // Used as a reference container
            view.backgroundColor = .clear
        } else {
            // Is original .xib file
            nonPrivateSubviews.first?.removeFromSuperview()
        }
    }
    
    public func setValue(_ value: Any?, forKeyPath keyPath: String) {
        #if TARGET_INTERFACE_BUILDER
            guard let subview = value as? UIView else { return }
            SubviewsCopier.store(subview: subview, forKeyPath: keyPath, of: view)
        #endif
    }
    
    
    // MARK: - Private
    
    private let view: NibLoadableView
    fileprivate init(_ view: NibLoadableView) {
        self.view = view
    }
    
    private var nonPrivateSubviews: [UIView] {
        return view.subviews.filter { !String(describing: type(of: $0)).hasPrefix("_") }
    }
    
    private func copyProperties(to nibView: UIView) {
        nibView.frame = view.frame
        nibView.autoresizingMask = view.autoresizingMask
        nibView.translatesAutoresizingMaskIntoConstraints = view.translatesAutoresizingMaskIntoConstraints
        nibView.clipsToBounds = view.clipsToBounds
        nibView.alpha = view.alpha
        nibView.isHidden = view.isHidden
    }
    
}

#if TARGET_INTERFACE_BUILDER
    fileprivate struct SubviewsCopier {
        
        static var viewKeyPathsForSubviews = [UIView: [String: UIView]]()
        
        static func store(subview: UIView, forKeyPath keyPath: String, of view: UIView) {
            if viewKeyPathsForSubviews[view] == nil {
                viewKeyPathsForSubviews[view] = [keyPath: subview]
            } else {
                viewKeyPathsForSubviews[view]?[keyPath] = subview
            }
        }
        
        static func copySubviewReferences(from view: UIView, to otherView: UIView) {
            viewKeyPathsForSubviews[view]?.forEach { otherView.setValue($0.value, forKeyPath: $0.key) }
            viewKeyPathsForSubviews[view] = nil
        }
    }
#endif
