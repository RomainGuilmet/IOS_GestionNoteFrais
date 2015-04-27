//
//  MapTableViewController.h
//  Phileas_Gestion
//
//  Created by Romain on 27/04/2015.
//  Copyright (c) 2015 Florent&Romain. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface MapTableViewController : UITableViewController <UISearchBarDelegate, UISearchDisplayDelegate>

@property (weak, nonatomic) IBOutlet UISearchBar *barreRecherche;

@property (strong, nonatomic) NSMutableArray *lieu;

@end
