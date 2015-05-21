//
//  ViewController.m
//  SelfSizingCollectionViewCells
//
//  Created by Daniel Galasko on 9/17/14.
//  Copyright (c) 2014 Afrozaar. All rights reserved.
//

#import "ViewController.h"
#import "CollectionViewCell.h"

NSUInteger const kNumberOfCells = 100;
NSUInteger const kMinStringLength = 1;
NSUInteger const kMaxStringLength = 5;

@interface ViewController ()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (strong,nonatomic) NSMutableArray *array;
@end

@implementation ViewController

- (void)reload {
    [self.array removeAllObjects];
    for (int i = 0; i < kNumberOfCells; ++i) {
        [self.array addObject:[self randomStringWithLength:MAX(kMinStringLength,arc4random_uniform(kMaxStringLength))]];
    }
    self.collectionView.dataSource = self;
    [self.collectionView reloadData];
    [self.collectionView.collectionViewLayout invalidateLayout];
}
#pragma mark - View Lifecycle -

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reload) name:UIContentSizeCategoryDidChangeNotification object:nil];
    [self reload];
    [self setEstimatedSizeIfNeeded];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    [self setEstimatedSizeIfNeeded];
}

- (void)setEstimatedSizeIfNeeded {
    UICollectionViewFlowLayout *flowLayout = (UICollectionViewFlowLayout *)self.collectionView.collectionViewLayout;
    CGFloat estimatedWidth = 100.f;
    if (flowLayout.estimatedItemSize.width != estimatedWidth) {
        [flowLayout setEstimatedItemSize:CGSizeMake(estimatedWidth, 100)];
        [flowLayout invalidateLayout];
    }
}
#pragma mark - UICollectionViewDataSource -
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"identifier" forIndexPath:indexPath];
    cell.textLabel.text = _array[indexPath.row];
    return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _array.count;
}

#pragma mark - Convenience =
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (NSMutableArray *)array {
    if (!_array) {
        _array = [NSMutableArray array];
    }
    return _array;
}

NSString *const letters = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
- (NSString *) randomStringWithLength: (NSUInteger) len {
    NSMutableString *randomString = [NSMutableString stringWithCapacity: len];
    for (NSUInteger i=0; i<len; i++) {
        [randomString appendFormat: @"%C", [letters characterAtIndex: arc4random_uniform((uint32_t)[letters length]) % [letters length]]];
    }
    return randomString;
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

@end
