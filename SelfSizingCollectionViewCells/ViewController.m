//
//  ViewController.m
//  SelfSizingCollectionViewCells
//
//  Created by Daniel Galasko on 9/17/14.
//  Copyright (c) 2014 Afrozaar. All rights reserved.
//

#import "ViewController.h"
#import "CollectionViewCell.h"

@interface ViewController ()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@end

@implementation ViewController
- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
        [(UICollectionViewFlowLayout *)self.collectionView.collectionViewLayout setEstimatedItemSize:CGSizeMake(size.width, 200)];
    [self reload];
}
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)reload {
    self.collectionView.dataSource = self;
    [self.collectionViewLayout invalidateLayout];
    [self.collectionView reloadData];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [(UICollectionViewFlowLayout *)self.collectionView.collectionViewLayout setEstimatedItemSize:CGSizeMake(CGRectGetWidth(self.view.bounds), 100)];
    [self reload];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reload) name:UIContentSizeCategoryDidChangeNotification object:nil];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"identifier" forIndexPath:indexPath];
    cell.textView.text = [self randomStringWithLength:arc4random_uniform(100)];
    return cell;
}

NSString *const letters = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
-(NSString *) randomStringWithLength: (int) len {
    
    NSMutableString *randomString = [NSMutableString stringWithCapacity: len];
    
    for (int i=0; i<len; i++) {
        [randomString appendFormat: @"%C", [letters characterAtIndex: arc4random_uniform([letters length]) % [letters length]]];
    }
    
    return randomString;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 10;
}

@end
