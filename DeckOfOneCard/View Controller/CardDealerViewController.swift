//
//  CardDealerViewController.swift
//  DeckOfOneCard
//
//  Created by Haley Jones on 5/21/19.
//  Copyright © 2019 HaleyJones. All rights reserved.
//

import UIKit

class CardDealerViewController: UIViewController {

    @IBOutlet weak var cardImageView: UIImageView!
    @IBOutlet weak var suitLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    //just have this here
    var deckID: String?
    
    fileprivate func fetchCardAndUpdateViews() {
        DispatchQueue.main.async {
            self.activityIndicator.alpha = 1
            self.activityIndicator.startAnimating()
        }
        guard let deckID = self.deckID else {return}
        HAJCardController.fetchCard(fromDeck: deckID, completion: { (card) in
            guard let card = card else {return}
            HAJCardController.fetchImage(for: card, completion: { (cardImage) in
                DispatchQueue.main.async {
                    self.cardImageView.image = cardImage
                    self.suitLabel.text = "Suit: \(card.suit)"
                    self.valueLabel.text = "Value: \(card.value)"
                    self.activityIndicator.stopAnimating()
                    self.activityIndicator.alpha = 0
                }
            })
        })
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        HAJCardController.getDeckID("https://deckofcardsapi.com/api/deck/new/shuffle/?deck_count=1") { (fetchedDeckID) in
            self.deckID = fetchedDeckID
            self.fetchCardAndUpdateViews()
        }
        // Do any additional setup after loading the view.
    }
    
    @IBAction func hitButtonTapped(_ sender: Any) {
        fetchCardAndUpdateViews()
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
