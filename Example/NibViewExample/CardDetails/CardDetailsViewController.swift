//
//  CardDetailsViewController.swift
//  NibView
//
//  Created by Domas on 11/02/2017.
//  Copyright © 2017 Trafi. All rights reserved.
//

import NibView

class CardDetailsViewController: UIViewController, NibViewController {
    typealias ViewType = CardDetailsView
    
    func setup(with cardView: CardView) {
        ui.nameLabel.text = cardView.name
        ui.professionLabel.text = cardView.profession
        ui.imageView.image = cardView.image
    }
    
    @IBAction private func dismissAnimated() {
        dismiss(animated: true, completion: nil)
    }
}
