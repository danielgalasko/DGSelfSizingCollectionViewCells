//
//  CollectionCellCollectionViewCell.m
//  SelfSizingCollectionViewCells
//
//  Created by Daniel Galasko on 9/17/14.
//  Copyright (c) 2014 Afrozaar. All rights reserved.
//

#import "CollectionViewCell.h"

@implementation CollectionViewCell

- (UICollectionViewLayoutAttributes *)preferredLayoutAttributesFittingAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes {
    UICollectionViewLayoutAttributes *attr = [layoutAttributes copy];
    self.frame = attr.frame;
    [self setNeedsLayout];
    [self layoutIfNeeded];
    CGFloat fontSize = [UIFontDescriptor preferredFontDescriptorWithTextStyle:UIFontTextStyleHeadline].pointSize * 1.4;
    self.textLabel.font = [UIFont fontWithName:[[UIFont fontNamesForFamilyName:self.textLabel.font.familyName] firstObject] size:fontSize];
    CGSize size = [self.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    CGRect newFrame = attr.frame;
    newFrame.size = size;
    attr.frame = newFrame;
    return attr;
}
@end
