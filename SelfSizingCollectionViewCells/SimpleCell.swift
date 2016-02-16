
//  SimpleCell.swift
//  SelfSizingCollectionViewCells
//
//  Created by Daniel Galasko on 2016/02/16.
//  Copyright © 2016 Galasko. All rights reserved.
//

import UIKit

extension UILabel {
    
    func useSystemFont() {
        self.font = UIFont.preferredFontForTextStyle(UIFontTextStyleBody)
    }
    
    func monitorFontSizeChanges() {
        NSNotificationCenter.defaultCenter().addObserverForName(UIContentSizeCategoryDidChangeNotification, object: nil, queue: NSOperationQueue.mainQueue()) {[weak self] (_) -> Void in
            self?.font = UIFont.preferredFontForTextStyle(UIFontTextStyleBody)
        }
    }
}

class SimpleCellImplementingLayoutAttributes: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .blueColor()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var desiredSize: CGSize = CGSize(width: 100, height: 100)
    
    // Without caching our size for preferredLayoutAttributesFittingAttributes it will get called multiple times and crash if we keep changing the frame
    var cachedSize: CGSize?
    
    override func preferredLayoutAttributesFittingAttributes(layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        if let cachedSize = cachedSize where CGSizeEqualToSize(cachedSize, desiredSize) {
            return layoutAttributes
        }
        cachedSize = desiredSize
        var newFrame = layoutAttributes.frame
        newFrame.size = desiredSize
        layoutAttributes.frame = newFrame
        return layoutAttributes
    }
}

class SimpleCell: UICollectionViewCell {
    
    let label: UILabel
    
    override init(frame: CGRect) {
        label = UILabel(frame: frame)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.useSystemFont()
        label.textAlignment = .Right
        super.init(frame: frame)
        NSNotificationCenter.defaultCenter().addObserverForName(UIContentSizeCategoryDidChangeNotification, object: nil, queue: NSOperationQueue.mainQueue()) {[weak self] (_) -> Void in
            self?.label.useSystemFont()
            self?.isHeightCalculated = false
        }
        contentView.addSubview(label)
        let views = ["label" : label]
        contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[label(<=100)]-0-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
        contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-0-[label(100)]-0-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
        
        contentView.backgroundColor = .whiteColor()
    }
    
    //forces the system to do one layout pass
    var isHeightCalculated: Bool = false
    
    override func preferredLayoutAttributesFittingAttributes(layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        //Exhibit A - We need to cache our calculation to prevent a crash.
        if !isHeightCalculated {
            setNeedsLayout()
            layoutIfNeeded()
            let size = contentView.systemLayoutSizeFittingSize(layoutAttributes.size)
            var newFrame = layoutAttributes.frame
            newFrame.size.width = CGFloat(ceilf(Float(size.width)))
            layoutAttributes.frame = newFrame
            isHeightCalculated = true
        }
        return layoutAttributes
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
