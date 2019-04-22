//
//  BookDetailViewController.swift
//  MyBook
//
//  Created by MAC Consultant on 4/15/19.
//  Copyright © 2019 MAC Consultant. All rights reserved.
//

import UIKit

class BookDetailViewController: UIViewController {

//    var titletext: String!
//    var author: String!
//    var publishedDate: String!
//    var thumbnail: String!
    
    
    var ViewModel: viewModel!
    @IBOutlet weak var thumbnailImage: UIImageView!
    
    
    
    @IBOutlet weak var titleLabel: UILabel!
    
    
    @IBOutlet weak var authorLabel: UILabel!
    
    
    @IBOutlet weak var publishedDateLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        authorLabel.text = ViewModel.currentBook.author
        publishedDateLabel.text = ViewModel.currentBook.publishedDate
        titleLabel.text = ViewModel.currentBook.title
        
        let url = URL(string: ViewModel.currentBook.thumbnail)!
        
        URLSession.shared.dataTask(with: url){ (dat,_,_) in
            
            if let data =  dat {
                if let image = UIImage(data: data) {
                    
                    DispatchQueue.main.async {
                        self.thumbnailImage.image = image
                        self.view.layoutIfNeeded()
                
                
                
                    }
                }
            }
            
        }.resume()
            
        
        
        
    }
    

    
}
