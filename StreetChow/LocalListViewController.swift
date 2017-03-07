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
    /// Define Cell
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath)
        
        cell.textLabel?.text = destinations[indexPath.row].name
        cell.detailTextLabel?.text = destinations[indexPath.row].address
        cell.selectionStyle = UITableViewCellSelectionStyle.none
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
        
        
//        let navigationController = segue.destination as! UINavigationController
//        let localList = navigationController.topViewController as! LocalListViewController
//        localList.delegate = self
        
    }
    
    
    
    
    
 
    
    
    
    
    
}

















