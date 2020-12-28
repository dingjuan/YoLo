//
//  detailViewController.swift
//  YoLoBoo
//
//  Created by Jennie Ding on 12/26/20.
//  Copyright © 2020 Juan Ding. All rights reserved.
//

import UIKit
import expanding_collection

class detailViewController: ExpandingTableViewController {
    
    var backImage: UIImage?
    fileprivate var scrollOffsetY: CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavBar()
       // tableView.backgroundView = UIImageView(image: backImage)
        if #available(iOS 11.0, *) {
            tableView.contentInsetAdjustmentBehavior = .never
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
}
// MARK: Helpers

extension detailViewController {
    
    fileprivate func configureNavBar() {
        navigationItem.leftBarButtonItem?.image = navigationItem.leftBarButtonItem?.image!.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        navigationItem.rightBarButtonItem?.image = navigationItem.rightBarButtonItem?.image!.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
    }
}

// MARK: Actions

extension detailViewController {
    
    @IBAction func backButtonHandler(_: AnyObject) {
        // buttonAnimation
        let viewControllers: [homeViewController?] = navigationController?.viewControllers.map { $0 as? homeViewController } ?? []

        for viewController in viewControllers {
            if let rightButton = viewController?.navigationItem.rightBarButtonItem {
                rightButton.tintColor = .clear
                rightButton.isEnabled = false
            }
        }
        popTransitionAnimation()
    }
}

// MARK: UIScrollViewDelegate

extension detailViewController {
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y < -25  {
            popTransitionAnimation()
        }
        scrollOffsetY = scrollView.contentOffset.y
    }
}

