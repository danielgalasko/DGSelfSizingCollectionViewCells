//
//  CollectionViewController.swift
//  SelfSizingCollectionViewCells
//
//  Created by Daniel Galasko on 2016/02/16.
//  Copyright © 2016 Galasko. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

extension UIViewController {
    func reloadCollectionViewWithFontSizeChanges(_ collectionView: UICollectionView) {
        NotificationCenter.default.addObserver(forName: NSNotification.Name.UIContentSizeCategoryDidChange,
            object: nil,
            queue: OperationQueue.main) { (notification) -> Void in
                collectionView.reloadData()
        }
    }
}

class CollectionViewController: UICollectionViewController {

    struct Configuration {
        
        enum CellType {
            case simpleCell
            case layoutAttributesCell
            case simpleCellWithDynamicText
        }
        
        let cellType: CellType
        
    }
    
    var configuration: Configuration = Configuration(cellType: .simpleCell)
    
    var flowLayout: UICollectionViewFlowLayout {
        return self.collectionView?.collectionViewLayout as! UICollectionViewFlowLayout
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.flowLayout.estimatedItemSize = CGSize(width: 100, height: 100)
        self.collectionView!.register(SimpleCell.self, forCellWithReuseIdentifier: String(describing: SimpleCell.self))
        self.collectionView!.register(SimpleCellImplementingLayoutAttributes.self, forCellWithReuseIdentifier: String(describing: SimpleCellImplementingLayoutAttributes.self))
        reloadCollectionViewWithFontSizeChanges(collectionView!)
    }

    // MARK: UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 100
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch configuration.cellType {
        case .simpleCell:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: SimpleCell.self), for: indexPath) as! SimpleCell
            cell.label.text = "Hello World"
            cell.isHeightCalculated = true
            return cell
        case .layoutAttributesCell:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: SimpleCellImplementingLayoutAttributes.self), for: indexPath) as! SimpleCellImplementingLayoutAttributes
            let mod = (indexPath.row % 5)
            let width = (mod * 10 + 50)
            cell.desiredSize = CGSize(width: width , height: 100)
            return cell
        case .simpleCellWithDynamicText:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: SimpleCell.self), for: indexPath) as! SimpleCell
            let mod = (indexPath.row % 5)
            cell.isHeightCalculated = false
            cell.label.text = RandomStringGenerator.randomString(withLength: UInt(mod + 4))
            return cell
        }
    }
}
