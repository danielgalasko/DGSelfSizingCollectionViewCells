
//  SimpleCell.swift
//  SelfSizingCollectionViewCells
//
//  Created by Daniel Galasko on 2016/02/16.
//  Copyright © 2016 Galasko. All rights reserved.
//

import UIKit

extension UILabel {
    
    func useSystemFont() {
        self.font = UIFont.preferredFont(forTextStyle: UIFontTextStyle.body)
    }
    
    func monitorFontSizeChanges() {
        NotificationCenter.default.addObserver(forName: NSNotification.Name.UIContentSizeCategoryDidChange, object: nil, queue: OperationQueue.main) {[weak self] (_) -> Void in
            self?.font = UIFont.preferredFont(forTextStyle: UIFontTextStyle.body)
        }
    }
}

class SimpleCellImplementingLayoutAttributes: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .blue
        contentView.layer.cornerRadius = 6
        contentView.clipsToBounds = true
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var desiredSize: CGSize = CGSize(width: 100, height: 100)
    
    // Without caching our size for preferredLayoutAttributesFittingAttributes it will get called multiple times and crash if we keep changing the frame
    var cachedSize: CGSize?
    
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        if let cachedSize = cachedSize, cachedSize.equalTo(desiredSize) {
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
        label.textAlignment = .right
        super.init(frame: frame)
        NotificationCenter.default.addObserver(forName: NSNotification.Name.UIContentSizeCategoryDidChange, object: nil, queue: OperationQueue.main) {[weak self] (_) -> Void in
            self?.label.useSystemFont()
            self?.isHeightCalculated = false
        }
        contentView.addSubview(label)
        let views = ["label" : label]
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[label(<=100)]-0-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[label(100)]-0-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
        
        contentView.backgroundColor = .white
    }
    
    //forces the system to do one layout pass
    var isHeightCalculated: Bool = false
    
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        //Exhibit A - We need to cache our calculation to prevent a crash.
        if !isHeightCalculated {
            setNeedsLayout()
            layoutIfNeeded()
            let size = contentView.systemLayoutSizeFitting(layoutAttributes.size)
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
