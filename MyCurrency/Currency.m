//
//  Currency.m
//  MyCurrency
//
//  Created by Epimetheus on 18/08/23.
//

#import <Foundation/Foundation.h>
#import "Currency.h"

@interface Currency()

@end
@implementation Currency

static NSArray *ids = @[@"EUR",@"USD",@"JPY",@"GBP",@"BRL",@"CAD",@"DKK",@"HKD",@"INR",@"MXN",@"TWD",@"NZD",@"NOK",@"PHP",@"PLN",@"ILS",@"SGD",@"SEK",@"CHF",@"THB"];

- (instancetype)initWithString:(NSString *)name
{
    if(self = [super init]){
    
        if([ids containsObject:name]){
            _name= [name copy];
        }
        else{
            return nil;
        }
    
    }
    return self;
}

-(NSString *)fullName
{
    if(!self){
        return @"Vuoto";
    }
    if([self.name isEqual:@"EUR"]) return @"EURO";
    
    return @"Aldo";
}

-(id)copyWithZone:(NSZone *)zone{
    return [[Currency alloc]initWithString:self.name];
}
+ (NSArray *)getIds{
    return ids;
}


@end


