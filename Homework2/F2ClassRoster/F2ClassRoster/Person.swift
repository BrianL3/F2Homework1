//
//  Person.swift
//  F2ClassRoster
//
//  Created by Brian Ledbetter on 11/3/14.
//  Copyright (c) 2014 Brian Ledbetter. All rights reserved.
//

import Foundation
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
        case prim = "Primary School student"
        case high = "High School student"
        case coll = "College student"
        case grad = "Graduate School student"
        case prof = "Professional School student"
        case voc = "Vocational School student"
        case non = "not a student"
        init() {
            self = .non
        }
    }
    var firstName : String = "Add New Person"
    var lastName : String = " "
    var isStudent : Bool = false
    var studentStatus : Status = Status()
    var picture : UIImage?
    var placeholderImage: UIImage = UIImage(named: "placeholder")!
    
    init(){
    }
    
    
    init(firstName : String, lastName : String, isStudent : Bool){
        self.firstName = firstName
        self.lastName = lastName
        self.isStudent = isStudent
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
