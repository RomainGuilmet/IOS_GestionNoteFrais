//
//  HistoriqueTableViewController.m
//  Phileas_Gestion
//
//  Created by Romain on 23/04/2015.
//  Copyright (c) 2015 Florent&Romain. All rights reserved.
//

#import "HistoriqueTableViewController.h"

@implementation HistoriqueTableViewController

@synthesize context;

/**
 * @brief Cette fonction est appelée quand la vue est chargée par l'application.
 */
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // On initialise l'appDelegate et le context de l'application pour le coreData.
    self->_appDelegate = [[UIApplication sharedApplication] delegate];
    context = self.appDelegate.managedObjectContext;
    
    // Nous chargeons la liste de tous les brouillons enregistrés dans l'application.
    [self chargerListeFrais];
    
    self.navBar.title = @"Brouillons en cours";
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [[self.fetchedResultsController sections] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *sections = [self.fetchedResultsController sections];
    id<NSFetchedResultsSectionInfo> sectionInfo = [sections objectAtIndex:section];
    return [sectionInfo numberOfObjects];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"cellule";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    [self configureCell:cell atIndexPath:indexPath];
    return cell;
}

#pragma mark - FetchResultDelegate

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller {
    [self.tableView beginUpdates];
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    [self.tableView endUpdates];
}

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath {
    switch (type) {
        case NSFetchedResultsChangeInsert: {
            [self.tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
        }
        case NSFetchedResultsChangeDelete: {
            [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
        }
        case NSFetchedResultsChangeUpdate: {
            [self configureCell:(UITableViewCell *)[self.tableView cellForRowAtIndexPath:indexPath] atIndexPath:indexPath];
            break;
        }
        case NSFetchedResultsChangeMove: {
            [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            [self.tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
        }
    }
}

// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete){
        [context deleteObject:[self.fetchedResultsController objectAtIndexPath:indexPath]];
        
        NSError *erreur = nil;
        if(![context save:&erreur]){
            NSLog(@"Impossible de sauvegarder ! %@ %@", erreur, [erreur localizedDescription]);
        }
    }
}

#pragma mark - Helper methods
/**
 * @brief Cette fonction permet de configurer chaque ligne du tableView avec la date et le type de chaque brouillon sauvegardé en local.
 */
- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    Frais *frais = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    NSDateFormatter *dateformater=[[NSDateFormatter alloc]init];
    [dateformater setDateFormat:@"dd/MM/yyyy"];
    NSString *date = [dateformater stringFromDate:frais.date];
    NSString *texte = [NSString stringWithFormat:@"%@ - %@", date, frais.typeFrais.lib];
    [cell.textLabel setText:texte];
}

/**
 * @brief Cette fonction permet de changer la page active vers la page de frais au clic sur une ligne de la tableView.
 * @brief Nous passons en paramètres du controller frais, le frais sélectionné pour que nous puissons le modifier.
 */
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([[segue identifier] isEqualToString:@"modifierFrais"]){
        Frais *fraisChoisi = [self.fetchedResultsController objectAtIndexPath:[self.tableView indexPathForSelectedRow]];
        FraisTableViewController *controllerDestination = segue.destinationViewController;
        controllerDestination.fraisChoisi = fraisChoisi;
    }
}

#pragma mark - methods

/**
 * @brief Cette fonction permet de charger la liste des brouillons enregistrés dans le coreData.
 */
- (void) chargerListeFrais
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Frais"];

    [fetchRequest setSortDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"date" ascending:NO]]];
    self.fetchedResultsController = [[NSFetchedResultsController alloc]
                                     initWithFetchRequest:fetchRequest
                                     managedObjectContext:self.appDelegate.managedObjectContext
                                     sectionNameKeyPath:nil
                                     cacheName:nil];

    [self.fetchedResultsController setDelegate:self];
    NSError *error;
    [self.fetchedResultsController performFetch:&error];
    if (error) {
        NSLog(@"Unable to perform fetch.");
        NSLog(@"%@, %@", error, error.localizedDescription);
    }
}

@end
