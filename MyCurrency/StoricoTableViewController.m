//
//  StoricoTableViewController.m
//  MyCurrency
//
//  Created by Epimetheus on 19/08/23.
//

#import <Foundation/Foundation.h>
#import "StoricoTableViewController.h"
#import "StoricoTableViewCell.h"

@interface StoricoTableViewController()

@property (strong, nonatomic) IBOutlet UILabel *first;
@property (strong, nonatomic) IBOutlet UILabel *second;
@property (strong, nonatomic) IBOutlet UIImageView *firstImage;
@property (strong, nonatomic) IBOutlet UIImageView *secondImage;



@end

@implementation StoricoTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.requestsMade=0;
    self.historyExchanges= [NSMutableArray arrayWithArray: @[@0,@0,@0,@0,@0,@0,@0]];
    for(int i=0;i<7;i++){
        [self getCurrentExchange:i];
    }
    self.first.text=self.currentPair.first.name;
    UIImage* countryFlag=[UIImage imageNamed:self.currentPair.first.name];
    [self.firstImage setImage:countryFlag];
    
    self.second.text=self.currentPair.second.name;
    countryFlag=[UIImage imageNamed:self.currentPair.second.name];
    [self.secondImage setImage:countryFlag];
   
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
   
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 7;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    StoricoTableViewCell *cell = (StoricoTableViewCell*)[tableView dequeueReusableCellWithIdentifier:@"StoricoCell" forIndexPath:indexPath];
    unsigned long i= indexPath.row;
    NSString* dateString= [self getDate:i];
    
    cell.exchange.text= [NSString stringWithFormat:@"%lf",[[self.historyExchanges objectAtIndex:i] doubleValue]];
    cell.dateLabel.text=dateString;
    
   
    
    return cell;
}

-(void)getCurrentExchange:(int)atIndex{
    NSString *apiKey= @"cur_live_cVINr3drZrZGJK4Sbb7KKieWQlGNGaQHbVfdyl0p";
    
    NSString* dateString= [self getDate:atIndex];

    
    NSString *urlString = [NSString stringWithFormat:@"https://api.currencyapi.com/v3/historical?apikey=%@&base_currency=%@&currencies=%@&date=%@",apiKey,[self.currentPair.first name],[self.currentPair.second name],dateString];
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLSession* session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
       
        NSDictionary *parsedDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
        NSDictionary *tmp= [parsedDictionary valueForKey:@"data"];
        tmp= [tmp valueForKey:self.currentPair.second.name];
        NSNumber* value= [tmp valueForKey:@"value"];
        if(value==nil){
            value=@4000;
        }
        self.historyExchanges[atIndex]=value;
        
        self.requestsMade++;
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.storicoTableView reloadData];
            
        });
        
        }];
    
    [task resume];
}

-(NSString*)getDate:(unsigned long)index{
    NSDate *originalDate = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];

    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    [dateComponents setDay:-index-1];
    
    NSDate *modifiedDate = [calendar dateByAddingComponents:dateComponents toDate:originalDate options:0];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    
    return [dateFormatter stringFromDate:modifiedDate];
}


@end
