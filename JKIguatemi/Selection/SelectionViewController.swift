//
//  SelectionViewController.swift
//  JKIguatemi
//
//  Created by Jean Paul Marinho on 23/09/18.
//  Copyright © 2018 aKANJ. All rights reserved.
//

import UIKit
import TisprCardStack

class SelectionViewController: CardStackViewController {

    private struct Constants {
        static let animationSpeed: Float = 0.86
        static let padding: CGFloat = 20.0
        static let kHeight: CGFloat = 0.67
        static let topStackVisibleCardCount = 40
        static let bottomStackVisibleCardCount = 30
        static let bottomStackCardHeight: CGFloat = 45.0
        static let colors = [UIColor(red: 214.0/255.0, green: 169.0/255.0, blue: 64.0/255.0, alpha: 1.0),
                             UIColor(red: 234.0/255.0, green: 189.0/255.0, blue: 84.0/255.0, alpha: 1.0),
                             UIColor(red: 194.0/255.0, green: 149.0/255.0, blue: 44.0/255.0, alpha: 1.0),
                             UIColor(red: 214.0/255.0, green: 169.0/255.0, blue: 64.0/255.0, alpha: 1.0),
                             UIColor(red: 234.0/255.0, green: 189.0/255.0, blue: 84.0/255.0, alpha: 1.0),
                             UIColor(red: 194.0/255.0, green: 149.0/255.0, blue: 44.0/255.0, alpha: 1.0)]
        
    }
    
    fileprivate var countOfCards: Int = 6
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //set size of cards
        let size = CGSize(width: view.bounds.width - 2 * Constants.padding, height: Constants.kHeight * view.bounds.height)
        setCardSize(size)
        
        delegate = self
        datasource = self
        layout.topStackMaximumSize = Constants.topStackVisibleCardCount
        layout.bottomStackMaximumSize = Constants.bottomStackVisibleCardCount
        layout.bottomStackCardHeight = Constants.bottomStackCardHeight
    }
    
    func addCard() {
        countOfCards += 1
        newCardAdded()
    }
}

extension SelectionViewController : CardStackDatasource {
    func numberOfCards(in cardStack: CardStackView) -> Int {
        return countOfCards
    }
    
    func card(_ cardStack: CardStackView, cardForItemAtIndex index: IndexPath) -> CardStackViewCell {
        let cell = cardStack.dequeueReusableCell(withReuseIdentifier: "cell", for: index) as! SelectionCell
        cell.imageView.image = UIImage(named: "ad\(Int.random(in: 1...4))")
        cell.backgroundColor = Constants.colors[index.item % Constants.colors.count]
        return cell
    }
    
}

extension SelectionViewController: CardStackDelegate {
    
    func cardDidChangeState(_ cardIndex: Int) {
        print(cardIndex)
    }
}