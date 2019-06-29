//
//  DocumentsTableViewController.swift
//  Documents Core Data
//
//  Created by Drew Boowee on 6/27/19.
//  Copyright © 2019 Drew Boowee. All rights reserved.
//

import UIKit
import CoreData

class DocumentsTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var documentsTableView: UITableView!
    
    let dateFormatter = DateFormatter()
    var documents = [UIDocument]()
    var searchController : UISearchController?
    var selectedSearchScope = SearchScope.all
    
    override func viewDidLoad() {
        super.viewDidLoad()

        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .medium
        
        documentsTableView.delegate = self
        documentsTableView.dataSource = self
        
        searchController?.searchResultsUpdater = self as? UISearchResultsUpdating
        searchController?.obscuresBackgroundDuringPresentation = false
        searchController?.searchBar.placeholder = "Search Documents"
        
        navigationItem.searchController = searchController
        
        definesPresentationContext = true
        
        searchController?.searchBar.scopeButtonTitles = SearchScope.titles
        searchController?.searchBar.delegate = self as? UISearchBarDelegate
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
//        let fetchRequest: NSFetchRequest<Document> = Document.fetchRequest()
        
        do {
  //          documents = try managedContext.fetch(fetchRequest)
        } catch {
            print("Fetch could not be performed")
        }
        
        documentsTableView.reloadData()
    }
    
    func deleteDocument(at indexPath: IndexPath) {
        let document = documents[indexPath.row]
        
        if let managedObjectContext = document.managedObjectContext {
            managedObjectContext.delete(document)
            
            do {
                try managedObjectContext.save()
                self.documents.remove(at: indexPath.row)
                documentsTableView.deleteRows(at: [indexPath], with: .automatic)
            } catch {
                alertNotifyUser(message: "Delete failed.")
                documentsTableView.reloadData()
            }
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return documents.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "documentCell", for: indexPath)
        
        if let cell = cell as? DocumentTableViewCell {
            let document = documents[indexPath.row]
            cell.nameLabel.text = document.name
            cell.sizeLabel.text = String(document.size) + " bytes"
            
            if let modifiedDate = document.modifiedDate {
                cell.modifiedLabel.text = dateFormatter.string(from: modifiedDate)
            } else {
                cell.modifiedLabel.text = "unknown"
            }
        }
        
        return cell
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? DocumentViewController,
            let segueIdentifier = segue.identifier, segueIdentifier == "existingDocument",
            let row = documentsTableView.indexPathForSelectedRow?.row {
            destination.document = documents[row]
        }
    }
    

    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let delete = UITableViewRowAction(style: .destructive, title: "Delete") {
            (action, index) in
            self.delete(at: indexPath)
        }
        
        return [delete]
    }
    
    
    //segue for editing existing documents
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? DocumentsViewController,
            let seg = segue.identifier, seg == "editDocument",
            let row = documentsTableView.indexPathForSelectedRow?.row {
 //               destination.document = documents[row]
            }
    }






