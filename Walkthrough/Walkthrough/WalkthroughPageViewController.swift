//
//  WalkthroughPageViewController.swift
//  Walkthrough
//
//  Created by KATHYSO on 9/12/2018.
//  Copyright © 2018 KathySo. All rights reserved.
//

import UIKit

class WalkthroughPageViewController: UIViewController {
    
    weak var pageViewController: UIPageViewController!
    
    let walkthroughInfo: WalkthroughInfo
    
    init(walkthroughInfo: WalkthroughInfo) {
        self.walkthroughInfo = walkthroughInfo
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.addPageViewController()
    }
    
    func addPageViewController() {
        // Add Page View Controller
        let pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: [:])
        pageViewController.view.backgroundColor = .black
        pageViewController.dataSource = self
        pageViewController.delegate = self
        
        guard let pageView = pageViewController.view else { return }
        
        self.addChild(pageViewController)
        pageView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(pageView)
        
//        pageView.
        
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[pageView]|", options: [], metrics: nil, views: ["pageView": pageView]))
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[pageView]|", options: [], metrics: nil, views: ["pageView": pageView]))
        
        pageViewController.didMove(toParent: self)
        self.pageViewController = pageViewController
    }
}

extension WalkthroughPageViewController: UIPageViewControllerDelegate {
    
}

extension WalkthroughPageViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        <#code#>
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        <#code#>
    }
}
