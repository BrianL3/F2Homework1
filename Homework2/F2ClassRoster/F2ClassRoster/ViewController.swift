//
//  ViewController.swift
//  F2ClassRoster
//
//  Created by Brian Ledbetter on 10/29/14.
//  Copyright (c) 2014 Brian Ledbetter. All rights reserved.
//

import UIKit

/// A bipedal mammal.  Dominant species on planet Earth.
class Person{
    /**
    Type of student.
    - Primary School
    - High School
    - College
    - Graduate School
    - Professional School
    - Vocational School
    - Not a Student
    */
    enum Status : String{
        case prim = "Primary School"
        case high = "High School"
        case coll = "College"
        case grad = "Graduate School"
        case prof = "Professional School"
        case voc = "Vocational School"
        case non = "Not a Student"
        init() {
            self = .non
        }
    }
    var firstName : String = "firstname not set"
    var lastName : String = "lastname not set"
    var isStudent : Bool = false
    var studentStatus : Status
    
    init(firstName : String, lastName : String, isStudent : Bool){
        self.firstName = firstName
        self.lastName = lastName
        self.isStudent = isStudent
        self.studentStatus = .non
    }
    
    
    init(firstName : String, lastName : String, isStudent : Bool, status: Status){
        self.firstName = firstName
        self.lastName = lastName
        self.isStudent = isStudent
        self.studentStatus = status
    }
    
    func isNamed() -> String {
        return "This person is called \(firstName) \(lastName)."
    }
    
    func fullData() -> (fullName : String, isAStudent : Bool, studentsStatus : String){
        let firstName = self.firstName
        let lastName = self.lastName
        let fullName = firstName + " " + lastName
        return (fullName, self.isStudent, self.studentStatus.rawValue)
    }
}

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