//
//  LocalListViewController.swift
//  StreetChow
//
//  Created by Das Beard on 2/27/17.
//  Copyright © 2017 dasBeard. All rights reserved.
//

import UIKit

class LocalListViewController: UITableViewController, UISearchBarDelegate {
    
// Variables ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

    var destinations = [Shelters]()
    
    
    
// Actions :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

    @IBAction func backButtonPressed(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }

    
    

    
    
// UI Lifecycle :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
    override func viewDidLoad() {
        super.viewDidLoad()
        let appDel = UIApplication.shared.delegate as! AppDelegate
        for shelter in appDel.destinations!{
            destinations.append(shelter)
        }
        self.searchBarSetup()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
// Table View Methods :::::::::::::::::::::::::::::::::::::::::::::::::::::::::
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if shouldShowSearchResults{
            return filteredArray.count
        } else {
            return destinations.count
        }
    }
    /// Define Cell
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath)
        
        if shouldShowSearchResults{
            cell.textLabel?.text = filteredArray[indexPath.row].name
            cell.detailTextLabel?.text = filteredArray[indexPath.row].address
            cell.selectionStyle = UITableViewCellSelectionStyle.none
        } else {
            cell.textLabel?.text = destinations[indexPath.row].name
            cell.detailTextLabel?.text = destinations[indexPath.row].address
            cell.selectionStyle = UITableViewCellSelectionStyle.none
        }
        
        return cell
    }
    

    
    
    
    
    /// Segue when accessory is selected
    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        performSegue(withIdentifier: "showSegue", sender: indexPath)
    }
    
    
    
    
    
// Segue :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let navController = segue.destination as! UINavigationController
        let vc = navController.topViewController as! LocationViewController
        let indexPath = sender as! NSIndexPath
        vc.destination = destinations[indexPath.row]
        
    }
    
    
    // SearchBar :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
    let searchbar = UISearchBar(frame: CGRect(x:0,y:0,width:(UIScreen.main.bounds.width), height:40))
    var filteredArray = [Shelters]()
    var shouldShowSearchResults = false
    
    func searchBarSetup(){
        searchbar.showsScopeBar = true
        searchbar.delegate = self
        searchbar.placeholder = "Search by name"
        self.tableView.tableHeaderView = searchbar
    }
    
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredArray = destinations.filter({ (Shelters: Shelters) -> Bool in
            return Shelters.name.lowercased().range(of: searchText.lowercased()) != nil
        })
        
        if searchText != "" {
            shouldShowSearchResults = true
            self.tableView.reloadData()
        } else {
            shouldShowSearchResults = false
            self.tableView.reloadData()
        }
        
        
    }
    
    
    
    
    override func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        searchbar.endEditing(true)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        shouldShowSearchResults = true
        searchBar.endEditing(true)
        self.tableView.reloadData()
    }

    
    
 
    
    
    
    
    
}

















