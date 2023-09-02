//
//  Currency.h
//  MyCurrency
//
//  Created by Epimetheus on 18/08/23.
//

#ifndef Currency_h
#define Currency_h

@interface Currency : NSObject

@property (strong,nonatomic) NSString *name;
-(instancetype)initWithString:(NSString* )name;
-(id)copyWithZone:(NSZone *)zone;
+(NSArray*) getIds;
@end

#endif /* Currency_h */
