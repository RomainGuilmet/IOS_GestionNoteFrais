//
//  IndemnitesTableViewController.h
//  Phileas_Gestion
//
//  Created by Romain on 27/04/2015.
//  Copyright (c) 2015 Florent&Romain. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "MapTableViewController.h"

@interface IndemnitesTableViewController : UITableViewController

@property (weak, nonatomic) IBOutlet UITableViewCell *departCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *arriveeCell;
@property (weak, nonatomic) IBOutlet UITextField *distanceTextField;
@property (weak, nonatomic) IBOutlet UITextField *montantTextField;

@property (strong, nonatomic) NSMutableArray *depart;
@property (strong, nonatomic) NSMutableArray *arrivee;

@end


//Enregistrer les indemnités dans un autre type de frais du coreData ???