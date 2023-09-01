//
//  FavoritesTableView.m
//  MyCurrency
//
//  Created by Epimetheus on 19/08/23.
//

#import <Foundation/Foundation.h>
#import "FavoritesTableView.h"
#import "CustomTableViewCell.h"
@interface FavoritesTableView()

@property (strong, nonatomic) IBOutlet UISearchBar *searchFavorites;


@end

@implementation FavoritesTableView

- (void)viewDidLoad {
    [super viewDidLoad];
    self.searchFavorites.delegate=self;
    self.filteredData=self.favorites;
    NSLog(@"sussy baka");
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.filteredData count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CustomTableViewCell *cell = (CustomTableViewCell*)[tableView dequeueReusableCellWithIdentifier:@"FavoriteCell" forIndexPath:indexPath];
    unsigned long i= indexPath.row;
    
    cell.first.text=self.filteredData[i].first.name;
    
    UIImage* countryFlag=[UIImage imageNamed:self.filteredData[i].first.name];
    [cell.imageFirst setImage:countryFlag];
    
    cell.second.text=self.filteredData[i].second.name;
    countryFlag=[UIImage imageNamed:self.filteredData[i].second.name];
    [cell.imageSecond setImage:countryFlag];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    unsigned long i= indexPath.row;
    self.currentPair.first=[[Currency alloc]initWithString:self.favorites[i].first.name];
    self.currentPair.second=[[Currency alloc]initWithString:self.favorites[i].second.name];    [self.navigationController popViewControllerAnimated:YES];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    NSLog(@"Amogus");
    self.filteredData=[[NSMutableArray alloc]init];
    
    unichar charToRemove = ' '; // Character to remove

    NSMutableString *modifiedString = [NSMutableString stringWithString:searchText];
    NSRange range = [modifiedString rangeOfString:[NSString stringWithCharacters:&charToRemove length:1]];

    while (range.location != NSNotFound) {
        [modifiedString deleteCharactersInRange:range];
        range = [modifiedString rangeOfString:[NSString stringWithCharacters:&charToRemove length:1]];
    }
    
    if([modifiedString isEqual:@""]){
        self.filteredData=self.favorites;
    }
    else{
        for(int i=0;i<[self.favorites count];i++){
            if([[[[self.favorites objectAtIndex:i]first]name] containsString:modifiedString]){
                [self.filteredData addObject:[self.favorites objectAtIndex:i]];
                NSLog(@"sus%d",i);
            }
        }
        
    }
    
    [self.tableView reloadData];
}

-(IBAction)dropKeyboard{
    if ([self.searchFavorites isFirstResponder])
        [self.searchFavorites resignFirstResponder];
}
    


@end

