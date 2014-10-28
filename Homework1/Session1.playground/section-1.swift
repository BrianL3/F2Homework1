// Playground - noun: a place where people can play

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
    var studentStatus : Status;

    
    init(firstName : String, lastName : String, isStudent : Bool, status: Status){
        self.firstName = firstName
        self.lastName = lastName
        self.isStudent = isStudent
        self.studentStatus = status
    }
    
    func isNamed() -> String {
        return "This person is called \(firstName) \(lastName)."
    }
    
    func namesAsTuple() -> (name1: String, name2: String) {
        let fullName = (firstName, lastName)
        return fullName
    }
    
    func fullData() -> (fullName : String, isAStudent : Bool, studentsStatus : String){
        let nameTuple = self.namesAsTuple()
        let firstName = nameTuple.0
        let lastName = nameTuple.1
        let fullName = firstName + " " + lastName
        return (fullName, self.isStudent, self.studentStatus.rawValue)
    }
}

var jimmy = Person(firstName: "Jim", lastName: "Henson", isStudent: false, status: .non)
jimmy.isNamed()
jimmy.namesAsTuple()
jimmy.fullData()

var alice = Person(firstName: "Alice", lastName: "nChains", isStudent: true, status: .prof)
alice.isNamed()
alice.fullData()
