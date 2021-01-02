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
    var cityData: Array<Dictionary<String, Any>>?
    var states: Array<String>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavBar()
       // tableView.backgroundView = UIImageView(image: backImage)
        if #available(iOS 11.0, *) {
            tableView.contentInsetAdjustmentBehavior = .never
        }
        tableView.separatorStyle = .none
        registerCell()
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
    
    fileprivate func registerCell() {
        
        let nib = UINib(nibName: String(describing: cityTableViewCell.self), bundle: nil)
        tableView?.register(nib, forCellReuseIdentifier: String(describing: cityTableViewCell.self))
        tableView?.delegate = self
        tableView?.dataSource = self
    }
}

extension detailViewController { //UITableViewDataSource
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cityData?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140.0
    }
}

extension detailViewController { //UITableViewDelegate
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: cityTableViewCell.self), for: indexPath) as? cityTableViewCell
        
        cell?.nameLabel.text = cityData?[indexPath.row][city_keys.name] as? String ?? ""
        
        return cell!
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

