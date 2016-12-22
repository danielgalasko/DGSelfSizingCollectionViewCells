//
//  CollectionCellCollectionViewCell.m
//  SelfSizingCollectionViewCells
//
//  Created by Daniel Galasko on 9/17/14.
//  Copyright (c) 2014 Galasko. All rights reserved.
//

#import "CollectionViewCell.h"

@interface CollectionViewCell()
@property (weak, nonatomic) IBOutlet UILabel *textLabel;
@property (nonatomic, assign) CGSize cachedSize;
@end

@implementation CollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.cachedSize = CGSizeZero;
}

- (void)setText:(NSString *)text {
    self.cachedSize = CGSizeZero;
    self.textLabel.text = text;
}

- (NSString *)text {
    return self.textLabel.text;
}

//- (UICollectionViewLayoutAttributes *)preferredLayoutAttributesFittingAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes {
//    
//    UICollectionViewLayoutAttributes *attr = [layoutAttributes copy];
//    if (CGSizeEqualToSize(CGSizeZero, self.cachedSize)) {
//        self.frame = attr.frame;
//        [self setNeedsLayout];
//        [self layoutIfNeeded];
//        CGFloat fontSize = [UIFontDescriptor preferredFontDescriptorWithTextStyle:UIFontTextStyleHeadline].pointSize * 1.4;
//        self.textLabel.font = [UIFont fontWithName:[[UIFont fontNamesForFamilyName:self.textLabel.font.familyName] firstObject] size:fontSize];
//        CGSize size = [self.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
//        self.cachedSize = size;
//        CGRect newFrame = attr.frame;
//        newFrame.size = size;
//        attr.frame = newFrame;
//    }
//    return attr;
//}
@end
