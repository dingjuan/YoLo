//
//  homeViewController.swift
//  YoLoBoo
//
//  Created by Jennie Ding on 12/26/20.
//  Copyright © 2020 Juan Ding. All rights reserved.
//

import UIKit
import AnimatedCollectionViewLayout

private let reuseIdentifier = "Cell"

class homeViewController: UICollectionViewController {
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        // Turn on the paging mode for auto snaping support.
        collectionView?.isPagingEnabled = true
        
       
        // Do any additional setup after loading the view.
    }
}

extension homeViewController: UICollectionViewDelegateFlowLayout {
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Int(Int16.max)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let c = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath)
        
        if let cell = c as? homeCollectionViewCell {
            let i = indexPath.row % vcs.count
            let v = vcs[i]
            cell.bind(color: v.0, imageName: v.1)
            cell.clipsToBounds = animator?.1 ?? true
        }
        
        return c
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let animator = animator else { return view.bounds.size }
        return CGSize(width: view.bounds.width / CGFloat(animator.2), height: view.bounds.height / CGFloat(animator.3))
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}




