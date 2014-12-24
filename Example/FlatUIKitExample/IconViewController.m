//
//  IconViewController.m
//  FlatUIKitExample
//
//  Created by Jamie Matthews on 12/24/14.
//
//

#import "IconViewController.h"
#import "FlatUIKit.h"
#import "NSString+Icons.h"

@implementation IconViewController{
    UICollectionView *_collectionView;
    NSArray *unicodeStrings;
    NSArray *colorArray;
}

-(void)viewDidLoad{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor cloudsColor];
    self.navigationController.navigationBar.translucent = NO;
    UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc] init];
    _collectionView=[[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    [_collectionView setDataSource:self];
    [_collectionView setDelegate:self];
    [_collectionView setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cellIdentifier"];
    [_collectionView setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:_collectionView];
    
    [self.view addConstraints:[NSLayoutConstraint
                               constraintsWithVisualFormat:@"H:|-0-[_collectionView]-0-|"
                               options:NSLayoutFormatDirectionLeadingToTrailing
                               metrics:nil
                               views:NSDictionaryOfVariableBindings(_collectionView)]];
    [self.view addConstraints:[NSLayoutConstraint
                               constraintsWithVisualFormat:@"V:|-0-[_collectionView]-0-|"
                               options:NSLayoutFormatDirectionLeadingToTrailing
                               metrics:nil
                               views:NSDictionaryOfVariableBindings(_collectionView)]];
    
    // loop over all of the icon string values
    unicodeStrings = [NSString iconUnicodeStrings];
    // use a few different colors to show how these icons can be styled
    colorArray = @[[UIColor turquoiseColor], [UIColor emerlandColor], [UIColor peterRiverColor], [UIColor amethystColor], [UIColor sunflowerColor], [UIColor carrotColor], [UIColor alizarinColor]];
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [unicodeStrings count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"cellIdentifier" forIndexPath:indexPath];
    if(!cell){
        
    }
    else{
        [[cell.contentView viewWithTag:100] removeFromSuperview];
    }

    UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, cell.bounds.size.width, cell.bounds.size.height)];
    title.font = [UIFont iconFontWithSize:16];
    title.textAlignment = NSTextAlignmentCenter;
    title.text = [unicodeStrings objectAtIndex:indexPath.row];
    title.tag = 100;
    title.textColor = [colorArray objectAtIndex:indexPath.row%[colorArray count]];
    [cell.contentView addSubview:title];
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(50, 50);
}

@end
