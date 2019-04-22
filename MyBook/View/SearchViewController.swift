//
//  ViewController.swift
//  MyBook
//
//  Created by MAC Consultant on 4/12/19.
//  Copyright © 2019 MAC Consultant. All rights reserved.
//


import UIKit

class SearchViewController: UIViewController {

   
    @IBOutlet weak var bookTableView: UITableView!
      let ViewModel = viewModel()
    
//    var myBooks = [Book](){
//        didSet {
//
//            DispatchQueue.main.async {
//                self.bookTableView.reloadData()
//            }
//        }
//    }
    
    
    let searchController = UISearchController(searchResultsController: nil)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createSearchBar()
        ViewModel.delegate = self
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        searchController.isActive = false
        searchController.definesPresentationContext = true
        
        
    }
    
    
    
    func createSearchBar() {
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = "search books..."
        
    }
    
}





extension SearchViewController: UITableViewDelegate{
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        let book  =  ViewModel.myBooks[indexPath.row]
        ViewModel.currentBook = book
        
        let bkDetailVC = storyboard?.instantiateViewController(withIdentifier: "BookDetailViewController") as! BookDetailViewController
        
        bkDetailVC.ViewModel = ViewModel
        
        

        
        
        
//        bkDetailVC.author = book.author
//        bkDetailVC.titletext = book.title
//        bkDetailVC.publishedDate = book.publishedDate
//        bkDetailVC.thumbnail = book.thumbnail
//
//
        self.navigationController?.pushViewController(bkDetailVC, animated: true)
        
    }
}
extension SearchViewController: UITableViewDataSource{
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ViewModel.myBooks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let bookCell = tableView.dequeueReusableCell(withIdentifier: BookTableViewCell.identifier, for: indexPath) as! BookTableViewCell
        
        let book = ViewModel.myBooks[indexPath.row]
        
        bookCell.configureCell(with: book)
        
        return bookCell
    }
    
    
    
    
    
}
extension SearchViewController: UISearchResultsUpdating {
    
    
    func updateSearchResults(for searchController: UISearchController) {
        
        let searchText  = searchController.searchBar.text?.replacingOccurrences(of: " ", with: "")
        
        ViewModel.get(books: searchText)
        }
    
    
    }


extension SearchViewController: ViewModelDelegate{
    
    func updateView() {
        DispatchQueue.main.async {
           self.bookTableView.reloadData()
            
        }
    }
    
}

