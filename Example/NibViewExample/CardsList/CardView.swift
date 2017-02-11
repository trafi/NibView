//
//  CardView.swift
//  NibView
//
//  Created by Domas on 10/02/2017.
//  Copyright © 2017 Trafi. All rights reserved.
//

import NibView

@IBDesignable
final class CardView: NibView {
    @IBOutlet private var nameLabel: UILabel!
    @IBOutlet private var professionLabel: UILabel!
    @IBOutlet private var imageView: UIImageView!
    
    @IBInspectable var name: String? {
        get { return nameLabel.text }
        set { nameLabel.text = newValue }
    }
    @IBInspectable var profession: String? {
        get { return professionLabel.text }
        set { professionLabel.text = newValue }
    }
    @IBInspectable var image: UIImage? {
        get { return imageView.image }
        set { imageView.image = newValue }
    }
}
