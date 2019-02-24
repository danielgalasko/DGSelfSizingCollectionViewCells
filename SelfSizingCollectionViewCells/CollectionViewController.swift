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
        
        switch configuration.cellType {
        case .simpleCell:
            break
        case .layoutAttributesCell:
            let widths = Array(0 ..< collectionView(collectionView!, numberOfItemsInSection: 0)).map({ ($0 % 5) * 10 + 50 })
            generatedSizes = widths.map({ CGSize(width: CGFloat($0), height: 100)})
        case .simpleCellWithDynamicText:
            let indices = Array(0 ..< collectionView(collectionView!, numberOfItemsInSection: 0))
            generatedStrings = indices.map({ RandomStringGenerator.randomString(withLength: UInt(($0 % 5) + 4)) })
        }
    }

    // MARK: UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 100
    }
    
    var generatedStrings: [String] = []
    var generatedSizes: [CGSize] = []

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch configuration.cellType {
        case .simpleCell:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: SimpleCell.self), for: indexPath) as! SimpleCell
            cell.label.text = "Hello World"
            cell.isHeightCalculated = true
            return cell
        case .layoutAttributesCell:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: SimpleCellImplementingLayoutAttributes.self), for: indexPath) as! SimpleCellImplementingLayoutAttributes
            cell.desiredSize = generatedSizes[indexPath.item]
            return cell
        case .simpleCellWithDynamicText:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: SimpleCell.self), for: indexPath) as! SimpleCell
            cell.isHeightCalculated = false
            cell.label.text = generatedStrings[indexPath.item]
            return cell
        }
    }
}
