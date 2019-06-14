//
//  QuoteBuilderViewController.swift
//  QuoteBuilder
//
//  Created by Dayson Dong on 2019-06-12.
//  Copyright © 2019 Dayson Dong. All rights reserved.
//

import UIKit

protocol SaveQuoteDelegation: AnyObject {
    func saveQuote(quote: Quote)
}

class QuoteBuilderViewController: UIViewController {
    
    @IBOutlet weak var quoteView: QuoteView!
    weak var saveQuoteDelegate: SaveQuoteDelegation?
    
    private var networker = Networker()
    private var quoteText: String!
    private var name: String!
    private var photo: UIImage!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    
    @IBAction func newImage(_ sender: UIButton) {
        
        
        networker.getImage { (url) -> (Void) in
            
            guard let imageData = try? Data(contentsOf: url) else {
                print("can not get data from url")
                return
            }
            
            guard let image = UIImage.init(data: imageData) else {
                print("fail to make image from data")
                return
            }
            
            DispatchQueue.main.async {
                self.photo = image
                self.quoteView.image = image
            }
            
        }
    }
    
    @IBAction func newQuote(_ sender: UIButton) {
        
        networker.getQuote { (data) -> (Void) in
            
            //            print(String(data: data, encoding: .utf8))
            guard let json = try? JSONSerialization.jsonObject(with: data, options: []) else {
                print("Can not parse data into json")
                return
            }
            
            guard let result = json as? Dictionary<String, String> else {
                print("Can not json into dictionary")
                return
            }
            let name = result["quoteAuthor"]! as String
            let quote = result["quoteText"]! as  String
            
            DispatchQueue.main.async {
                self.quoteText = quote
                self.name = name
                self.quoteView.quote = quote
                self.quoteView.name = name
                
            }
        }
    }
    
    
    @IBAction func saveQuote(_ sender: UIButton) {
        
        guard let name = name else {
            print("Can't find quote author!")
            return
        }
        
        guard let quoteText = quoteText else {
            print("Can't find quote")
            return
        }
        
        guard let photo = photo else {
            print("Can't find quote author!")
            return
        }
        
        
        let quote = Quote(quoteText, by: name, withPhoto: photo)
        saveQuoteDelegate?.saveQuote(quote: quote)
        
        dismiss(animated: true, completion: nil)
    }
    
    
}

