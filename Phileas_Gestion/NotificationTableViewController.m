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
@synthesize listeFrais;
@synthesize listeMessages;

/**
 * @brief Cette fonction est appelée quand la vue est chargée par l'application.
 */
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // On initialise l'appDelegate et le context de l'application pour le coreData.
    self->_appDelegate = [[UIApplication sharedApplication] delegate];
    context = self.appDelegate.managedObjectContext;
    
    self.navBar.title = @"Notifications";
}

/**
 * @brief Cette fonction est appelée quand la vue apparaît.
 */
- (void) viewDidAppear:(BOOL)animated
{
    // Nous chargeons les frais d'un utilisateur
    //[self loadFrais];
    [self loadMessages];
}

#pragma mark - methods
/**
 * @brief Cette fonction sert à charger tous les frais disponible sur l'application web.
 * @brief Elle utilise la class sheet et la fonction sheet de l'api.
 */
- (void) loadFrais
{
    // Nous chargeons l'utilisateur connecté.
    [self chargerUtilisateur];

    // Nous préparons le manager RestKit avec l'url de l'application web et les données relatives à un utilisateur.
    NSURL *baseUrl = [[NSURL alloc] initWithString:@"https://app-phileas.dpinfo.fr"];
    RKObjectManager* objectManager = [RKObjectManager managerWithBaseURL:baseUrl];
    [objectManager.HTTPClient setAuthorizationHeaderWithUsername:utilisateur.pseudo password:utilisateur.mdp];
    
    // Nous préparons le manager avec les map RestKit de réponse pour notre objet.
    RKObjectMapping *mapping = [RKObjectMapping mappingForClass:[Sheet class]];
    [mapping addAttributeMappingsFromArray:@[@"creation_date", @"latest_status_id", @"object"]];
    RKResponseDescriptor* responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:mapping method:RKRequestMethodGET pathPattern:nil keyPath:@"result" statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    [objectManager addResponseDescriptor:responseDescriptor];
    
    // Nous exécutons la requête avec la fonction sheet de l'api Phileas.
    [objectManager getObjectsAtPath:@"api/sheet" parameters:nil
                            success:^(RKObjectRequestOperation *operation, RKMappingResult *result){
                                NSPredicate *predicate = [NSPredicate predicateWithFormat:@"latest_status_id != 3"];
                                listeFrais = [result.array filteredArrayUsingPredicate:predicate];
                                NSString* value = [NSString stringWithFormat:@"%li",(unsigned long)[listeFrais count]];
                                [[[[[self tabBarController] tabBar] items] objectAtIndex:2] setBadgeValue: value];
                                [self.tableView reloadData];
                            }
                            failure:^(RKObjectRequestOperation *operation, NSError *error){
                                
                            }];

}

- (void) loadMessages
{
    // Nous chargeons l'utilisateur connecté.
    [self chargerUtilisateur];
    
    // Nous préparons le manager RestKit avec l'url de l'application web et les données relatives à un utilisateur.
    NSURL *baseUrl = [[NSURL alloc] initWithString:@"https://app-phileas.dpinfo.fr"];
    RKObjectManager* objectManager = [RKObjectManager managerWithBaseURL:baseUrl];
    [objectManager.HTTPClient setAuthorizationHeaderWithUsername:utilisateur.pseudo password:utilisateur.mdp];
    
    // Nous préparons le manager avec les map RestKit de réponse pour notre objet.
    RKObjectMapping *mapping = [RKObjectMapping mappingForClass:[Message class]];
    [mapping addAttributeMappingsFromArray:@[@"message_title", @"message_body", @"created"]];
    RKResponseDescriptor* responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:mapping method:RKRequestMethodGET pathPattern:nil keyPath:@"result" statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    [objectManager addResponseDescriptor:responseDescriptor];
    
    // Nous exécutons la requête avec la fonction sheet de l'api Phileas.
    [objectManager getObjectsAtPath:@"api/message" parameters:nil
                            success:^(RKObjectRequestOperation *operation, RKMappingResult *result){
                                listeMessages = [result array];
                                NSString* value = [NSString stringWithFormat:@"%li",(unsigned long)[listeMessages count]];
                                [[[[[self tabBarController] tabBar] items] objectAtIndex:2] setBadgeValue: value];
                                [self.tableView reloadData];
                            }
                            failure:^(RKObjectRequestOperation *operation, NSError *error){
                                
                            }];
}

/**
 * @brief Cette fonction permet de charger les informations concernant l'utilisateur connecté.
 */
- (void) chargerUtilisateur
{
    NSFetchRequest *requete = [[NSFetchRequest alloc] initWithEntityName:@"User"];
    [requete setSortDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"pseudo" ascending:NO]]];
    
    NSError *erreur = nil;
    NSArray *resultat = [context executeFetchRequest:requete error:&erreur];
    if([resultat count] > 0)
    {
        utilisateur = [resultat objectAtIndex:0];
    }
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //return listeFrais.count;
    return listeMessages.count;
}

/**
 * @brief Cette fonction sert à configurer chaque ligne du tableView avec le numéro de la note de frais, sa date de création et son statut.
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //Sheet *sheet = listeFrais[indexPath.row];
    Message *msg = listeMessages[indexPath.row];
    NotificationCellule *cell = [tableView dequeueReusableCellWithIdentifier:@"liste" forIndexPath:indexPath];

    /*cell.objectLabel.text = sheet.object;
    cell.dateLabel.text = [NSString stringWithFormat:@"%@", sheet.creation_date];
    cell.statusLabel.text = [NSString stringWithFormat:@"%@", [sheet getLabelFromStatusId:sheet.latest_status_id]];*/
    
    cell.titreLabel.text = msg.message_title;
    cell.dateLabel.text = [NSString stringWithFormat:@"%@", msg.created];
    cell.msgLabel.text = [NSString stringWithFormat:@"%@", msg.message_body];
    
    
    return cell;
}



@end

