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
@synthesize context;

- (void)viewDidLoad
{
    [super viewDidLoad];
    self->_appDelegate = [[UIApplication sharedApplication] delegate];
    
    context = self.appDelegate.managedObjectContext;
    
    [self creationTypesFrais];
    [self creationBaremesAuto];
    
    [self chargementListeTypesFrais];
    
    self.montant = [[NSMutableString alloc] init];
    [self.montant setString:@"0"];
    
    if(self.fraisChoisi)
    {
        NSDateFormatter *dateformater = [[NSDateFormatter alloc]init];
        [dateformater setDateFormat:@"dd/MM/yyyy"]; // Date formater
        NSString *date = [dateformater stringFromDate:fraisChoisi.date];
        [self.dateTexte setText:date];
        [self.localisationLbl setText:fraisChoisi.localisation];
        [self.typeF setTitle:fraisChoisi.typeFrais.lib forState:UIControlStateNormal];
        self.image.image =  [UIImage imageWithData:[self.fraisChoisi valueForKey:@"image"]];
        NSString *montantTexte = [NSString stringWithFormat:@"%@", fraisChoisi.montant];
        [self.montantTextField setText:montantTexte];
        [self.comTextArea setText:fraisChoisi.commentaire];
        
    }
    else
    {
        NSDate *dateActuelle = [NSDate date];
        NSDateFormatter *dateformater = [[NSDateFormatter alloc]init];
        [dateformater setDateFormat:@"dd/MM/yyyy"]; // Date formater
        NSString *date = [dateformater stringFromDate:dateActuelle];
        [self.dateTexte setText:date];
        [self.localisationLbl setText:@"Localisation"];
        [self.typeF setTitle:@"Type" forState:UIControlStateNormal];
        self.image.image =  [UIImage imageWithData:nil];
        [self.montantTextField setText:@""];
        [self.comTextArea setText:@""];
        
    }
    
    //Localisation à tester sur un appareil.
    self.locationManager = [[CLLocationManager alloc] init];
    if ([CLLocationManager locationServicesEnabled])
    {
        self.locationManager.delegate = self;
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        self.locationManager.distanceFilter = 10.0f;
        [self.locationManager startUpdatingLocation];
        NSString *localisation;
        if(self.locationManager.location == NULL)
        {
            localisation = @"Impossible de vous localiser";
        }
        else
        {
            localisation = [NSString stringWithFormat:@"%@", self.locationManager.location];
        }
        
        [self.localisationLbl setText:localisation];
    }
    
    self.pickerViewDate = [[UIDatePicker alloc] init];
    self.pickerViewDate.datePickerMode = UIDatePickerModeDate;
    [self.pickerViewDate addTarget:self action:@selector(changementDeDate:) forControlEvents:UIControlEventValueChanged];
    [self.dateTexte setInputView:self.pickerViewDate];
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

    if(![self.montant isEqualToString:@"0"])
    {
        [self.montantTextField setText:self.montant];
    }
}

#pragma mark - alertView delegates
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(alertView.tag == 1)
    {
        if(![[alertView buttonTitleAtIndex:buttonIndex]  isEqual: @"Annuler"]){
            [self.typeF setTitle:[alertView buttonTitleAtIndex:buttonIndex] forState:UIControlStateNormal];
            
            if([[alertView buttonTitleAtIndex:buttonIndex]  isEqual: @"Indemnités kilométriques"]){
                IndemnitesTableViewController* controllerDestination = [self.storyboard instantiateViewControllerWithIdentifier:@"indemnites"];
                [controllerDestination setMontant:self.montant];
                [self.navigationController pushViewController:controllerDestination animated:YES];
            }
        }
    }
    
    if(alertView.tag == 2)
    {
        if([[alertView buttonTitleAtIndex:buttonIndex]  isEqual: @"Appareil Photo"]) {
            if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
                UIImagePickerController *pickerView =[[UIImagePickerController alloc]init];
                pickerView.allowsEditing = YES;
                pickerView.delegate = self;
                pickerView.sourceType = UIImagePickerControllerSourceTypeCamera;
                [self presentViewController:pickerView animated:YES completion:nil];
            }
            
        }else if([[alertView buttonTitleAtIndex:buttonIndex]  isEqual: @"Librairie d'images"]) {
            
            UIImagePickerController *pickerView = [[UIImagePickerController alloc] init];
            pickerView.allowsEditing = YES;
            pickerView.delegate = self;
            pickerView.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
            [self presentViewController:pickerView animated:YES completion:nil];
            
        }
    }
}

#pragma mark - PickerDelegates

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    
    [self dismissViewControllerAnimated:true completion:nil];
    
    UIImage * img = [info valueForKey:UIImagePickerControllerEditedImage];
    
    self.image.image = img;
    
}

#pragma mark - methods
/**
 * Cette fonction sert à créer les différents types de frais possibles et à les stocker sur l'appareil.
 * Les types de frais sont créés uniquement s'il n'existe pas déjà sur l'appareil. Donc au premier lancement de l'application.
 **/
- (void)creationTypesFrais
{
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
        NSLog(@"Impossible de sauvegarder les différents types de frais ! %@ %@", erreur, [erreur localizedDescription]);
    }
}

/**
 * Cette fonction sert à créer les différents barèmes kilométriques et à les stocker sur l'appareil.
 * Les barèmes kilométriques sont créés uniquement s'il n'existe pas déjà sur l'appareil. Donc au premier lancement de l'application.
 * Il sera nécéssaire de modifier les différents chiffres chaque année.
 **/
- (void)creationBaremesAuto
{
    [[BaremeAuto alloc] initWithName:@"3 CV et moins" trancheBasse:[NSNumber numberWithDouble:0.41] trancheMoyenne:[NSNumber numberWithDouble:0.245] trancheHaute:[NSNumber numberWithDouble:0.285] fixe:[NSNumber numberWithDouble:824] andContext:context];
    [[BaremeAuto alloc] initWithName:@"4 CV" trancheBasse:[NSNumber numberWithDouble:0.493] trancheMoyenne:[NSNumber numberWithDouble:0.27] trancheHaute:[NSNumber numberWithDouble:0.332] fixe:[NSNumber numberWithDouble:1082] andContext:context];
    [[BaremeAuto alloc] initWithName:@"5 CV" trancheBasse:[NSNumber numberWithDouble:0.543] trancheMoyenne:[NSNumber numberWithDouble:0.305] trancheHaute:[NSNumber numberWithDouble:0.364] fixe:[NSNumber numberWithDouble:1188] andContext:context];
    [[BaremeAuto alloc] initWithName:@"6 CV" trancheBasse:[NSNumber numberWithDouble:0.568] trancheMoyenne:[NSNumber numberWithDouble:0.32] trancheHaute:[NSNumber numberWithDouble:0.382] fixe:[NSNumber numberWithDouble:1244] andContext:context];
    [[BaremeAuto alloc] initWithName:@"7 CV et plus" trancheBasse:[NSNumber numberWithDouble:0.595] trancheMoyenne:[NSNumber numberWithDouble:0.337] trancheHaute:[NSNumber numberWithDouble:0.401] fixe:[NSNumber numberWithDouble:1288] andContext:context];
    
    NSError *erreur = nil;
    if(![context save:&erreur]){
        NSLog(@"Impossible de sauvegarder les différents barèmes kilométriques ! %@ %@", erreur, [erreur localizedDescription]);
    }
}

- (void)chargementListeTypesFrais
{
    
    self->_appDelegate = [[UIApplication sharedApplication] delegate];
    
    NSManagedObjectContext *context = self.appDelegate.managedObjectContext;
    
    // fetchedResultController initialization
    NSFetchRequest *requete = [[NSFetchRequest alloc] initWithEntityName:@"Type"];
    // Configure the request's entity, and optionally its predicate.
    [requete setSortDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"lib" ascending:NO]]];
    
    NSError *erreur = nil;
    self.resultat = [context executeFetchRequest:requete error:&erreur];
    if([self.resultat count] == 0)
        NSLog(@"vide");
}

-(void)changementDeDate:(UIDatePicker *)sender
{
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd/MM/yyyy"];
    self.dateTexte.text = [formatter stringFromDate:sender.date];
}

#pragma mark - actions
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
    [dateFormatter setDateFormat:@"dd/MM/yyyy"];
    NSDate *date = [[NSDate alloc] init];
    date = [dateFormatter dateFromString:self.dateTexte.text];
    
    NSData * image = UIImagePNGRepresentation(self.image.image);
    NSString * localisation;
    
    NSString * champMontant = self.montantTextField.text;
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    numberFormatter.numberStyle = NSNumberFormatterDecimalStyle;
    NSNumber *montant = [numberFormatter numberFromString:champMontant];
    
    NSString *typeFrais = self.typeF.titleLabel.text;
        
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

    UIAlertView *alert;
    if(self.fraisChoisi)
    {
        alert = [[UIAlertView alloc] initWithTitle:@"Modification enregistrée" message:@"Votre brouillon vient d'être sauvegardé en local." delegate:nil cancelButtonTitle:@"OK"otherButtonTitles:nil];
        
        [alert show];
        
        [self.navigationController popViewControllerAnimated:YES];
    }
    else
    {
        alert = [[UIAlertView alloc] initWithTitle:@"Brouillon enregistré" message:@"Votre brouillon vient d'être sauvegardé en local." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        
        [alert show];
        
        [self viewDidLoad];
    }
}

- (IBAction)changerType:(id)sender {
    UIAlertView *alerteType = [[UIAlertView alloc] initWithTitle:@"Sélectionner un type de frais" message:@"" delegate:self cancelButtonTitle:@"Annuler" otherButtonTitles:nil];
    
    
    for(int i=0; i<[self.resultat count]; i++)
    {
        Type *typeTemp = [self.resultat objectAtIndex:i];
        [alerteType addButtonWithTitle:[NSString stringWithFormat:@"%@", typeTemp.lib]];
    }
    
    [alerteType setTag:1];
    
    [alerteType show];
}

- (IBAction)choisirImage:(id)sender {
    UIAlertView *alerteImage = [[UIAlertView alloc]  initWithTitle:@"Sélectionner une image depuis :" message:@"" delegate:self cancelButtonTitle:@"Annuler" otherButtonTitles:@"Librairie d'images",@"Appareil Photo", nil];
    
    [alerteImage setTag:2];
    
    [alerteImage show];
}


@end

