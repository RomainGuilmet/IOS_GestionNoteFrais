//
//  NotificationTableViewController.h
//  Phileas_Gestion
//
//  Created by Romain on 06/05/2015.
//  Copyright (c) 2015 Florent&Romain. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "Sheet.h"
#import "NotificationCellule.h"

@interface NotificationTableViewController : UITableViewController

@property (strong, nonatomic) NSArray* frais;

@property (weak, nonatomic) AppDelegate* appDelegate;
@property (weak, nonatomic) NSManagedObjectContext *context;
@property (strong, nonatomic) User* utilisateur;

- (void) loadFrais;
@end
