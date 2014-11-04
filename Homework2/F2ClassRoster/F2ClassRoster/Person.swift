//
//  Person.swift
//  F2ClassRoster
//
//  Created by Brian Ledbetter on 11/3/14.
//  Copyright (c) 2014 Brian Ledbetter. All rights reserved.
//

import Foundation

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
