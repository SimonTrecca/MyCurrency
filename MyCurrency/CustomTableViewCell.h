//
//  CustomTableViewCell.h
//  MyCurrency
//
//  Created by Epimetheus on 24/08/23.
//

#ifndef CustomTableViewCell_h
#define CustomTableViewCell_h

#import <UIKit/UIKit.h>

@interface CustomTableViewCell : UITableViewCell

@property (strong,nonatomic) IBOutlet UILabel* first;
@property (strong,nonatomic) IBOutlet UILabel* second;
@property (strong, nonatomic) IBOutlet UIImageView *imageFirst;
@property (strong, nonatomic) IBOutlet UIImageView *imageSecond;


@end
#endif /* CustomTableViewCell_h */
