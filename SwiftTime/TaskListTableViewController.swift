//
//  TaskListTableViewController.swift
//  SwiftTime
//
//  Created by Brian Lane on 10/7/16.
//  Copyright © 2016 Brian Lane. All rights reserved.
//

import UIKit

class TaskListTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var table: UITableView!
    
    var activeRow = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {

//        table.reloadData()
    }

    // MARK: - Table view data source

    internal func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {

        return AppDelegate().sharedInstance().completedTomatoes.count
    }
    
    internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "Cell")
        
        cell.textLabel?.text = "\(AppDelegate().sharedInstance().completedTomatoes[indexPath.row])"
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        activeRow = indexPath.row
        
        performSegue(withIdentifier: "segueToDetailVC", sender: nil)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        
        if segue.identifier == "segueToDetailVC" {
            
            let detailVC = segue.destination as! TaskDetailViewController
            
            detailVC.activeRow = AppDelegate().sharedInstance().completedTomatoes[activeRow]
                        
        }
    }
    


}
