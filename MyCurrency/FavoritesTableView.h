//
//  FavoritesTableView.h
//  MyCurrency
//
//  Created by Epimetheus on 19/08/23.
//


#ifndef FavoritesTableView_h
#define FavoritesTableView_h

#import <UIKit/UIKit.h>
#import "Pairing.h"
#import "Currency.h"

@interface FavoritesTableView : UITableViewController<UISearchBarDelegate>

@property(strong,nonatomic) NSMutableArray<Pairing*> *favorites;
@property(strong,nonatomic) NSMutableArray<Pairing*> *filteredData;
@property(strong, nonatomic) Pairing* currentPair;


@end
#endif /* FavoritesTableView_h */
