//
//  FraisTableViewController.m
//  Phileas_Gestion
//
//  Created by Romain on 23/04/2015.
//  Copyright (c) 2015 Florent&Romain. All rights reserved.
//

#import "FraisTableViewController.h"

@implementation FraisTableViewController

@synthesize resultat;

- (void)creationTypesFrais
{
    self->_appDelegate = [[UIApplication sharedApplication] delegate];
    
    NSManagedObjectContext *context = self.appDelegate.managedObjectContext;
    
    [[Type alloc] initWithName:@"Avion" andContext:context];
    [[Type alloc] initWithName:@"Train" andContext:context];
    [[Type alloc] initWithName:@"Carburant" andContext:context];
    [[Type alloc] initWithName:@"Hotel" andContext:context];
    [[Type alloc] initWithName:@"Repas" andContext:context];
    [[Type alloc] initWithName:@"Indemnités kilométriques" andContext:context];
    [[Type alloc] initWithName:@"Location de véhicule" andContext:context];
    [[Type alloc] initWithName:@"Péage" andContext:context];
    [[Type alloc] initWithName:@"Parking" andContext:context];
    [[Type alloc] initWithName:@"Taxi ou bus" andContext:context];
    [[Type alloc] initWithName:@"Fournitures" andContext:context];
    
    NSError *erreur = nil;
    if(![context save:&erreur]){
        NSLog(@"Impossible de sauvegarder ! %@ %@", erreur, [erreur localizedDescription]);
    }
}

- (void)chargementListeTypesFrais
{
    
    self->_appDelegate = [[UIApplication sharedApplication] delegate];

    NSManagedObjectContext *context = self.appDelegate.managedObjectContext;
    
    // fetchedResultController initialization
    NSFetchRequest *requete = [[NSFetchRequest alloc] initWithEntityName:@"Type"];
    // Configure the request's entity, and optionally its predicate.
    [requete setSortDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"lib" ascending:YES]]];
    
    NSError *erreur = nil;
    self.resultat = [context executeFetchRequest:requete error:&erreur];
    if([self.resultat count] == 0)
        NSLog(@"vide");
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self creationTypesFrais];
    
    [self chargementListeTypesFrais];
}

-(void) actionSheet:(UIActionSheet *)actionSheet willDismissWithButtonIndex:(NSInteger)buttonIndex{
    if([[actionSheet buttonTitleAtIndex:buttonIndex]  isEqual: @"Indemnités kilométriques"]){
        // Ouvrir la page d'indemnités géographiques
    }
    else {
        [self.typeF setTitle:[actionSheet buttonTitleAtIndex:buttonIndex] forState:UIControlStateNormal];
    }
    
    [self viewWillAppear:true];
}

- (IBAction)changerType:(id)sender {
    NSString *cancelTitle = (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)? @"Cancel" : nil;;
    UIActionSheet *actionsheet = [[UIActionSheet alloc] initWithTitle:@"Type de frais" delegate:self cancelButtonTitle:cancelTitle destructiveButtonTitle:nil otherButtonTitles:nil];
    
    for(int i=0; i<[self.resultat count]; i++)
    {
        Type *typeTemp = [self.resultat objectAtIndex:i];
        [actionsheet addButtonWithTitle:[NSString stringWithFormat:@"%@", typeTemp.lib]];
    }
    
    [actionsheet showInView:self.view];
    
    actionsheet.tag = 100;
}

/*
 Envoyer le frais au serveur
 */
- (IBAction)envoyer:(id)sender {
}

/*
 Sauvegarder le frais en local
 */
- (IBAction)saisir:(id)sender {
    NSString * commentaire = self.comTextField.text;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd/mm/yyyy"];
    NSDate *date = [[NSDate alloc] init];
    date = [dateFormatter dateFromString:self.dateLbl.text];
    NSData * image;
    NSString * localisation;
    NSNumber * montant = self.montantTextField.text;
    NSString *typeFrais = self.typeF.titleLabel.text;
}
@end

