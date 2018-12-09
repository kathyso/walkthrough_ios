//
//  WalkthroughPageViewController.swift
//  Walkthrough
//
//  Created by KATHYSO on 9/12/2018.
//  Copyright © 2018 KathySo. All rights reserved.
//

import UIKit
import SnapKit

class WalkthroughPageViewController: UIViewController {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var skipButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var finishButton: UIButton!
    
    weak var pageViewController: UIPageViewController!
    var controllers = [UIViewController]()
    
    let walkthroughInfo: WalkthroughInfo
    let walkthroughType: WalkthroughHelper.WalkthroughType
    
    init(walkthroughType: WalkthroughHelper.WalkthroughType, walkthroughInfo: WalkthroughInfo) {
        self.walkthroughType = walkthroughType
        self.walkthroughInfo = walkthroughInfo
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @IBAction func skipButtonDidPress(_ sender: Any) {
        WalkthroughHelper.setWalkthroughStatus(for: self.walkthroughType, in: self)
    }
    
    @IBAction func nextButtonDidPress(_ sender: Any) {
        self.switchToNextController()
    }
    
    @IBAction func finishButtonDidPress(_ sender: Any) {
        WalkthroughHelper.setWalkthroughStatus(for: self.walkthroughType, in: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.addPageViewController()
        self.setupViewControllers()
        self.updateButtonLayout(isLastPage: false)
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
        self.containerView.addSubview(pageView)
        
        pageView.snp.makeConstraints { (maker) in
            maker.top.equalTo(self.containerView)
            maker.bottom.equalTo(self.containerView)
            maker.leading.equalTo(self.containerView)
            maker.trailing.equalTo(self.containerView)
        }
        
        pageViewController.didMove(toParent: self)
        self.pageViewController = pageViewController
    }
    
    func setupViewControllers() {
        for (idx, image) in self.walkthroughInfo.images.enumerated() {
            let vc = WalkthroughContentViewController(image: image, pageIndex: idx)
            self.controllers.append(vc)
        }
        
        if let firstController = self.controllers.first {
            self.pageViewController.setViewControllers([firstController], direction: .forward, animated: false, completion: nil)
        }
    }
}

extension WalkthroughPageViewController {
    func viewControllerAtIndex(index: Int) -> UIViewController? {
        if index < self.controllers.count {
            return self.controllers[index]
        }
        
        return nil
    }
    
    func getPreviousViewController(from viewController: UIViewController) -> UIViewController? {
        if let index = self.controllers.index(of: viewController) {
            if index == 0 {
                return nil
            } else {
                self.updateButtonLayout(isLastPage: false)
                let previousIndex = index - 1
                return self.viewControllerAtIndex(index: previousIndex)
            }
        }
        return nil
    }
    
    func getNextViewController(from viewController: UIViewController) -> UIViewController? {
        if let index = self.controllers.index(of: viewController) {
            if index == self.controllers.count - 1 {
                self.updateButtonLayout(isLastPage: true)
                return nil
            } else {
                let nextIndex = index + 1
                return self.viewControllerAtIndex(index: nextIndex)
            }
        }
        return nil
    }
    
    func updatePageIndex() {
        if let controller = self.pageViewController.viewControllers?.first,
            let vc = controller as? WalkthroughContentViewController {
            self.pageControl.currentPage = vc.pageIndex
        }
    }
    
    func updateButtonLayout(isLastPage: Bool) {
        self.skipButton.isHidden = isLastPage
        self.nextButton.isHidden = isLastPage
        self.finishButton.isHidden = !isLastPage
        
        UIView.animate(withDuration: 0.24) {
            self.view.layoutIfNeeded()
        }
    }
    
    func switchToNextController() {
        guard let controller = self.pageViewController.viewControllers?.first,
            let vc = self.getNextViewController(from: controller) as? WalkthroughContentViewController else {
                return
        }
        
        self.pageViewController.setViewControllers([vc], direction: .forward, animated: true) { [weak self] (_) in
            self?.updatePageIndex()
        }
    }
}

extension WalkthroughPageViewController: UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        self.updatePageIndex()
    }
}

extension WalkthroughPageViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        return self.getPreviousViewController(from: viewController)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        return self.getNextViewController(from: viewController)
    }
}
