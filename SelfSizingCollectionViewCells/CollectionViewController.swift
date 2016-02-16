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
        
        enum CellType {
            case SimpleCell
            case LayoutAttributesCell
        }
        
        let cellType: CellType
        
    }
    
    var configuration: Configuration = Configuration(cellType: .SimpleCell)
    
    var flowLayout: UICollectionViewFlowLayout {
        return self.collectionView?.collectionViewLayout as! UICollectionViewFlowLayout
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.flowLayout.estimatedItemSize = CGSizeMake(100, 100)
        self.collectionView!.registerClass(SimpleCell.self, forCellWithReuseIdentifier: String(SimpleCell.self))
        self.collectionView!.registerClass(SimpleCellImplementingLayoutAttributes.self, forCellWithReuseIdentifier: String(SimpleCellImplementingLayoutAttributes.self))
        reloadCollectionViewWithFontSizeChanges(collectionView!)
    }

    // MARK: UICollectionViewDataSource

    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 100
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        switch configuration.cellType {
        case .SimpleCell:
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier(String(SimpleCell.self), forIndexPath: indexPath) as! SimpleCell
            cell.label.text = "Hello World"
            return cell
        case .LayoutAttributesCell:
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier(String(SimpleCellImplementingLayoutAttributes.self), forIndexPath: indexPath) as! SimpleCellImplementingLayoutAttributes
            let mod = (indexPath.row % 5)
            let width = (mod * 10 + 50)
            cell.desiredSize = CGSize(width: width , height: 100)
            return cell
        }
    }
}
