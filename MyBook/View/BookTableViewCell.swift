//
//  BookTableTableViewCell.swift
//  MyBook
//
//  Created by MAC Consultant on 4/14/19.
//  Copyright © 2019 MAC Consultant. All rights reserved.
//

import UIKit

class BookTableViewCell: UITableViewCell

{

    
    @IBOutlet weak var author: UILabel!
    
    
    @IBOutlet weak var title: UILabel!
    
  
    
    
    @IBOutlet weak var publishedDate: UILabel!
    
    static let identifier = "Cell"
    
    func configureCell(with book: Book){
        
        
        author.text = book.author
        publishedDate.text = book.publishedDate
        title.text = book.title
}
}
