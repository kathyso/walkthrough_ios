//
//  WalkthroughContentViewController.swift
//  Walkthrough
//
//  Created by KATHYSO on 9/12/2018.
//  Copyright © 2018 KathySo. All rights reserved.
//

import UIKit

class WalkthroughContentViewController: UIViewController {

    @IBOutlet weak var displayImageView: UIImageView!
    var image: UIImage?
    var pageIndex: Int
    
    init(image: UIImage?, pageIndex: Int) {
        self.image = image
        self.pageIndex = pageIndex
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.displayImageView.image = self.image
        self.displayImageView.contentMode = .scaleAspectFill
        self.displayImageView.clipsToBounds = true
    }

}
