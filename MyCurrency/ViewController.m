//
//  ViewController.m
//  MyCurrency
//
//  Created by Epimetheus on 05/08/23.
//

#import "ViewController.h"
#import "Currency.h"
@interface ViewController ()
@property (strong, nonatomic) IBOutlet UILabel *Maurizio;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"Francesco Totti");
    self.counter= 0;
    self.moneta= [[Currency alloc]initWithString:@"EUR"];
}

- (IBAction)onClick{
    ++self.counter;
   // self.Maurizio.text= [NSString stringWithFormat:@"Ilary Blasi %d %@",self.counter, [self.moneta fullName]];
    if(self.counter==20)
    {
        NSLog(@"20 euro desturbo");
    }
        
}
    


@end
