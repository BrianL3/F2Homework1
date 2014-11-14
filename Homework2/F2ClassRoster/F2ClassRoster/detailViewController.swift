//
//  detailViewController.swift
//  F2ClassRoster
//
//  Created by Brian Ledbetter on 11/6/14.
//  Copyright (c) 2014 Brian Ledbetter. All rights reserved.
//

import UIKit

class detailViewController: UIViewController {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var studentStatusLabel: UILabel!
    @IBOutlet weak var picImageView: UIImageView!
    
    // This scene's purpose is to detail this person's data.
    var personToDetail = Person(firstName: "name failed to init", lastName: "error", isStudent: false, status: .non)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = self.personToDetail.firstName + " " + self.personToDetail.lastName
        displayViaLabel()
        displayPic()
    }
    /*
    Display all of this scene's personToDetail's data on screen via labels.
    */
    @IBAction func displayViaLabel() {
        self.nameLabel.text = self.personToDetail.firstName + " " + self.personToDetail.lastName
        self.studentStatusLabel.text = self.personToDetail.studentStatus.rawValue as NSString
    }
    func displayPic(){
        if self.personToDetail.picture != nil{
            self.picImageView.image = self.personToDetail.picture
        }else{
        self.picImageView.image = self.personToDetail.placeholderImage
        }
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "EDIT_PERSON" {
            // making the a local variable to hold the detailViewController (our next scene)
            let myEditViewController = segue.destinationViewController as EditViewController
            // then, we set the person to be edited
            let editPerson = self.personToDetail
            // set the person to be detailed as the person in the selected row.  The person is passed as a reference.
            myEditViewController.personToEdit = editPerson
        }
        // add additional segue identifier if statements, if necesaary
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewDidAppear(animated)
        displayViaLabel()
        displayPic()
        self.title = self.personToDetail.firstName + " " + self.personToDetail.lastName
    }
}
