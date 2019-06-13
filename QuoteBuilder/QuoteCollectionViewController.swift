//
//  QuoteCollectionViewController.swift
//  QuoteBuilder
//
//  Created by Dayson Dong on 2019-06-12.
//  Copyright © 2019 Dayson Dong. All rights reserved.
//

import UIKit

class QuoteCollectionViewController: UIViewController {
    
    @IBOutlet weak var quoteCollectionView: UICollectionView!
    
    private var imageToShare: UIImage?
    private var quoteView = QuoteView()
    private var quotes: [Quote] = []
    private var flowLayout = UICollectionViewFlowLayout()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupFlowLayout()
    }
    
    //MARK: PRIVATE
    
    private func setupFlowLayout() {
        
        flowLayout = quoteCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        flowLayout.minimumInteritemSpacing = 20
        flowLayout.itemSize.width = self.view.frame.width
        flowLayout.itemSize.height = self.view.frame.width * (3.0/4.0)
        
    }
    
    private func shareQuote() {
        
        guard let image = imageToShare else {
            return
        }
        
        let avc = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        
        avc.excludedActivityTypes = [.addToReadingList,
                                     .assignToContact,
                                     .copyToPasteboard,
                                     .mail,
                                     .message,
                                     .openInIBooks,
                                     .print,
                                     .saveToCameraRoll,
                                     .postToWeibo,
                                     .copyToPasteboard,
                                     .saveToCameraRoll,
                                     .postToFlickr,
                                     .postToVimeo,
                                     .postToTencentWeibo,
                                     .markupAsPDF
]
        present(avc, animated: true, completion: nil)
    
    }
    
    func snapshot(view: UIView) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, true, 0)
        view.drawHierarchy(in: view.bounds, afterScreenUpdates: true)
        if let image = UIGraphicsGetImageFromCurrentImageContext() {
            UIGraphicsEndImageContext()
            return image
        }
        return nil
        
    }
    
    //MARK: NAVIGATION
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toBuild" {
            let dvc = segue.destination as! QuoteBuilderViewController
            dvc.saveQuoteDelegate = self
        }
    }
    

}


//MARK: CollectionViewSetUp

extension QuoteCollectionViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return quotes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! QuoteCollectionViewCell
        cell.quote = quotes[indexPath.item]
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        quoteView.image = quotes[indexPath.item].photo
        quoteView.name = quotes[indexPath.item].name
        quoteView.quote = quotes[indexPath.item].quote
        imageToShare = snapshot(view: quoteView)
        shareQuote()
    }
}

//MARK: SAVE QUOTE DELEGATE

extension QuoteCollectionViewController: SaveQuoteDelegation {
    
    func saveQuote(quote: Quote) {
        self.quotes.append(quote)
        quoteCollectionView.reloadData()
    }
}
