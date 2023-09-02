//
//  FavoritesTableView.m
//  MyCurrency
//
//  Created by Epimetheus on 19/08/23.
//

#import <Foundation/Foundation.h>
#import "FavoritesTableViewController.h"
#import "FavoritesTableViewCell.h"
@interface FavoritesTableViewController()

@property (strong, nonatomic) IBOutlet UISearchBar *searchFavorites;


@end

@implementation FavoritesTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.searchFavorites.delegate=self;
    self.filteredData=self.favorites;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.filteredData count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    FavoritesTableViewCell *cell = (FavoritesTableViewCell*)[tableView dequeueReusableCellWithIdentifier:@"FavoriteCell" forIndexPath:indexPath];
    unsigned long i= indexPath.row;
    
    cell.first.text=self.filteredData[i].first.name;
    
    UIImage* countryFlag=[UIImage imageNamed:self.filteredData[i].first.name];
    [cell.imageFirst setImage:countryFlag];
    
    cell.second.text=self.filteredData[i].second.name;
    countryFlag=[UIImage imageNamed:self.filteredData[i].second.name];
    [cell.imageSecond setImage:countryFlag];
    [cell.backButton addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];

    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    unsigned long i= indexPath.row;
    self.currentPair.first=[[Currency alloc]initWithString:self.favorites[i].first.name];
    self.currentPair.second=[[Currency alloc]initWithString:self.favorites[i].second.name];    [self.navigationController popViewControllerAnimated:YES];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    self.filteredData=[[NSMutableArray alloc]init];
    
    unichar charToRemove = ' ';

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
            
            NSString *name = [[[[self.favorites objectAtIndex:i]first] name] lowercaseString];
            NSString *modifiedStringLower = [modifiedString lowercaseString];

            NSRange range = [name rangeOfString:modifiedStringLower options:NSCaseInsensitiveSearch];

            if (range.location != NSNotFound) {
                [self.filteredData addObject:[self.favorites objectAtIndex:i]];
            }
        }
        
    }
    
    [self.tableView reloadData];
}

- (void)buttonClicked:(UIButton *)sender {
    CGPoint buttonPosition = [sender convertPoint:CGPointZero toView:self.tableView];
    NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:buttonPosition];

    
    if (indexPath) {
        NSLog(@"Button in cell at indexPath section %ld, row %ld clicked", (long)indexPath.section, (long)indexPath.row);
        FavoritesTableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
        NSString* first=cell.first.text;
        NSString* second=cell.second.text;
        
        Currency* tmp1= [[Currency alloc]initWithString:first];
        Currency* tmp2= [[Currency alloc]initWithString:second];
        Pairing* tmp= [[Pairing alloc]initWithCurrency1:tmp1 andCurrency2:tmp2];
        [self.filteredData removeObjectAtIndex:indexPath.row];
        for(int i=0;i<[self.favorites count];i++){
            if([[self.favorites objectAtIndex:i]equals:tmp]){
                [self.favorites removeObjectAtIndex:i];
            }
        }
        [self.tableView reloadData];
    }
}

@end

