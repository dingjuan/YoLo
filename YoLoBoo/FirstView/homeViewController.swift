//
//  homeViewController.swift
//  YoLoBoo
//
//  Created by Jennie Ding on 12/26/20.
//  Copyright © 2020 Juan Ding. All rights reserved.
//

import UIKit
import expanding_collection

class homeViewController: ExpandingViewController {
    let base = "https://firebasestorage.googleapis.com/v0/b/yoloboo-181a2.appspot.com/o/"
    fileprivate var cellsIsOpen = [Bool]()
    fileprivate var stateModel = homeViewModel()
    
    var backgroundImageView: UIImageView!
    var blurView: UIBlurEffect!
    override func viewDidLoad() {
        itemSize = CGSize(width: 256, height: 460)
        super.viewDidLoad()
        addbackgroundBlur()
        registerCell()
        addGesture(to: collectionView!)
        configureNavBar()
        
        
        self.stateModel.loadingStatus = {[weak self] in
            DispatchQueue.main.async {
                self?.fillCellIsOpenArray()
                self?.collectionView?.reloadData()
                if let s = self?.stateModel.stateData?[0][state_keys.postalKey] {
                    let url = "\(FireBaseCustomData.base)\(s)\(".jpg?alt=media")"
                    self?.backgroundImageView.load(url: URL.init(string: url)!)
                }
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
}

extension homeViewController {
    
    fileprivate func addbackgroundBlur() {
        backgroundImageView = UIImageView.init(frame: view.bounds)
        backgroundImageView.contentMode = .scaleToFill
        
        view.addSubview(backgroundImageView)
    
        let blurEffect = UIBlurEffect(style: .dark)
        let blurredEffectView = UIVisualEffectView(effect: blurEffect)
        blurredEffectView.frame = backgroundImageView.bounds
        backgroundImageView.addSubview(blurredEffectView)
        view.sendSubviewToBack(backgroundImageView)
    }
    
    
    fileprivate func registerCell() {
        
        let nib = UINib(nibName: String(describing: homeCollectionViewCell.self), bundle: nil)
        collectionView?.register(nib, forCellWithReuseIdentifier: String(describing: homeCollectionViewCell.self))
        print(String(describing: homeCollectionViewCell.self))
    }
    
    fileprivate func fillCellIsOpenArray() {
        cellsIsOpen = Array(repeating: false, count: stateModel.stateData?.count ?? 0)
    }
    
    fileprivate func getViewController() -> ExpandingTableViewController {
        let toViewController: detailViewController = detailViewController()
        return toViewController
    }
    
    fileprivate func configureNavBar() {
        navigationItem.leftBarButtonItem?.image = navigationItem.leftBarButtonItem?.image!.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
    }
    
    func reloadBackgroundImage(_ row:Int) {
        let indexpath = IndexPath(row: currentIndex, section: 0)
        let cell = collectionView?.cellForItem(at: indexpath)
        guard let c = cell as? homeCollectionViewCell else { return }
        backgroundImageView.image = c.backgroundImageView.image
    }
}

/// MARK: Gesture
extension homeViewController {
    
    fileprivate func addGesture(to view: UIView) {
        let upGesture = UISwipeGestureRecognizer(target: self, action: #selector(swipeHandler))
        upGesture.direction = .up
        view.addGestureRecognizer(upGesture)
        
        let downGesture = UISwipeGestureRecognizer(target: self, action: #selector(swipeHandler))
        downGesture.direction = .down
       view.addGestureRecognizer(downGesture)
   
    }
    
    
    @objc func swipeHandler(_ sender: UISwipeGestureRecognizer) {
        let indexPath = IndexPath(row: currentIndex, section: 0)
        guard let cell = collectionView?.cellForItem(at: indexPath) as? homeCollectionViewCell else { return }
        // double swipe Up transition
        if cell.isOpened == true && sender.direction == .up {
            guard let vc = getViewController() as? detailViewController else { return }
            vc.backImage = cell.backgroundImageView.image
            pushToViewController(vc)
        }
        
        let open = sender.direction == .up ? true : false
        cell.cellIsOpen(open)
        cellsIsOpen[indexPath.row] = cell.isOpened
    }
}

// MARK: UIScrollViewDelegate
extension homeViewController {
    
    func scrollViewDidScroll(_: UIScrollView) {
        reloadBackgroundImage(currentIndex)
    }

}

// MARK: UICollectionViewDataSource
extension homeViewController {
    
    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        super.collectionView(collectionView, willDisplay: cell, forItemAt: indexPath)
        guard let cell = cell as? homeCollectionViewCell else { return }
        
        let index = indexPath.row % stateModel.stateData!.count
        let info = stateModel.stateData?[index]
        guard let data = info else { return }
        cell.configureCell(info: data)
        cell.cellIsOpen(cellsIsOpen[index], animated: false)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? homeCollectionViewCell
            , currentIndex == indexPath.row else { return }
        
        if cell.isOpened == false {
            cell.cellIsOpen(true)
        } else {
            pushToViewController(getViewController())
        }
    }
}

// MARK: UICollectionViewDataSource
extension homeViewController {
    
    override func collectionView(_: UICollectionView, numberOfItemsInSection _: Int) -> Int {
        return self.stateModel.stateData?.count ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: homeCollectionViewCell.self), for: indexPath)
    }
}

extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
