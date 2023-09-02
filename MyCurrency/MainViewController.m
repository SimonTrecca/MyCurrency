//
//  MainViewController.m
//  MyCurrency
//
//  Created by Epimetheus on 18/08/23.
//

#import "MainViewController.h"
#import "Currency.h"
#import "Pairing.h"
#import "FavoritesTableViewController.h"
#import "StoricoTableViewController.h"
@interface MainViewController ()

@property (strong,nonatomic) IBOutlet UITextField *amount;
@property (strong,nonatomic) IBOutlet UITextField *results;
@property (strong, nonatomic) IBOutlet UIButton *currencyButton1;
@property (strong, nonatomic) IBOutlet UIButton *currencyButton2;
@property (strong, nonatomic) IBOutlet UIButton *favoritesButton;
@property (strong, nonatomic) IBOutlet UIButton *convertButton;


@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.results setEnabled:NO];
    
    [self.currencyButton1 setMenu:[self getCurrencyMenuForButton:self.currencyButton1]];
    
    
    [self.currencyButton2 setMenu:[self getCurrencyMenuForButton2:self.currencyButton2]];
    
    self.favorites=[[NSMutableArray alloc]init];
    
    
    self.currentPair= [[Pairing alloc]initWithCurrency1:[[Currency alloc]initWithString:@"EUR"] andCurrency2:[[Currency alloc]initWithString:@"USD"]];
    
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    UIImage* countryFlag=[UIImage imageNamed:self.currentPair.first.name];
    CGSize newSize = CGSizeMake(60, 45);
    countryFlag=[self setImageSize:countryFlag toSize:newSize];
    
    [self.currencyButton1 setTitle:self.currentPair.first.name forState:UIControlStateNormal];
    [self.currencyButton1 setImage:countryFlag forState:UIControlStateNormal];
    
    countryFlag=[UIImage imageNamed:self.currentPair.second.name];
    countryFlag=[self setImageSize:countryFlag toSize:newSize];
    
    [self.currencyButton2 setTitle:self.currentPair.second.name forState:UIControlStateNormal];
    [self.currencyButton2 setImage:countryFlag forState:UIControlStateNormal];
    
}


-(UIMenu*)getCurrencyMenuForButton:(UIButton*)button{
    
    NSMutableArray* actions= [[NSMutableArray alloc]init];
    
    unsigned long idsSize= [[Currency getIds]count];
    
    NSArray* savedIds = [Currency getIds];
    UIImage* countryFlag;
    
    for(int i=0;i<idsSize;i++){
        countryFlag=[UIImage imageNamed:savedIds[i]];
        CGSize newSize = CGSizeMake(60, 45);
        countryFlag=[self setImageSize:countryFlag toSize:newSize];
        UIAction *tmp= [UIAction actionWithTitle:savedIds[i] image:countryFlag identifier:nil handler:^(UIAction * _Nonnull action) {
            [button setTitle:savedIds[i] forState:UIControlStateNormal];
            [button setImage:countryFlag forState:UIControlStateNormal];
            self.currentPair.first=[[Currency alloc]initWithString:savedIds[i]];
        }];
        [actions addObject:tmp];
    }
        
    return [UIMenu menuWithTitle:@"Menu Title" children:actions];
}

-(UIMenu*)getCurrencyMenuForButton2:(UIButton*)button{
    
    NSMutableArray* actions= [[NSMutableArray alloc]init];
    
    unsigned long idsSize= [[Currency getIds]count];
    
    NSArray* savedIds = [Currency getIds];
    UIImage* countryFlag;
    
    for(int i=0;i<idsSize;i++){
        countryFlag=[UIImage imageNamed:savedIds[i]];
        CGSize newSize = CGSizeMake(60, 45);
        countryFlag=[self setImageSize:countryFlag toSize:newSize];
        UIAction *tmp= [UIAction actionWithTitle:savedIds[i] image:countryFlag identifier:nil handler:^(UIAction * _Nonnull action) {
            [button setTitle:savedIds[i] forState:UIControlStateNormal];
            [button setImage:countryFlag forState:UIControlStateNormal];
            self.currentPair.second=[[Currency alloc]initWithString:savedIds[i]];
        }];
        [actions addObject:tmp];
    }
        
    return [UIMenu menuWithTitle:@"Menu Title" children:actions];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:@"favoriteSegue"]) {
            if([segue.destinationViewController isKindOfClass:[FavoritesTableViewController class]]) {
                FavoritesTableViewController *fVC = (FavoritesTableViewController *)segue.destinationViewController;
                fVC.favorites = self.favorites;
                fVC.currentPair=self.currentPair;
            }
    }
    if([segue.identifier isEqualToString:@"historySegue"]) {
            if([segue.destinationViewController isKindOfClass:[StoricoTableViewController class]]) {
                StoricoTableViewController *sVC = (StoricoTableViewController *)segue.destinationViewController;
                sVC.currentPair=self.currentPair;
            }
    }
}


- (IBAction)onClickFavorite{

    for(int i=0;i<[self.favorites count];i++){
        if([[self.favorites objectAtIndex:i]equals:self.currentPair]){
            return;
        }
    }
    [self.favorites addObject:[self.currentPair copy]];
}

-(IBAction)onClickConvert{
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self disableAllButtons];
    });
    
    NSString *apiKey= @"cur_live_cVINr3drZrZGJK4Sbb7KKieWQlGNGaQHbVfdyl0p";
    NSString *urlString = [NSString stringWithFormat:@"https://api.currencyapi.com/v3/latest?apikey=%@&base_currency=%@&currencies=%@",apiKey,[self.currentPair.first name],[self.currentPair.second name]];
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLSession* session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (error) {
            NSLog(@"Error: %@", error);
            return;
        }
       
        NSDictionary *parsedDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
        NSDictionary *tmp= [parsedDictionary valueForKey:@"data"];
        tmp= [tmp valueForKey:self.currentPair.second.name];
        NSNumber* value= [tmp valueForKey:@"value"];
       
        self.currentExchange= [value doubleValue];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self updateTextFieldText];
            [self enableAllButtons];
        });

        }];
    
    [task resume];
}

-(void)updateTextFieldText{
    NSNumberFormatter* numberFormatter= [[NSNumberFormatter alloc]init];
    double calc= [[numberFormatter numberFromString:self.amount.text]doubleValue]*self.currentExchange;
    
    self.results.text=[NSString stringWithFormat:@"%lf",calc];
}

-(void)disableAllButtons{
    [self.currencyButton1 setEnabled:NO];
    [self.currencyButton2 setEnabled:NO];
    [self.favoritesButton setEnabled:NO];
    [self.convertButton setEnabled:NO];
}

-(void)enableAllButtons{
    [self.currencyButton1 setEnabled:YES];
    [self.currencyButton2 setEnabled:YES];
    [self.favoritesButton setEnabled:YES];
    [self.convertButton setEnabled:YES];
    
}

- (UIImage *)setImageSize:(UIImage *)originalImage toSize:(CGSize)newSize {
    UIGraphicsBeginImageContextWithOptions(newSize, NO, 1.0);
    [originalImage drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *resizedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return resizedImage;
}

-(IBAction)dropKeyboard{
    if ([self.amount isFirstResponder])
        [self.amount resignFirstResponder];
}

@end

