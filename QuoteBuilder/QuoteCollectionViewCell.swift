//
//  QuoteCollectionViewCell.swift
//  QuoteBuilder
//
//  Created by Dayson Dong on 2019-06-12.
//  Copyright © 2019 Dayson Dong. All rights reserved.
//

import UIKit

class QuoteCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var quoteLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    var quote:Quote? {
        
        didSet {
            if let newQuote = quote {
                quoteLabel.text = newQuote.quote
                nameLabel.text = newQuote.name
                imageView.image = newQuote.photo
            }
        }
    }
    

    
}
