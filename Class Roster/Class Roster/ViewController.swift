//
//  ViewController.swift
//  Class Roster
//
//  Created by Brian Ledbetter on 11/3/14.
//  Copyright (c) 2014 Brian Ledbetter. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource {

    // InterfaceBuilder's tableview off the launch screen
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Very Important ---> makes the TableView ask the right instance
        self.tableView.dataSource = self
    }
    
    // #1 of the 2 methods required to conform
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10000
    }
        
    // #2 of the 2 methods required to conform
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell =
        tableView.dequeueReusableCellWithIdentifier("PERSON_CELL", forIndexPath: indexPath) as UITableViewCell
        cell.textLabel.text = "Go Hawks"
        return cell
    }
    
    //tableView.dequeueReusableCellWithIdentifier("PERSON_CELL", forIndexPAth)
}

