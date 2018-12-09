//
//  WalkthroughHelper.swift
//  Walkthrough
//
//  Created by KATHYSO on 9/12/2018.
//  Copyright © 2018 KathySo. All rights reserved.
//

import UIKit

class WalkthroughHelper {
    
    enum WalkthroughType {
        case first
        case second
        
        var key: String {
            switch self {
            case .first:
                return "isShownFirstWalkthrough"
            case .second:
                return "isShownSecondWalkthrough"
            }
        }
        
        func getImages() -> [UIImage?] {
            switch self {
            case .first:
                return [UIImage(named: "default_wallpaper_1"),
                        UIImage(named: "default_wallpaper_2"),
                        UIImage(named: "default_wallpaper_3")]
            case .second:
                return [UIImage(named: "default_wallpaper_4"),
                        UIImage(named: "default_wallpaper_5"),
                        UIImage(named: "default_wallpaper_6")]
            }
        }
    }
    
    static func showWalkthroughIfNeeded(for type: WalkthroughType, in viewController: UIViewController) {
        if !UserDefaults.standard.bool(forKey: type.key) {
            let walkthoughInfo = WalkthroughInfo(images: type.getImages())
            let walkthroughVC = WalkthroughPageViewController(walkthroughType: type, walkthroughInfo: walkthoughInfo)
            viewController.present(walkthroughVC, animated: true, completion: nil)
        }
    }
    
    static func setWalkthroughStatus(for type: WalkthroughType, in viewController: UIViewController) {
        UserDefaults.standard.set(true, forKey: type.key)
        viewController.dismiss(animated: true, completion: nil)
    }
}
