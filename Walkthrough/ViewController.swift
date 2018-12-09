//
//  ViewController.swift
//  Walkthrough
//
//  Created by KATHYSO on 9/12/2018.
//  Copyright © 2018 KathySo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBAction func secondWalkthroughDidPress(_ sender: Any) {
        WalkthroughHelper.showWalkthroughIfNeeded(for: .second, in: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        WalkthroughHelper.showWalkthroughIfNeeded(for: .first, in: self)
    }
}

