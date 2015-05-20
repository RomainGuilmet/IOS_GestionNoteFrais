//
//  HistoriqueTableViewController.m
//  Phileas_Gestion
//
//  Created by Florent&Romain on 23/04/2015.
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

/**
 * @brief Cette fonction est appelée quand la vue apparaît.
 */
- (void) viewDidAppear:(BOOL)animated
{
    [self mettreAJourBoutons];
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

#pragma mark - UITableViewDelegate
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

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self mettreAJourBoutons];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if(self.tableView.editing)
    {
        [self mettreAJourBoutonSupprimer];
    }
    else
    {
        Frais *fraisChoisi = [self.fetchedResultsController objectAtIndexPath:[self.tableView indexPathForSelectedRow]];
        FraisTableViewController *controllerDestination = [self.storyboard instantiateViewControllerWithIdentifier:@"nouveauFrais"];
        controllerDestination.fraisChoisi = fraisChoisi;

        [self.navigationController pushViewController:controllerDestination animated:YES];
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

#pragma mark - actions

/**
 * @brief Cette fonction permet de passer en mode édition pour pouvoir supprimer plusieurs brouillons en une seule fois.
 */
- (IBAction)editer:(id)sender {
    [self.tableView setEditing:YES animated:YES];
    
    [self mettreAJourBoutons];
}

/**
 * @brief Cette fonction permet de quitter le mode édition et pouvoir de nouveau sélecitonné un frais à modifier
 */
- (IBAction)annuler:(id)sender {
    [self.tableView setEditing:NO animated:YES];
    
    [self mettreAJourBoutons];
}

/**
 * @brief Cette fonction permet de lancer un actionSheet afin de supprimer un ou plusieurs brouillons.
 */
- (IBAction)supprimer:(id)sender {
    NSString* titreActionSheet;
    if([[self.tableView indexPathsForSelectedRows] count] == 1){
        titreActionSheet = [NSString stringWithFormat:@"Êtes-vous sûr de vouloir supprimer ce brouillon ?"];
    }
    else {
        titreActionSheet = [NSString stringWithFormat:@"Êtes-vous sûr de vouloir supprimer ces brouillons ?"];
    }
    NSString* titreAnnuler = [NSString stringWithFormat:@"Annuler"];
    NSString* titreOk = [NSString stringWithFormat:@"Valider"];
    UIActionSheet* actionSheet = [[UIActionSheet alloc] initWithTitle:titreActionSheet delegate:self cancelButtonTitle:titreAnnuler destructiveButtonTitle:titreOk otherButtonTitles:nil];
    actionSheet.actionSheetStyle = UIActionSheetStyleDefault;
    
    [actionSheet showInView:self.view];
}

#pragma mark - updating button states

/**
 * @brief Cette fonction permet de mettre à jour les boutons de la barre de menu en fonction du mode d'édition ou non
 */
- (void) mettreAJourBoutons {
    if(self.tableView.editing)
    {
        self.navigationItem.rightBarButtonItem = self.annulerBouton;
        
        [self mettreAJourBoutonSupprimer];
        
        self.navigationItem.leftBarButtonItem = self.supprimerBouton;
    }
    else
    {
        if([self.tableView numberOfRowsInSection:0] >0)
        {
            self.editerBouton.enabled = YES;
        }
        else
        {
            self.editerBouton.enabled = NO;
        }
        self.navigationItem.rightBarButtonItem = self.editerBouton;
        
        self.navigationItem.leftBarButtonItem = nil;
    }
    
}

/**
 * @brief Cette fonction permet de mettre à jour le bouton supprimer en fonction du nombre de brouillons sélectionnés
 */
- (void) mettreAJourBoutonSupprimer {
    NSArray* selectedRows = [self.tableView indexPathsForSelectedRows];
    
    BOOL allItemsAreSelected = selectedRows.count == [self.tableView numberOfRowsInSection:0];
    BOOL noItemsAreSelected = selectedRows.count == 0;
    
    if(allItemsAreSelected || noItemsAreSelected)
    {
        self.supprimerBouton.title = [NSString stringWithFormat:@"Tout supprimer"];
    }
    else
    {
        self.supprimerBouton.title = [NSString stringWithFormat:@"Supprimer (%lu)", (unsigned long)selectedRows.count];
    }
    
}
#pragma mark - actionSheetDelegate

/**
 * @brief Cette fonction permet de gérer l'actionSheet qui va nous demander confirmation pour la suppression des brouillons.
 * @brief Si nous confirmons les différents brouillons sélectionnés seront alors supprimés.
 */
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(buttonIndex == 0)
    {
        NSArray *selectedRows = [self.tableView indexPathsForSelectedRows];
        BOOL deleteSpecificRows = selectedRows.count > 0;
        if(deleteSpecificRows)
        {
            for(NSIndexPath *selectionIndex in selectedRows)
            {
                [context deleteObject:[self.fetchedResultsController objectAtIndexPath:selectionIndex]];
            }
            
            NSError *erreur = nil;
            if(![context save:&erreur]){
                NSLog(@"Impossible de sauvegarder ! %@ %@", erreur, [erreur localizedDescription]);
            }
        }
        else
        {
            NSArray* allRows = [self.tableView indexPathsForVisibleRows];
            for(NSIndexPath *selectionIndex in allRows)
            {
                [context deleteObject:[self.fetchedResultsController objectAtIndexPath:selectionIndex]];
            }
            
            NSError *erreur = nil;
            if(![context save:&erreur]){
                NSLog(@"Impossible de sauvegarder ! %@ %@", erreur, [erreur localizedDescription]);
            }
        }
        
        [self.tableView setEditing:NO animated:YES];
        [self mettreAJourBoutons];
    }
}

@end
