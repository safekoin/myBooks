//
//  Book.swift
//  MyBook
//
//  Created by MAC Consultant on 4/13/19.
//  Copyright © 2019 MAC Consultant. All rights reserved.
//

import Foundation
enum BookError: Error{
    case missing(String)
}
class Book {

    var title: String
    var author: String
    var publishedDate: String!
    var thumbnail: String

    init?(json: [String : Any]) throws {

        
        guard let volumeInfo = json["volumeInfo"] as? [String : Any] else {throw BookError.missing("missing volumeInfo")}
        guard let imageLinks = volumeInfo["imageLinks"] as? [String:String] else {throw BookError.missing(" missing imageLinks")}
        guard let authors = volumeInfo["authors"] as? [String] else {throw BookError.missing("missing authors")}
        guard let thumbnail = imageLinks["thumbnail"] else {throw BookError.missing("missing thumbnail")}
        
        self.author = authors[0]
        self.publishedDate = volumeInfo["publishedDate"] as? String
        self.title = volumeInfo["title"] as! String
        self.thumbnail = thumbnail

       

        
    }




}
