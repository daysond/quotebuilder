//
//  Quote.swift
//  QuoteBuilder
//
//  Created by Dayson Dong on 2019-06-12.
//  Copyright © 2019 Dayson Dong. All rights reserved.
//

import Foundation
import UIKit

class Quote {
    
    var quote: String
    var name: String
    var photo: UIImage?
    
    init(_ quote: String, by name: String, withPhoto photo: UIImage?) {
        self.quote = quote
        self.name = name
        self.photo = photo
    }
    
}
