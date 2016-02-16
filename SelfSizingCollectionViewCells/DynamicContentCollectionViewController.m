//
//  ViewController.m
//  SelfSizingCollectionViewCells
//
//  Created by Daniel Galasko on 9/17/14.
//  Copyright (c) 2014 Afrozaar. All rights reserved.
//

#import "DynamicContentCollectionViewController.h"
#import "CollectionViewCell.h"
#import "SelfSizingCollectionViewCells-Swift.h"
#import "RandomStringGenerator.h"

NSUInteger const kNumberOfCells = 100;
/// Tweak these and watch it break
NSUInteger const kMinStringLength = 5;
NSUInteger const kMaxStringLength = 10;

@interface DynamicContentCollectionViewController ()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (strong,nonatomic) NSMutableArray *array;
@end

@implementation DynamicContentCollectionViewController

#pragma mark - View Lifecycle -

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.array removeAllObjects];
    for (int i = 0; i < kNumberOfCells; ++i) {
        [self.array addObject:[RandomStringGenerator randomStringWithLength:MAX(kMinStringLength,arc4random_uniform(kMaxStringLength))]];
    }
    [self.collectionView registerClass:[SimpleCell class] forCellWithReuseIdentifier:NSStringFromClass([SimpleCell class])];
    self.collectionView.dataSource = self;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reload) name:UIContentSizeCategoryDidChangeNotification object:nil];
    [self setEstimatedSizeIfNeeded];
}

- (void)setEstimatedSizeIfNeeded {
    UICollectionViewFlowLayout *flowLayout = (UICollectionViewFlowLayout *)self.collectionView.collectionViewLayout;
    CGFloat estimatedWidth = 30.f;
    if (flowLayout.estimatedItemSize.width != estimatedWidth) {
        [flowLayout setEstimatedItemSize:CGSizeMake(estimatedWidth, 100)];
        [flowLayout invalidateLayout];
    }
}

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
    [coordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
        
    } completion:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
        [self.collectionViewLayout invalidateLayout];
        [self.collectionView reloadData];
    }];
}
#pragma mark - UICollectionViewDataSource -
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"identifier" forIndexPath:indexPath];
    cell.text = _array[indexPath.row];
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

- (void)reload {
    [self setEstimatedSizeIfNeeded];
    [self.collectionView reloadData];
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

@end
