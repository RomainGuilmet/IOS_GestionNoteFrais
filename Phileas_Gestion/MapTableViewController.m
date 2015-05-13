//
//  MapTableViewController.m
//  Phileas_Gestion
//
//  Created by Florent on 24/04/2015.
//  Copyright (c) 2015 Florent&Romain. All rights reserved.
//

#import "MapTableViewController.h"

@implementation MapTableViewController{
    MKLocalSearch * localSearch;
    MKLocalSearchResponse *results;
}

@synthesize lieu;

/**
 * @brief Cette fonction est appelée quand la vue est chargée par l'application.
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.barreRecherche setDelegate:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

/**
 * @brief Cette fonction permet de rechercher un lieu à chaque fois que le texte champ dans la barre de recherhe.
 */
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    
    if (![searchBar.text isEqualToString:@""])
    {
        [localSearch cancel];
    
        MKLocalSearchRequest *request = [[MKLocalSearchRequest alloc] init];
        request.naturalLanguageQuery = searchBar.text;
    
        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
        localSearch = [[MKLocalSearch alloc] initWithRequest:request];
    
        [localSearch startWithCompletionHandler:^(MKLocalSearchResponse *response, NSError *error){
        
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        
            if (error != nil) {
                [[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Map Error",nil)
                                            message:[error localizedDescription]
                                           delegate:nil
                                  cancelButtonTitle:NSLocalizedString(@"OK",nil) otherButtonTitles:nil] show];
                return;
            }
        
            if ([response.mapItems count] == 0) {
                [[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"No Results",nil)
                                            message:nil
                                           delegate:nil
                                  cancelButtonTitle:NSLocalizedString(@"OK",nil) otherButtonTitles:nil] show];
                return;
            }
        
            results = response;

            [self.searchDisplayController.searchResultsTableView reloadData];
        }];
    }
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [results.mapItems count];
}

/**
 * @brief Cette fonction permet de configurer les lignes du tableView avec les résultats de la recherche.
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *IDENTIFIER = @"SearchResultsCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:IDENTIFIER];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:IDENTIFIER];
    }
    
    MKMapItem *item = results.mapItems[indexPath.row];
    
    cell.textLabel.text = item.name;
    cell.detailTextLabel.text = item.placemark.addressDictionary[@"Street"];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    MKMapItem *item = results.mapItems[indexPath.row];
    if([self.lieu count]>0)
    {
        [self.lieu removeObjectAtIndex:0];
    }
    [self.lieu addObject:item];
    [self.navigationController popViewControllerAnimated:YES];
}

@end
