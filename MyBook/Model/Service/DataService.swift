//
//  DataService.swift
//  MyBook
//
//  Created by MAC Consultant on 4/13/19.
//  Copyright © 2019 MAC Consultant. All rights reserved.
//

import UIKit


typealias DataHandler = ([Book]?) -> Void

struct bookAPI {
    
    static let base = "https://www.googleapis.com/books/v1/volumes?q="
    
    
    static func bookSearchURL(from search: String) -> String{
        
        return base + search
    }
    
}
final class downloadImage{
    
    static let shared = downloadImage()
    private init (){}
    
    struct ImageLinks {
        var smallThumbnail: String
        var thumbnail: String
    }
    
    
    
}
final class DataService{
 
    
    private init () {}
    static let shared = DataService()
    
    func getBooks(book: String?, completion: @escaping DataHandler){
        
        var myBooks = [Book]()
        
        
        guard let url = URL(string: bookAPI.bookSearchURL(from: book!)) else {
            
            completion([])
            print("Wrong URL For Books")
            return
            
        }
        URLSession.shared.dataTask(with: url) { (dat, _, err) in
            
            
            if let error = err {
                
                print("Empty Data For books: \(error.localizedDescription)")
                completion(nil)
                return
            }
            if let data = dat {
                
                do {
                    let bookObject = try JSONSerialization.jsonObject(with: data, options: []) as! [String:Any]
                    
                    
                    guard let books = bookObject["items"] as? [[String:Any]] else {
                        print("Wrong data structure")
                        return
                    }
                    
                    
                    
                    for bookDict in books {
                        
                        let book = try Book(json: bookDict)
                      myBooks.append(book!)
                        
                    }
                    
                    
                    DispatchQueue.main.async {
                        
                        completion(myBooks)
                    }
                    
                    
                    
                }catch{
                    
                    print("Unable to Serialize Object: \(error.localizedDescription)")
                    completion(nil)
                    
                    return
                }
                print("successful")
                
            }
            
            }.resume()
        
        
    }
    
}

