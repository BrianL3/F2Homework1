//
//  ViewController.swift
//  F2ClassRoster
//
//  Created by Brian Ledbetter on 10/29/14.
//  Copyright (c) 2014 Brian Ledbetter. All rights reserved.
//

import UIKit


class ViewController: UIViewController, UITableViewDataSource {
    
    
    @IBOutlet weak var nameLabel: UILabel!
    // a Person property, to be passed around as necessary.  See Person.swift
    var myPerson = Person(firstName: "Jimmy", lastName: "Carter", isStudent: false)
    // an Array of Person objects, to populate the viewing table.
    var people = [Person]()
    // the viewing table
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.dataSource = self
        var anotherPerson = Person()
        self.people.append(myPerson) //this appends myPerson to array
        self.people.append(anotherPerson)
    }
    /* This is the first of the 2 required functions for classes that want to adhere to the TableViewDataSource protocol.
    It returns the number of cells to display.
    */    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.people.count
    }
    
/* This is the second of the 2 required functions for classes that want to adhere to the TableViewDataSource protocol.
    It returns the contents of the cell-to-display.
*/
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        println("table view is asking about cell at row: \(indexPath.row) at section: \(indexPath.section)")
        
        let cell = tableView.dequeueReusableCellWithIdentifier("PERSON_CELL", forIndexPath: indexPath) as UITableViewCell
        var personToDisplay = self.people[indexPath.row]
        cell.textLabel.text = personToDisplay.firstName
        return cell
    }
    

    @IBAction func displayViaLabel(sender: AnyObject) {
        self.nameLabel.text = self.myPerson.firstName
    }
    
    // When button is pressed, create a person with appropriate values.
    @IBAction func addPerson(){
        self.myPerson = Person(firstName: "firstnametest", lastName: "lastnametest", isStudent: false)
        self.people.append(myPerson)
        self.tableView.reloadData()
    }
    
    @IBAction func printlnPersonData(){
        println(myPerson.isNamed())
    }
    
    @IBAction func changeFirstName(sender: AnyObject) {
        var alert = UIAlertView()
     //   self.myPerson.firstName = alert.textFieldAtIndex(0).text
        alert.title = "Enter Input"
        alert.addButtonWithTitle("Done")
        alert.alertViewStyle = UIAlertViewStyle.PlainTextInput
        alert.addButtonWithTitle("Cancel")
        alert.show()
    }
    @IBAction func displayName(sender: AnyObject){
        let alert = UIAlertController()
        alert.title = "The current person's name is \(self.myPerson.firstName)"
        let action = UIAlertAction(title: "Okay", style: .Default, handler: nil)
        alert.addAction(action)
        presentViewController(alert, animated: true, completion: nil)
        
        /*
        let message = "Alert Controller Message"
        var alert = UIAlertController(title: "Current Name is \(self.myPerson.firstName)", message: message, preferredStyle: .Alert) alert.preferredStyle = textInputMode
        let action = UIAlertAction(title: "OK", style: .Default, handler: nil)
        alert.addAction(action)
        presentViewController(alert, animated: true, completion: nil)
        */
    }
    
}

/*


*/