//
//  HistoriqueTableViewController.h
//  Phileas_Gestion
//
//  Created by Romain on 23/04/2015.
//  Copyright (c) 2015 Florent&Romain. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "Frais+DataModel.h"

@interface HistoriqueTableViewController : UITableViewController <NSFetchedResultsControllerDelegate>

@property (weak, nonatomic) AppDelegate* appDelegate;
@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSIndexPath *selectedFactions;


@end