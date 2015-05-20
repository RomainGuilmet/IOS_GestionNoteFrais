//
//  FraisTableViewController.m
//  Phileas_Gestion
//
//  Created by Florent&Romain on 23/04/2015.
//  Copyright (c) 2015 Florent&Romain. All rights reserved.
//

#import "FraisTableViewController.h"

@implementation FraisTableViewController

@synthesize fraisChoisi;
@synthesize context;
@synthesize indemniteK;
@synthesize utilisateur;
@synthesize listeType;
@synthesize listeExpenseDef;
@synthesize locationManager;
@synthesize geocoder;
@synthesize placemark;

/**
 * @brief Cette fonction est appelée quand la vue est chargée par l'application.
 */
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // On initialise l'appDelegate et le context de l'application pour le coreData.
    self->_appDelegate = [[UIApplication sharedApplication] delegate];
    context = self.appDelegate.managedObjectContext;
    
    // Nous chargeons les informations de l'utilisateur connecté.
    [self chargerUtilisateur];
    
    // Nous créons les différents types de frais et barèmes automobile (s'il n'existe pas déjà).
    [self creerTypesFrais];
    [self creerBaremesAuto];
    
    // Nous cachons le bouton permettant de modifier une indemnité kilométrique.
    [self.modifierIndemnite setHidden:TRUE];
    
    // Nous allouons les variables strong qui seront passé par pointeur avec le prepareForSegue.
    self.montant = [[NSMutableString alloc] init];
    [self.montant setString:@"0"];
    
    // Nous initialisons la fonction permettant de cacher le clavier.
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cacherClavier:)];
    [self.view addGestureRecognizer:tap];
    
    // Si la variable fraisChoisi exite, et donc si c'est une modification d'un brouillon, nous remplissons les champs avec les données du frais.
    if(fraisChoisi)
    {
        NSDateFormatter *dateformater = [[NSDateFormatter alloc]init];
        [dateformater setDateFormat:@"dd/MM/yyyy"];
        NSString *date = [dateformater stringFromDate:fraisChoisi.date];
        [self.dateTexte setText:date];
        [self.localisationLbl setText:fraisChoisi.localisation];
        if([fraisChoisi.typeFrais.lib isEqualToString:@"Indemnités kilométriques"])
        {
            indemniteK = fraisChoisi.indemniteKFrais;
        }
        [self.typeF setTitle:fraisChoisi.typeFrais.lib forState:UIControlStateNormal];
        self.image.image =  [UIImage imageWithData:[self.fraisChoisi valueForKey:@"image"]];
        NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
        [numberFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
        NSString *montantTexte = [numberFormatter stringFromNumber:fraisChoisi.montant];
        [self.montantTextField setText:montantTexte];
        [self.comTextArea setText:fraisChoisi.commentaire];
        
    }
    
    // Sinon nous les mettons par défaut.
    else
    {
        // Nous démarrons les outils servant à la géolocalisation
        locationManager = [[CLLocationManager alloc] init];
        geocoder = [[CLGeocoder alloc] init];
        locationManager.delegate = self;
        locationManager.desiredAccuracy = kCLLocationAccuracyKilometer;
        locationManager.distanceFilter = 1000.0f;
        [self.locationManager requestWhenInUseAuthorization];
        
        [locationManager startUpdatingLocation];
        
        NSDate *dateActuelle = [NSDate date];
        NSDateFormatter *dateformater = [[NSDateFormatter alloc]init];
        [dateformater setDateFormat:@"dd/MM/yyyy"];
        NSString *date = [dateformater stringFromDate:dateActuelle];
        [self.dateTexte setText:date];
        [self.localisationLbl setText:@"Impossible de vous localiser"];
        [self.typeF setTitle:@"Type" forState:UIControlStateNormal];
        self.image.image =  [UIImage imageWithData:nil];
        [self.montantTextField setText:@""];
        [self.comTextArea setText:@""];
        
    }
    
    // Nous initialisons le datePicker permettant de choisir la date.
    self.pickerViewDate = [[UIDatePicker alloc] init];
    self.pickerViewDate.datePickerMode = UIDatePickerModeDate;
    [self.pickerViewDate addTarget:self action:@selector(changerDeDate:) forControlEvents:UIControlEventValueChanged];
    [self.dateTexte setInputView:self.pickerViewDate];
}

/**
 * @brief Cette fonction est appelée quand la vue apparaît.
 */
- (void) viewDidAppear:(BOOL)animated
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

    if([self.typeF.titleLabel.text isEqualToString:@"Indemnités kilométriques"])
    {
        [self.modifierIndemnite setHidden:FALSE];
    }

    if(![self.montant isEqualToString:@"0"])
    {
        [self.montantTextField setText:self.montant];
    }
}

#pragma mark - alertView delegates
/**
 * @brief Cette fonction sert à gérer les alertView.
 * @brief Si le tag vaut 1 alors nous gérons l'alerte correspondant le choix d'un type de frais, s'il vaut 2 nous gérons celle concernant le choix d'un justificatif.
 */
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(alertView.tag == 1)
    {
        // Si l'alerte a été fermée avec un autre bouton qu'annuler nous changeons le nom du bouton changerType (pour afficher le type choisi et le réutiliser plus tard).
        if(![[alertView buttonTitleAtIndex:buttonIndex]  isEqual: @"Annuler"]){
            [self.typeF setTitle:[alertView buttonTitleAtIndex:buttonIndex] forState:UIControlStateNormal];
            [self.modifierIndemnite setHidden:TRUE];
            
            // Si le type choisi est indemnités kilométriques nous chargons le controller indemnites (comme ci nous avions cliqué sur le bouton modifier c.f. prepareForSegue plus bas).
            if([[alertView buttonTitleAtIndex:buttonIndex]  isEqual: @"Indemnités kilométriques"]){
                NSEntityDescription *entiteDesc = [NSEntityDescription entityForName:@"IndemniteK" inManagedObjectContext:context];
                indemniteK = [[IndemniteK alloc] initWithEntity:entiteDesc insertIntoManagedObjectContext:context];
                
                IndemnitesTableViewController* controllerDestination = [self.storyboard instantiateViewControllerWithIdentifier:@"indemnites"];
                [controllerDestination setMontant:self.montant];
                [controllerDestination setIndemniteK:indemniteK];
                [self.navigationController pushViewController:controllerDestination animated:YES];
            }
        }
    }
    
    if(alertView.tag == 2)
    {
        // Si le mode choisi est appareil photo, nous lançons ce dernier.
        if([[alertView buttonTitleAtIndex:buttonIndex]  isEqual: @"Appareil Photo"]) {
            if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
                UIImagePickerController *pickerView =[[UIImagePickerController alloc]init];
                pickerView.allowsEditing = YES;
                pickerView.delegate = self;
                pickerView.sourceType = UIImagePickerControllerSourceTypeCamera;
                [self presentViewController:pickerView animated:YES completion:nil];
            }
        }
        
        // Si le mode choisi est librairie, nous permettons le choix d'une photo dans la bibliothèque d'images.
        else if([[alertView buttonTitleAtIndex:buttonIndex]  isEqual: @"Librairie d'images"]) {
            
            UIImagePickerController *pickerView = [[UIImagePickerController alloc] init];
            pickerView.allowsEditing = YES;
            pickerView.delegate = self;
            pickerView.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
            [self presentViewController:pickerView animated:YES completion:nil];
            
        }
    }
}

#pragma mark - PickerDelegates
/**
 * @brief Cette fonction sert à récupérer l'image sélectionner parmis la librairie ou prise en photo et à l'enregistrer dans une variable locale.
 */
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    
    [self dismissViewControllerAnimated:true completion:nil];
    
    UIImage * img = [info valueForKey:UIImagePickerControllerEditedImage];
    
    self.image.image = img;
}

#pragma mark - TextFieldDelegates
/**
 * @brief Cette fonction sert à cacher le clavier lorsque l'on clique en dehors d'un textField.
 */
- (void) cacherClavier:(UITapGestureRecognizer *) recognizer
{
    [self.dateTexte resignFirstResponder];
    [self.montantTextField resignFirstResponder];
    [self.comTextArea resignFirstResponder];
    
}

#pragma mark - LocationManagerDelegates
/**
 * @brief Cette fonction permet de changer le label localisation si l'on se déplace.
 */
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    [geocoder reverseGeocodeLocation:[locations lastObject] // You can pass aLocation here instead
                   completionHandler:^(NSArray *placemarks, NSError *error) {
                       
                       dispatch_async(dispatch_get_main_queue(),^ {
                           // do stuff with placemarks on the main thread
                           
                           if (placemarks.count == 1) {
                               NSLog(@"placemark");
                               placemark = [placemarks objectAtIndex:0];
                               
                               [self.localisationLbl setText:placemark.locality];
                           }
                           
                       });
                       
                   }];
}

/**
 * @brief Cette fonction sert afficher les erreurs de localisation
 */
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    [self.localisationLbl setText:@"Impossible de vous localiser"];
}

#pragma mark - methods
/**
 * @brief Cette fonction sert à récupérer les différents types de frais possibles depuis la BD phileas et à les stocker sur l'appareil.
 * @brief Les types de frais sont créés uniquement s'il n'existe pas déjà sur l'appareil, donc au premier lancement de l'application.
 */
- (void)creerTypesFrais
{
    NSURL *baseUrl = [[NSURL alloc] initWithString:@"https://app-phileas.dpinfo.fr"];
    RKObjectManager* objectManager = [RKObjectManager managerWithBaseURL:baseUrl];
    
    [objectManager.HTTPClient setAuthorizationHeaderWithUsername:utilisateur.pseudo password:utilisateur.mdp];
    
    RKObjectMapping *mapping = [RKObjectMapping mappingForClass:[Expense_def class]];
    [mapping addAttributeMappingsFromArray:@[@"expense_def_id", @"name_fr"]];
    
    RKResponseDescriptor* responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:mapping method:RKRequestMethodGET pathPattern:nil keyPath:@"result" statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    
    [objectManager addResponseDescriptor:responseDescriptor];
    
    [objectManager getObjectsAtPath:@"api/expense-def" parameters:nil
                            success:^(RKObjectRequestOperation *operation, RKMappingResult *result){
                                listeExpenseDef = result.array;
                                for(int i=0; i<[listeExpenseDef count]; i++)
                                {
                                    Expense_def* temp = [listeExpenseDef objectAtIndex:i];
                                    [[Type alloc] initWithName:temp.name_fr andID:temp.expense_def_id andContext:context];
                                }
                                
                                NSError *erreur = nil;
                                if(![context save:&erreur]){
                                    NSLog(@"Impossible de sauvegarder les différents types de frais ! %@ %@", erreur, [erreur localizedDescription]);
                                }
                            }
                            failure:^(RKObjectRequestOperation *operation, NSError *error){
                                
                            }];
}

/**
 * @brief Cette fonction sert à créer les différents barèmes kilométriques et à les stocker sur l'appareil.
 * @brief Les barèmes kilométriques sont créés uniquement s'il n'existe pas déjà sur l'appareil, donc au premier lancement de l'application.
 * @brief Il sera nécessaire de modifier les différents chiffres chaque année.
 */
- (void)creerBaremesAuto
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

/**
 * @brief Cette fonction permet de charger depuis le coreData tous les types de frais existant.
 */
- (void)chargerListeTypesFrais
{
    NSFetchRequest *requete = [[NSFetchRequest alloc] initWithEntityName:@"Type"];
    [requete setSortDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"lib" ascending:YES]]];
    
    NSError *erreur = nil;
    listeType = [context executeFetchRequest:requete error:&erreur];
}

/**
 * @brief Cette fonction permet de changer la date du frais après l'avoir sélectionnée dans un datePicker.
 */
-(void)changerDeDate:(UIDatePicker *)sender
{
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd/MM/yyyy"];
    self.dateTexte.text = [formatter stringFromDate:sender.date];
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

#pragma mark - actions
/**
 * @brief Cette fonction permet d'envoyer le brouillon à l'application web de phileas.
 * @brief Cette fonction utilise le framework RestKit et la fonction draft de l'api de phileas.
 */
- (IBAction)envoyer:(id)sender {
    // Nous récupérons les différentes champs de la vue relatif à un frais.
    NSString *commentaire = self.comTextArea.text;
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd/MM/yyyy"];
    NSDate *date = [[NSDate alloc] init];
    date = [dateFormatter dateFromString:self.dateTexte.text];
    
    NSData *image = UIImagePNGRepresentation(self.image.image);
    NSString *localisation = self.localisationLbl.text;
    
    NSString *champMontant = self.montantTextField.text;
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    if([champMontant containsString:@"€"]){
        [numberFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
    }
    else{
        [numberFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
    }
    NSNumber *montant = [numberFormatter numberFromString:champMontant];
    
    NSString *typeFrais = self.typeF.titleLabel.text;
    
    Boolean update = false;
    
    // Nous le sauvegardons en local pour le modifier ultérieurement.
    // Si le frais existe déjà nous le modifions.
    if(fraisChoisi)
    {
        [fraisChoisi updateFrais:date localisation:localisation type:typeFrais image:image montant:montant commentaire:commentaire andContext:context];
        update = true;
    }
    // Sinon nous en créons un nouveau
    else
    {
        fraisChoisi = [[Frais alloc] initWithDate:date localisation:localisation type:typeFrais image:image montant:montant commentaire:commentaire andContext:context];
        [utilisateur addFraisUserObject:fraisChoisi];
    }
    // Si le type du frais est une indemnité kilométrique, nous récupérons l'indemnité créée précédement et nous l'ajoutons au frais.
    if([typeFrais isEqual: @"Indemnités kilométriques"]){
        [fraisChoisi addIndemniteK:indemniteK];
    }
    
    // Nous préparons le manager RestKit avec l'url de l'application web et les données relatives à un utilisateur.
    NSURL *baseUrl = [[NSURL alloc] initWithString:@"https://app-phileas.dpinfo.fr"];
    RKObjectManager* objectManagerDraft = [RKObjectManager managerWithBaseURL:baseUrl];
    [objectManagerDraft.HTTPClient setAuthorizationHeaderWithUsername:utilisateur.pseudo password:utilisateur.mdp];
    
    // Nous préparons la date de création du brouillon au format de l'api.
    NSDate* dateActuelle = [NSDate date];
    NSDateFormatter *dateFormatterActuel = [[NSDateFormatter alloc] init];
    [dateFormatterActuel setDateFormat:@"yyyy-MM-dd HH:mm:ss"];

    // Nous prépartons le montant du frais au format de l'api (nombre à virgule).
    NSMutableString *montantFrais = [NSMutableString stringWithFormat:@"%@", fraisChoisi.montant];
    [montantFrais replaceOccurrencesOfString:@"." withString:@"," options:NSLiteralSearch range: NSMakeRange(0, [montantFrais length])];
    
    // Nous préparons l'objet draft avec les informations du frais créé.
    Draft *dataObject = [[Draft alloc] init];
    [dataObject setDef_id:fraisChoisi.typeFrais.idType];
    [dataObject setAmount:montantFrais];
    [dataObject setDate:[dateFormatterActuel stringFromDate:dateActuelle]];
    [dataObject setReceipt:fraisChoisi.image];
    [dataObject setCom:fraisChoisi.commentaire];
    [dataObject setLocalisation:fraisChoisi.localisation];
    
    // Si le type de frais est indemnités kilométriques, nous ajoutons les informations de l'indemnité créée.
    if([fraisChoisi.typeFrais.lib isEqual: @"Indemnités kilométriques"]){
        [dataObject setKm:[fraisChoisi.indemniteKFrais.distance stringValue]];
        [dataObject setFrom:fraisChoisi.indemniteKFrais.villeDepart];
        [dataObject setTo:fraisChoisi.indemniteKFrais.villeArrivee];
    }
    
    // Nous préparons le manager avec les map RestKit de requête et de réponse pour notre objet.
    RKObjectMapping *requestDraftMapping =  [[Draft mapping] inverseMapping];
    RKRequestDescriptor* requestDraftDescriptor = [RKRequestDescriptor requestDescriptorWithMapping:requestDraftMapping objectClass:[Draft class] rootKeyPath:nil method:RKRequestMethodPOST];
    RKObjectMapping *responseDraftMapping =  [Draft mapping];
    RKResponseDescriptor* responseDraftDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:responseDraftMapping method:RKRequestMethodAny pathPattern:nil keyPath:@"result" statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    
    [objectManagerDraft addResponseDescriptor:responseDraftDescriptor];
    [objectManagerDraft addRequestDescriptor:requestDraftDescriptor];
    [objectManagerDraft setRequestSerializationMIMEType: RKMIMETypeJSON];
    
    // Nous préparons la requête de post multi-part avec la fonction draft de l'api.
    NSMutableURLRequest  *request= [objectManagerDraft multipartFormRequestWithObject:dataObject method:RKRequestMethodPOST path:@"api/draft" parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
    }];
    RKObjectRequestOperation *operation = [objectManagerDraft objectRequestOperationWithRequest:request
        success:^(RKObjectRequestOperation *operation, RKMappingResult *result){
            UIAlertView *alert;
            // Si c'est une modification, nous retournons à la vue précédente, la liste des brouillons.
            if(update)
            {
                alert = [[UIAlertView alloc] initWithTitle:@"Brouillon envoyé" message:@"Votre brouillon vient d'être envoyé au serveur." delegate:nil cancelButtonTitle:@"OK"otherButtonTitles:nil];
                
                [alert show];
                
                [self.navigationController popViewControllerAnimated:YES];
            }
            // Si c'est un nouveau frais, nous rechargeons une vue vierge permettant de saisir un nouveau frais.
            else
            {
                alert = [[UIAlertView alloc] initWithTitle:@"Brouillon envoyé" message:@"Votre brouillon vient d'être envoyé au serveur." delegate:nil cancelButtonTitle:@"OK"otherButtonTitles:nil];
                
                [alert show];
                
                fraisChoisi = nil;
                
                [self viewDidLoad];
            }
       }
       failure:^(RKObjectRequestOperation *operation, NSError *error){
           // S'il y a eu une erreur, nous l'affichons.
           UIAlertView *alert;
           alert = [[UIAlertView alloc] initWithTitle:@"Erreur d'envoi" message:@"Votre brouillon n'a pas pu être envoyé au serveur. \n Veuillez rééssayer." delegate:nil cancelButtonTitle:@"OK"otherButtonTitles:nil];
           [alert show];
       }];
    
    // Nous exécutons la requête
    [objectManagerDraft enqueueObjectRequestOperation:operation];

}

/**
 * @brief Cette fonction sert à sauvegarder le brouillon en local au clic sur le bouton saisir ou à modifier un brouillon au clic sur le bouton modifier.
 */
- (IBAction)saisir:(id)sender {
    // Nous récupérons les différentes champs de la vue relatif à un frais.
    NSString *commentaire = self.comTextArea.text;
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd/MM/yyyy"];
    NSDate *date = [[NSDate alloc] init];
    date = [dateFormatter dateFromString:self.dateTexte.text];
    
    NSData *image = UIImagePNGRepresentation(self.image.image);
    NSString *localisation = self.localisationLbl.text;
    
    NSString *champMontant = self.montantTextField.text;
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    if([champMontant containsString:@"€"]){
        [numberFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
    }
    else{
        [numberFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
    }
    NSNumber *montant = [numberFormatter numberFromString:champMontant];
    
    NSString *typeFrais = self.typeF.titleLabel.text;
    
    if(![typeFrais  isEqual: @""] && ![typeFrais  isEqual: @"Type"])
    {
        Boolean update = false;
    
        // Si le frais existe déjà nous le modifions.
        if(fraisChoisi)
        {
            [fraisChoisi updateFrais:date localisation:localisation type:typeFrais image:image montant:montant commentaire:commentaire andContext:context];
            update = true;
        }
        // Sinon nous en créons un nouveau
        else
        {
            fraisChoisi = [[Frais alloc] initWithDate:date localisation:localisation type:typeFrais image:image montant:montant commentaire:commentaire andContext:context];
            [utilisateur addFraisUserObject:fraisChoisi];
        }
    
        // Si le type du frais est une indemnité kilométrique, nous récupérons l'indemnité créée précédement et nous l'ajoutons au frais.
        if([typeFrais isEqual: @"Indemnités kilométriques"]){
            [fraisChoisi addIndemniteK:indemniteK];
        }
    
        // Nous sauvegardons le frais en local
        NSError *erreur = nil;
        if(![context save:&erreur]){
            NSLog(@"Impossible de sauvegarder le frais ! %@ %@", erreur, [erreur localizedDescription]);
        }

        UIAlertView *alert;
        // Si c'est une modification qui a été effectuée nous l'affichons et nous retournons à la vue précédente, la liste des brouillons.
        if(update)
        {
            alert = [[UIAlertView alloc] initWithTitle:@"Modification enregistrée" message:@"Votre brouillon vient d'être sauvegardé en local." delegate:nil cancelButtonTitle:@"OK"otherButtonTitles:nil];
        
            [alert show];
    
            [self.navigationController popViewControllerAnimated:YES];
        }
        // Si c'est un nouveau frais qui a été créé nous l'affichons et nous rechargeons une vue vierge permettant de saisir un nouveau frais.
        else
        {
            alert = [[UIAlertView alloc] initWithTitle:@"Brouillon enregistré" message:@"Votre brouillon vient d'être sauvegardé en local." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        
            [alert show];
        
            fraisChoisi = nil;
        
            [self viewDidLoad];
        }
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Impossible de sauvegarder" message:@"Veuillez vérifier que vous avez choisi un type." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        
        [alert show];
    }
}

/**
 * @brief Cette fonction permet de lancer une alerte au clic sur le bouton changerType afin de choisir le type du frais parmis la liste de tous les types.
 */
- (IBAction)changerType:(id)sender {
    UIAlertView *alerteType = [[UIAlertView alloc] initWithTitle:@"Sélectionner un type de frais" message:@"" delegate:self cancelButtonTitle:@"Annuler" otherButtonTitles:nil];
    
    [self chargerListeTypesFrais];
    
    for(int i=0; i<[listeType count]; i++)
    {
        Type *typeTemp = [listeType objectAtIndex:i];
        [alerteType addButtonWithTitle:[NSString stringWithFormat:@"%@", typeTemp.lib]];
    }
    
    [alerteType setTag:1];
    
    [alerteType show];
}

/**
 * @brief Cette fonction permet de lancer une alerte au clic sur le bouton justificatif pour choisir de prendre une photo ou de sélectionner une image dans la librairie.
 */
- (IBAction)choisirImage:(id)sender {
    UIAlertView *alerteImage = [[UIAlertView alloc]  initWithTitle:@"Sélectionner une image depuis :" message:@"" delegate:self cancelButtonTitle:@"Annuler" otherButtonTitles:@"Librairie d'images",@"Appareil Photo", nil];
    
    [alerteImage setTag:2];
    
    [alerteImage show];
}

#pragma mark - navigation
/**
 * @brief Cette fonction permet de changer la page active vers la page indemnités kilomètriques au clic sur le bouton modifier.
 * @brief Nous passons par pointeur au controller indemnites le montant et une indemnite que ce dernier modifiera afin que nous puissons les utiliser ici.
 */
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([[segue identifier] isEqualToString:@"modifierIndemnite"]){
        
        IndemnitesTableViewController* controllerDestination = segue.destinationViewController;
        [controllerDestination setMontant:self.montant];
        [controllerDestination setIndemniteK:indemniteK];

    }
}

@end

