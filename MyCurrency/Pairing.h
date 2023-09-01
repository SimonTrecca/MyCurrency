//
//  Pairing.h
//  MyCurrency
//
//  Created by Epimetheus on 19/08/23.
//

#ifndef Pairing_h
#define Pairing_h

#import "Currency.h"

@interface Pairing : NSObject

@property (strong,nonatomic) Currency *first;
@property (strong,nonatomic) Currency *second;
-(instancetype)initWithCurrency1:(Currency*)name1 andCurrency2:(Currency*)name2;

@end


#endif /* Pairing_h */
