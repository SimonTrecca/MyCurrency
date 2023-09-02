//
//  CustomTableViewCell.h
//  MyCurrency
//
//  Created by Epimetheus on 24/08/23.
//


#import <UIKit/UIKit.h>

@interface FavoritesTableViewCell : UITableViewCell

@property (strong,nonatomic) IBOutlet UILabel* first;
@property (strong,nonatomic) IBOutlet UILabel* second;
@property (strong, nonatomic) IBOutlet UIImageView *imageFirst;
@property (strong, nonatomic) IBOutlet UIImageView *imageSecond;
@property (strong, nonatomic) IBOutlet UIButton *backButton;


@end

