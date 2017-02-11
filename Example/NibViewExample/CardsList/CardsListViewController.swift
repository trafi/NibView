//
//  CardsListViewController.swift
//  NibView
//
//  Created by Domas on 10/02/2017.
//  Copyright © 2017 Trafi. All rights reserved.
//

import UIKit

final class CardsListViewController: UIViewController {
    
    @IBAction private func cardTapped(_ gesture: UITapGestureRecognizer) {
        performSegue(withIdentifier: "ShowDetails", sender: gesture.view)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        guard let details = segue.destination as? CardDetailsViewController, let cardView = sender as? CardView else { return }
        details.setup(with: cardView)
    }
    
}
