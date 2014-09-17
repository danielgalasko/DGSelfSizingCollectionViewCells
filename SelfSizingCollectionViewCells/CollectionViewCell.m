//
//  CollectionCellCollectionViewCell.m
//  SelfSizingCollectionViewCells
//
//  Created by Daniel Galasko on 9/17/14.
//  Copyright (c) 2014 Afrozaar. All rights reserved.
//

#import "CollectionViewCell.h"

@implementation CollectionViewCell

- (CGSize)sizeThatFits:(CGSize)size {
    [self.textView sizeThatFits:CGSizeMake(CGRectGetWidth(self.bounds),CGFLOAT_MAX)];
    return CGSizeMake(100, self.textView.frame.size.height);
}

- (UICollectionViewLayoutAttributes *)preferredLayoutAttributesFittingAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes {
    UICollectionViewLayoutAttributes *attr = [layoutAttributes copy];
    UIFont *font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
    self.textView.text = self.textView.text;
    self.textView.font = font;
    CGSize size = [self.textView sizeThatFits:CGSizeMake(CGRectGetWidth(layoutAttributes.frame),CGFLOAT_MAX)];
    CGRect newFrame = attr.frame;
    newFrame.size.height = size.height;
    attr.frame = newFrame;
    return attr;
}
@end
