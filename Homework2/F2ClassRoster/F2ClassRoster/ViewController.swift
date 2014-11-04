//
//  ViewController.swift
//  F2ClassRoster
//
//  Created by Brian Ledbetter on 10/29/14.
//  Copyright (c) 2014 Brian Ledbetter. All rights reserved.
//

import UIKit


class ViewController: UIViewController {
    
    
    @IBOutlet weak var nameLabel: UILabel!
    
    var myPerson = Person(firstName: "Jimmy", lastName: "Carter", isStudent: false)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let redBox = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        redBox.backgroundColor = UIColor.redColor()
        self.view.addSubview(redBox)
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func displayViaLabel(sender: AnyObject) {
        self.nameLabel.text = self.myPerson.firstName
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // When button is pressed, create a person with appropriate values.
    @IBAction func addPerson(){
        self.myPerson = Person(firstName: "firstnametest", lastName: "lastnametest", isStudent: false)
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