//
//  SearchTableViewController.swift
//  Co-Llab
//
//  Created by Matthew Fishkin on 3/14/15.
//  Copyright (c) 2015 Fishkin. All rights reserved.
//

import UIKit

class SearchTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    @IBOutlet weak var _tableView: UITableView!
    
    let _searchBar = UISearchBar()
    
    private let searchHelper = SearchHelper()
    
    var currentDisplayUsers:[User] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        _searchBar.delegate = self
        self.navigationItem.titleView = self._searchBar
        
        currentDisplayUsers = searchHelper.returnSearchResults("")
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func viewDidAppear(animated: Bool) {
        UserController.getAllUsers { (users) -> Void in
            self.currentDisplayUsers = users as! [User]
            self._tableView.reloadData()
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return currentDisplayUsers.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("userCell", forIndexPath: indexPath) as! CustomUserTableViewCell
        
        let curUser = currentDisplayUsers[indexPath.item]
        
        cell.textLabel?.text = curUser._email
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        performSegueWithIdentifier("showProfileSegue", sender: tableView.cellForRowAtIndexPath(indexPath))
        
        dismissKeyboard()
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    // Return NO if you do not want the specified item to be editable.
    return true
    }
    */
    
    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
    if editingStyle == .Delete {
    // Delete the row from the data source
    tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
    } else if editingStyle == .Insert {
    // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
    }
    */
    
    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {
    
    }
    */
    
    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    // Return NO if you do not want the item to be re-orderable.
    return true
    }
    */
    
    // MARK: - Table Selection
    // Return false if you do not wish to highlight cells
    // TODO: turn off highlighting when done testing
    func tableView(tableView: UITableView, shouldHighlightRowAtIndexPath indexPath: NSIndexPath) -> Bool {
       
        // TODO: Turn to false when done testing
        return true
    }
    
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "showProfileSegue" {
            if let navCont = segue.destinationViewController as? UINavigationController {
                if let profCont = navCont.viewControllers?[0] as? ProfileViewController {
                    profCont.isSelf = false
                }
            }
        }
    }
    
    
    
    // MARK: - Search Bar Delegate
    
    // return NO to not become first responder
    func searchBarShouldBeginEditing(searchBar: UISearchBar) -> Bool {
        return true
    }
    
    
    // return NO to not resign first responder
    func searchBarShouldEndEditing(searchBar: UISearchBar) -> Bool{
        return true
    }
    
    // called when cancel button pressed
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        dismissKeyboard()
    }
    
    // called when search results button pressed
    func searchBarResultsListButtonClicked(searchBar: UISearchBar) {
        dismissKeyboard()
    }
    
    
    // called when text changes (including clear)
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        currentDisplayUsers = searchHelper.returnSearchResults(searchText)
        _tableView.reloadData()
    }
    
    // MARK:- Helper Functions
    
    private func dismissKeyboard() {
        _searchBar.endEditing(true)
    }
    
}
