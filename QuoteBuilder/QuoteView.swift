//
//  QuoteView.swift
//  QuoteBuilder
//
//  Created by Dayson Dong on 2019-06-12.
//  Copyright © 2019 Dayson Dong. All rights reserved.
//

import UIKit

class QuoteView: UIView {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var quoteLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    var quote: String? {
        
        didSet{
            if self.quote != nil {
                quoteLabel.text = self.quote
            }
        }
    }
    
    var name: String? {
        didSet{
            if self.name != nil {
                nameLabel.text = self.name
            }
        }
    }
    
    var image: UIImage? {
        didSet{
            if self.image != nil {
                imageView.image = self.image
            }
        }
        
    }

    
}
