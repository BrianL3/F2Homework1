//
//  detailViewController.swift
//  F2ClassRoster
//
//  Created by Brian Ledbetter on 11/6/14.
//  Copyright (c) 2014 Brian Ledbetter. All rights reserved.
//

import UIKit

class detailViewController: UIViewController {

    @IBOutlet weak var firstNameLabel: UILabel!
    @IBOutlet weak var lastNameLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var studentStatusLabel: UILabel!
    
    // This scene's purpose is to detail this person's data.
    var personToDetail = Person(firstName: "name failed to init", lastName: "error", isStudent: false, status: .non)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = self.personToDetail.firstName + " " + self.personToDetail.lastName
        displayViaLabel()
    }
    /*
    Display all of this scene's personToDetail's data on screen via labels.
    */
    @IBAction func displayViaLabel() {
        self.nameLabel.text = self.personToDetail.firstName + " " + self.personToDetail.lastName
        self.firstNameLabel.text = self.personToDetail.firstName
        self.lastNameLabel.text = self.personToDetail.lastName
        self.studentStatusLabel.text = self.personToDetail.studentStatus.rawValue as NSString
    }
}
