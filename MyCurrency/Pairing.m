//
//  Pairing.m
//  MyCurrency
//
//  Created by Epimetheus on 19/08/23.
//

#import <Foundation/Foundation.h>
#import "Pairing.h"

@interface Pairing()

@end
@implementation Pairing

- (instancetype)initWithCurrency1:(Currency*)name1 andCurrency2:(Currency*)name2
{
    if(self = [super init]){
    
        _first= [name1 copy];
        _second= [name2 copy];
        
    }
    return self;
    
}

-(id)copyWithZone:(NSZone *)zone{
    return [[Pairing alloc]initWithCurrency1:self.first andCurrency2:self.second];
}

-(bool)equals:(Pairing*)other{
    if([[[self first]name]isEqualToString:[[other first]name]] && [[[self second]name]isEqualToString:[[other second]name]]){
        return true;
    }
    return false;
}

@end
