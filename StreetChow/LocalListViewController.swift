//
//  LocalListViewController.swift
//  StreetChow
//
//  Created by Das Beard on 2/27/17.
//  Copyright © 2017 dasBeard. All rights reserved.
//

import UIKit

class LocalListViewController: UITableViewController {
    
// Variables ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

    var delegate: LocalListDelegate?
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
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Table View Methods :::::::::::::::::::::::::::::::::::::::::::::::::::::::::
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return destinations.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath)
        
        cell.textLabel?.text = destinations[indexPath.row].name
        cell.detailTextLabel?.text = destinations[indexPath.row].phone
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        // perform segue with all info
    }
    
    
}









