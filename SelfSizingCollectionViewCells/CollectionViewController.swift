//
//  CollectionViewController.swift
//  SelfSizingCollectionViewCells
//
//  Created by Daniel Galasko on 2016/02/16.
//  Copyright © 2016 Afrozaar. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

extension UIViewController {
    func reloadCollectionViewWithFontSizeChanges(collectionView: UICollectionView) {
        NSNotificationCenter.defaultCenter().addObserverForName(UIContentSizeCategoryDidChangeNotification,
            object: nil,
            queue: NSOperationQueue.mainQueue()) { (notification) -> Void in
                collectionView.reloadData()
        }
    }
}

class CollectionViewController: UICollectionViewController {

    struct Configuration {
        
    }
    
    var flowLayout: UICollectionViewFlowLayout {
        return self.collectionView?.collectionViewLayout as! UICollectionViewFlowLayout
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.flowLayout.estimatedItemSize = CGSizeMake(100, 100)
        self.collectionView!.registerClass(SimpleCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        reloadCollectionViewWithFontSizeChanges(collectionView!)
    }

    // MARK: UICollectionViewDataSource

    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 100
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! SimpleCell
        cell.label.text = "Hello World"
        return cell
    }
}
