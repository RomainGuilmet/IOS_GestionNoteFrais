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

// ===== Variables =====
/**
 * @brief Un tableau contenant la liste des villes possibles répondant à la recherche.
 */
@property (strong, nonatomic) NSMutableArray *lieu;

// ===== Outlets =====
@property (weak, nonatomic) IBOutlet UISearchBar *barreRecherche;

@end
