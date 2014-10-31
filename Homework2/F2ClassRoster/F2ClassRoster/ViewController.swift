//
//  ViewController.swift
//  F2ClassRoster
//
//  Created by Brian Ledbetter on 10/29/14.
//  Copyright (c) 2014 Brian Ledbetter. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let redBox = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        redBox.backgroundColor = UIColor.redColor()
        println("View didLoad just fired")
        self.view.addSubview(redBox)
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        println("viewwillappear just fired")
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        println("View DID appear just fired")
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        println("view will disappear")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

