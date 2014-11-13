//
//  EditViewController.swift
//  F2ClassRoster
//
//  Created by Brian Ledbetter on 11/12/14.
//  Copyright (c) 2014 Brian Ledbetter. All rights reserved.
//

import UIKit

class EditViewController: UIViewController,UITextFieldDelegate {
    // all our TextField outlets
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    
    // the person to be edited
    var personToEdit = Person(firstName: "First Name", lastName: "Last Name", isStudent: false, status: .non)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Add and Edit Details"
        self.firstNameTextField.delegate = self
        self.lastNameTextField.delegate = self
        self.firstNameTextField.text = personToEdit.firstName as String
        self.lastNameTextField.text = personToEdit.lastName as String

    }
    // dismisses the keyboard when User presses enter
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
    
    @IBAction func editFirstName(sender: UITextField) {
        self.personToEdit.firstName = sender.text
    }
    @IBAction func editLastName(sender: UITextField) {
        self.personToEdit.lastName = sender.text
    }
    
    func editTextField(editTextField : UITextField){
    
    }
}
