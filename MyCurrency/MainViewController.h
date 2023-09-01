//
//  MainViewController.h
//  MyCurrency
//
//  Created by Epimetheus on 18/08/23.
//


#import <UIKit/UIKit.h>
#import "Currency.h"
#import "Pairing.h"
@interface MainViewController : UIViewController

@property int counter;

@property(strong,nonatomic) NSMutableArray<Pairing*> *favorites;
@property(strong,nonatomic) Pairing* currentPair;
@property double currentExchange;


@end

