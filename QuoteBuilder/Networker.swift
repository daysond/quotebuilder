//
//  Networker.swift
//  QuoteBuilder
//
//  Created by Dayson Dong on 2019-06-12.
//  Copyright © 2019 Dayson Dong. All rights reserved.
//

import Foundation

class Networker {
    
    func getQuote(completion: @escaping (Data) -> (Void)) {
        
        let apiURL = URL.init(string: "http://api.forismatic.com/api/1.0/?method=getQuote&lang=en&format=json")
        
        var request = URLRequest.init(url: apiURL!)
        
        request.httpMethod = "POST"
        
        let dataTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            guard let httpResponse = response as? HTTPURLResponse else {
                print("bad response: \(String(describing: response))")
                return
            }

            guard httpResponse.statusCode == 200 else {
                print("http response with code: \(httpResponse.statusCode)")
                return
            }
            
            guard error == nil else {
                print("request fail with error: \(String(describing: error))")
                return
            }
            
            guard let quoteData = data else {
                print("bad data!")
                return
            }
            
            completion(quoteData)
            
        }
        
        dataTask.resume()
        
    }
    
    func getImage(completion: @escaping (URL) -> (Void)) {
        
        let apiURL = URL.init(string: "https://source.unsplash.com/random/640x480" )
        
        let downloadTask = URLSession.shared.downloadTask(with: apiURL!) { (url, response, error) in
            
            guard let httpResponse = response as? HTTPURLResponse else {
                print("bad response: \(String(describing: response))")
                return
            }
            
            guard httpResponse.statusCode == 200 else {
                print("http response with code: \(httpResponse.statusCode)")
                return
            }
            
            guard error == nil else {
                print("request fail with error: \(String(describing: error))")
                return
            }
            
            guard let url = url else {
                print("no url returned")
                return
            }
            
            completion(url)
            
            
        }
        
        downloadTask.resume()
        
        
        
    }
    
    
    
    
    
}
