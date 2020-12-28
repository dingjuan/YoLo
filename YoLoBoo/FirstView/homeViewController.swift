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
    
    typealias state = (name: String, capital: String, population: String, postal: String)
    let token =  "b64eb1f0-7ab8-497d-b0ec-134c9b2e93b2"
    let base = "https://firebasestorage.googleapis.com/v0/b/yoloboo-181a2.appspot.com/o/"
    fileprivate var cellsIsOpen = [Bool]()
    //fileprivate let items: [ItemInfo] = [("boston.png", "boston"), ("new york.png", "new york"), ("san francisco.png", "san francisco"), ("washington.png", "washington")] // should load from network
    fileprivate var items: [state]?
    
    var backgroundImageView: UIImageView!
    var blurView: UIBlurEffect!
    override func viewDidLoad() {
        itemSize = CGSize(width: 256, height: 460)
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        
        collectionView?.delegate = self
        collectionView?.dataSource = self
        addbackgroundBlur()
        registerCell()
        fillCellIsOpenArray()
        addGesture(to: collectionView!)
        configureNavBar()
        fetchData()
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
    
    func fetchData() {
        let _: Void = FireBaseCustomData.ref.getDocuments(completion: {(query, err) in
            if let err = err {
                print(err)
            } else {
                for document in query!.documents {
                    print("\(document.documentID) => \(document.data())")

    
                    let data:state = document.data().mapValues( String(query))
                    
                    self.items?.append(data)
                    
                }
                self.collectionView?.reloadData()
                let url = "\(self.base) \(self.items?[0].postal) \(".jpg?alt=media&token:")\(self.token)"
                self.backgroundImageView.load(url: URL.init(string: url)!)
            }
            
          }
        )
    }
    
    fileprivate func registerCell() {
        
        let nib = UINib(nibName: String(describing: DemoCollectionViewCell.self), bundle: nil)
        collectionView?.register(nib, forCellWithReuseIdentifier: String(describing: DemoCollectionViewCell.self))
        print(String(describing: DemoCollectionViewCell.self))
    }
    
    fileprivate func fillCellIsOpenArray() {
        cellsIsOpen = Array(repeating: false, count: items?.count ?? 0)
    }
    
    fileprivate func getViewController() -> ExpandingTableViewController {
        let toViewController: detailViewController = detailViewController()
        return toViewController
    }
    
    fileprivate func configureNavBar() {
        navigationItem.leftBarButtonItem?.image = navigationItem.leftBarButtonItem?.image!.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
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
        guard let cell = collectionView?.cellForItem(at: indexPath) as? DemoCollectionViewCell else { return }
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
        let indexpath = IndexPath(row: currentIndex, section: 0)
        let cell = collectionView?.cellForItem(at: indexpath)
        guard let c = cell as? DemoCollectionViewCell else { return }
        backgroundImageView.image = c.backgroundImageView.image
    }
    
}

// MARK: UICollectionViewDataSource
extension homeViewController {
    
    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        super.collectionView(collectionView, willDisplay: cell, forItemAt: indexPath)
        guard let cell = cell as? DemoCollectionViewCell else { return }
        
        let index = indexPath.row % items!.count
        let info = items?[index]
        let url = "\(self.base) \(info?.postal ?? "") \(".jpg?alt=media&token:")\(self.token)"
        cell.backgroundImageView?.load(url: URL.init(string: url)!)
        cell.customTitle.text = info?.name
        cell.cellIsOpen(cellsIsOpen[index], animated: false)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? DemoCollectionViewCell
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
        return items?.count ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: DemoCollectionViewCell.self), for: indexPath)
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
