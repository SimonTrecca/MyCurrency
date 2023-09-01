//
//  StoricoTableViewController.h
//  MyCurrency
//
//  Created by Epimetheus on 19/08/23.
//

#ifndef StoricoTableViewController_h
#define StoricoTableViewController_h


#import <UIKit/UIKit.h>
#import "Pairing.h"
#import "Currency.h"

@interface StoricoTableViewController : UITableViewController

@property(strong,nonatomic) NSArray *storico;
@property(strong,nonatomic) Pairing* currentPair;
@property NSMutableArray<NSNumber*>* historyExchanges;
@property (strong, nonatomic) IBOutlet UITableView *storicoTableView;
@property int requestsMade;

@end

#endif /* StoricoTableViewController_h */
