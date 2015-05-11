//
//  NotificationTableViewController.m
//  Phileas_Gestion
//
//  Created by Romain on 06/05/2015.
//  Copyright (c) 2015 Florent&Romain. All rights reserved.
//

#import "NotificationTableViewController.h"

@implementation NotificationTableViewController

@synthesize context;
@synthesize utilisateur;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self->_appDelegate = [[UIApplication sharedApplication] delegate];
    context = self.appDelegate.managedObjectContext;
    
    [self loadFrais];
}

- (void) loadFrais
{
    [self chargerUtilisateur];

    NSURL *baseUrl = [[NSURL alloc] initWithString:@"https://app-phileas.dpinfo.fr"];
    RKObjectManager* objectManager = [RKObjectManager managerWithBaseURL:baseUrl];
    
    [objectManager.HTTPClient setAuthorizationHeaderWithUsername:utilisateur.pseudo password:utilisateur.mdp];
    
    RKObjectMapping *mapping = [RKObjectMapping mappingForClass:[Sheet class]];
    [mapping addAttributeMappingsFromArray:@[@"creation_date", @"latest_status_id", @"number"]];
    
    RKResponseDescriptor* responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:mapping method:RKRequestMethodGET pathPattern:nil keyPath:@"result" statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    
    [objectManager addResponseDescriptor:responseDescriptor];
    
    [objectManager getObjectsAtPath:@"api/sheet" parameters:nil
                            success:^(RKObjectRequestOperation *operation, RKMappingResult *result){
                                _frais = result.array;
                                [self.tableView reloadData];
                            }
                            failure:^(RKObjectRequestOperation *operation, NSError *error){
                                
                            }];

}

- (void) chargerUtilisateur
{
    // fetchedResultController initialization
    NSFetchRequest *requete = [[NSFetchRequest alloc] initWithEntityName:@"User"];
    // Configure the request's entity, and optionally its predicate.
    [requete setSortDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"pseudo" ascending:NO]]];
    
    NSError *erreur = nil;
    NSArray *resultat = [context executeFetchRequest:requete error:&erreur];
    if([resultat count] > 0)
    {
        utilisateur = [resultat objectAtIndex:0];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"liste" forIndexPath:indexPath];
    
    Sheet *sheet = _frais[indexPath.row];
    cell.textLabel.text = sheet.creation_date;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@", sheet.number];
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _frais.count;
}


@end

