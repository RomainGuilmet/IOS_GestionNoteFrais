//
//  FraisTableViewController.m
//  Phileas_Gestion
//
//  Created by Romain on 23/04/2015.
//  Copyright (c) 2015 Florent&Romain. All rights reserved.
//

#import "FraisTableViewController.h"

@implementation FraisTableViewController

@synthesize fraisChoisi;

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
    
    if(self.fraisChoisi)
    {
        NSDateFormatter *dateformate=[[NSDateFormatter alloc]init];
        [dateformate setDateFormat:@"dd//mm//yyyy"]; // Date formater
        NSString *date = [dateformate stringFromDate:fraisChoisi.date];
        [self.dateLbl setText:date];
        [self.localisationLbl setText:fraisChoisi.localisation];
        [self.typeF setTitle:fraisChoisi.typeFrais.lib forState:UIControlStateNormal];
        //[self.justificatif setTitle:fraisChoisi.image forState:UIControlStateNormal]; Trouver le moyen d'afficher l'image en miniature ou sinon écrire : justificatif fourni
        NSString *montantTexte = [NSString stringWithFormat:@"%@", fraisChoisi.montant];
        [self.montantTextField setText:montantTexte];
        [self.comTextArea setText:fraisChoisi.commentaire];
        
    }
}

- (void) viewWillAppear:(BOOL)animated
{
    if(self.fraisChoisi)
    {
        self.navBar.title = @"Modifier un frais";
        [self.saisirButton setTitle:@"Modifier" forState:UIControlStateNormal];
    }
    else
    {
        self.navBar.title = @"Ajouter un frais";
    }
}

- (IBAction)changerType:(id)sender {
    UIActionSheet *actionsheetType = [[UIActionSheet alloc] initWithTitle:@"Sélectionner un type de frais" delegate:self cancelButtonTitle:@"Annuler" destructiveButtonTitle:nil otherButtonTitles:nil];
    
    for(int i=0; i<[self.resultat count]; i++)
    {
        Type *typeTemp = [self.resultat objectAtIndex:i];
        [actionsheetType addButtonWithTitle:[NSString stringWithFormat:@"%@", typeTemp.lib]];
    }
    
    [actionsheetType showInView:self.view];
    
    actionsheetType.tag = 100;
}

- (IBAction)choisirImage:(id)sender {
    UIActionSheet *action = [[UIActionSheet alloc] initWithTitle:@"Sélectionner une image depuis :" delegate:self cancelButtonTitle:@"Annuler" destructiveButtonTitle:nil otherButtonTitles:@"Librairie d'images",@"Appareil Photo", nil];
    
    [action showInView:self.view];
    /*
    UIImagePickerController * picker = [[UIImagePickerController alloc] init];
    
    // Don't forget to add UIImagePickerControllerDelegate in your .h
    picker.delegate = self;
    
    picker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    //picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    [self presentModalViewController:picker animated:YES];*/
}

#pragma mark - ActionSheet delegates
-(void) actionSheet:(UIActionSheet *)actionSheet willDismissWithButtonIndex:(NSInteger)buttonIndex{
    if([[actionSheet buttonTitleAtIndex:buttonIndex]  isEqual: @"Appareil Photo"]) {
        
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            UIImagePickerController *pickerView =[[UIImagePickerController alloc]init];
            pickerView.allowsEditing = YES;
            pickerView.delegate = self;
            pickerView.sourceType = UIImagePickerControllerSourceTypeCamera;
            [self presentModalViewController:pickerView animated:true];
        }
        
    }else if([[actionSheet buttonTitleAtIndex:buttonIndex]  isEqual: @"Librairie d'images"]) {
        
        UIImagePickerController *pickerView = [[UIImagePickerController alloc] init];
        pickerView.allowsEditing = YES;
        pickerView.delegate = self;
        pickerView.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        [self presentModalViewController:pickerView animated:YES];
        
    }
    
    else if([[actionSheet buttonTitleAtIndex:buttonIndex]  isEqual: @"Indemnités kilométriques"]){
            // Ouvrir la page d'indemnités géographiques
    }
    else if(![[actionSheet buttonTitleAtIndex:buttonIndex]  isEqual: @"Annuler"]){
        [self.typeF setTitle:[actionSheet buttonTitleAtIndex:buttonIndex] forState:UIControlStateNormal];
    }
        
    [self viewWillAppear:true];
}

#pragma mark - PickerDelegates

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    
    [self dismissModalViewControllerAnimated:true];
    
    UIImage * img = [info valueForKey:UIImagePickerControllerEditedImage];
    
    self.image.image = img;
    
}


/*
 Envoyer le frais au serveur
 */
- (IBAction)envoyer:(id)sender {
    
    //Afficher une pop-up le frais a été envoyé au serveur
}

/*
 Sauvegarder le frais en local
 */
- (IBAction)saisir:(id)sender {
    NSString * commentaire = self.comTextArea.text;
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd/mm/yyyy"];
    NSDate *date = [[NSDate alloc] init];
    date = [dateFormatter dateFromString:self.dateLbl.text];
    
    NSData * image;
    NSString * localisation;
    
    NSString * champMontant = self.montantTextField.text;
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    numberFormatter.numberStyle = NSNumberFormatterDecimalStyle;
    NSNumber *montant = [numberFormatter numberFromString:champMontant];
    
    NSString *typeFrais = self.typeF.titleLabel.text;
    
    self->_appDelegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = self.appDelegate.managedObjectContext;
    
    if(self.fraisChoisi)
    {
        [fraisChoisi updateFrais:date localisation:localisation type:typeFrais image:image montant:montant commentaire:commentaire andContext:context];
    }
    else
    {
        [[Frais alloc] initWithDate:date localisation:localisation type:typeFrais image:image montant:montant commentaire:commentaire andContext:context];
    }
    
    NSError *erreur = nil;
    if(![context save:&erreur]){
        NSLog(@"Impossible de sauvegarder le frais ! %@ %@", erreur, [erreur localizedDescription]);
    }

    //Afficher une pop-up brouillon sauver en local
}
@end

