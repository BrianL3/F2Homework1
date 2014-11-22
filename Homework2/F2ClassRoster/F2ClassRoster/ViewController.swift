//
//  ViewController.swift
//  F2ClassRoster
//
//  Created by Brian Ledbetter on 10/29/14.
//  Copyright (c) 2014 Brian Ledbetter. All rights reserved.
//

import UIKit


class ViewController: UIViewController, UITableViewDataSource {
    
    @IBOutlet weak var personImageView: personTableViewCell!
        // for the nameLabel
    @IBOutlet weak var nameLabel: UILabel!
        // a Person property, to be passed around as necessary.  See Person.swift
    var myPerson = Person(firstName:"Jim", lastName:"Henson", isStudent:true, status: .prof)
        // an Array of Person objects, to populate the viewing table.
    var people = [Person]()
        // the viewing table
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.dataSource = self
        loadFromPlist()
    }
    // fires everytime the view will appear, even when going back to this view
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        // saves any new info to disk
        saveToArchive()
        //refreshes the table's data
        tableView.reloadData()
    }
    
    func loadFromPlist(){
        let plistURL = NSBundle.mainBundle().pathForResource("Roster", ofType: "plist")
        
        let plistArray = NSArray(contentsOfFile: plistURL!)
        
        for object in plistArray! {
            //do stuff for each
            if let personDictionary = object as? NSDictionary{
                let firstNameFromPlist = personDictionary["firstName"] as String
                let lastNameFromPlist = personDictionary["lastName"] as String
                let newPerson = Person(firstName: firstNameFromPlist, lastName: lastNameFromPlist, isStudent: false)
                self.people.append(newPerson)
            }
        }
        
    }
    
    func loadFromArchive(){
        let path = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as String
        if let peopleFromArchive = NSKeyedUnarchiver.unarchiveObjectWithFile(path + "/archive") as? [Person]{
            self.people = peopleFromArchive
        }
    }
    
    
    /* 
    This is the first of the 2 required functions for classes that want to adhere to the TableViewDataSource protocol.
    It returns the number of cells to display.
    */    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.people.count
    }
    
    /* 
    This is the second of the 2 required functions for classes that want to adhere to the TableViewDataSource protocol.
    It returns the contents of the cell-to-display.
    */
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCellWithIdentifier("CUSTOM_PERSON_CELL", forIndexPath: indexPath) as personTableViewCell
            var personToDisplay = self.people[indexPath.row]
            cell.cellNameLabel.text = personToDisplay.firstName
        //display the cellperson's image, if available
            if personToDisplay.picture != nil{
                cell.cellPersonImage.image = personToDisplay.picture
            }else{
                cell.cellPersonImage.image = personToDisplay.placeholderImage
            }
            return cell
    }
    
    /*
    This function is used when you need to segue but don't have a storyboard action linked in.
    
    override func performSegueWithIdentifier(identifier: String?, sender: AnyObject?) {
        // your code
    }
    */
    /*
    This method contains the code that happens when this scene prepares to segue into another scene.  
    Add more segue.identifiers (and be sure to name them in storyboard) for different paths
    */
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "SHOW_DETAIL" {
                // making the a local variable to hold the detailViewController (our next scene)
            let myDetailViewController = segue.destinationViewController as detailViewController
                // next, we grab the indexPath for the currently selected row in our tableView
            let selectedIndexPath = tableView.indexPathForSelectedRow()
                //  then we select the person at our selected row
            let selectedPerson : Person = people[selectedIndexPath!.row]
                // set the person to be detailed as the person in the selected row
            myDetailViewController.personToDetail = selectedPerson
        }
        
        if segue.identifier == "ADD_NEW_PERSON" {
            // making the a local variable to hold the detailViewController (our next scene)
            let myEditViewController = segue.destinationViewController as EditViewController
            // then, we set the person to be edited
            let newPerson = Person(firstName: "Add New Person", lastName: " ", isStudent: false)
                // set the person to be detailed as the person in the selected row.  The person is passed as a reference.
            myEditViewController.personToEdit = newPerson
            self.people.append(newPerson)
        }
        // add additional segue identifier if statements, if necesaary
    }
    
    func saveToArchive(){
        // get path to doc directory
        let path = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as String
        //archive it
        NSKeyedArchiver.archiveRootObject(self.people, toFile: path + "/archive")
    }
    
    
    // When button is pressed, create a person with appropriate values.  (currently not used)
    @IBAction func addPerson(){
        self.myPerson = Person(firstName: "firstnametest", lastName: "lastnametest", isStudent: false)
        self.people.append(myPerson)
        self.tableView.reloadData()
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