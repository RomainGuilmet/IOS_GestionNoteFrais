//
//  ConnexionViewController.m
//  Phileas_Gestion
//
//  Created by Romain on 04/05/2015.
//  Copyright (c) 2015 Florent&Romain. All rights reserved.
//

#import "ConnexionViewController.h"

@implementation ConnexionViewController

@synthesize context;
@synthesize utilisateur;

/**
 * @brief Cette fonction est appelée quand la vue est chargée par l'application.
 */
- (void)viewDidLoad
{
    [super viewDidLoad];
    self->_appDelegate = [[UIApplication sharedApplication] delegate];
    
    context = self.appDelegate.managedObjectContext;
}

#pragma mark - method
/**
 * @brief Cette fonction permet de sauvegarder l'utilisateur qui vient de se connecter dans le coreData afin qu'il reste connecté.
 */
- (void)SauverUtilisateur {
    utilisateur = [[User alloc] initWithPseudo:self.pseudoTextField.text motDePasse:self.mdpTextField.text andContext:context];
    
    NSError *erreur = nil;
    if(![context save:&erreur]){
        NSLog(@"Impossible de sauvegarder l'utilisateur ! %@ %@", erreur, [erreur localizedDescription]);
    }
    else
    {
        UITabBarController* controllerDestination = [self.storyboard instantiateViewControllerWithIdentifier:@"tabBar"];
        [self.navigationController showDetailViewController:controllerDestination sender:self];
    }
}

/**
 * @brief Cette fonction sert à afficher une alerte si les identifiants de l'utilisateur ne sont pas les bons.
 */
- (void)alerteIdentifiants {
    UIAlertView *alerte = [[UIAlertView alloc]  initWithTitle:@"Connexion impossible" message:@"Vérifiez votre connexion internet ainsi que vos identifiants." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
    
    [alerte show];
}

#pragma mark - TextFieldDelegates
/**
 * @brief Cette fonction sert à cacher le clavier lorsque l'on clique en dehors d'un textField.
 */
- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.pseudoTextField resignFirstResponder];
    [self.mdpTextField resignFirstResponder];
    [self.view endEditing:YES];
}

#pragma mark - actions
/**
 * @brief Cette fonction sert à se connecter à l'application.
 * @brief Pour cela, il faut être connecté à internet et au moyen de la fonction user de l'api nous allons vérifier que les identifiants fourni correspondent à ceux d'un utilisateur enregistré sur l'application web.
 */
- (IBAction)Connexion:(id)sender
{
    NSURL *baseUrl = [[NSURL alloc] initWithString:@"https://app-phileas.dpinfo.fr"];
    RKObjectManager* objectManager = [RKObjectManager managerWithBaseURL:baseUrl];
    
    [objectManager.HTTPClient setAuthorizationHeaderWithUsername:self.pseudoTextField.text password:self.mdpTextField.text];
    
    RKObjectMapping *mapping = [RKObjectMapping new];
    
    RKResponseDescriptor* responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:mapping method:RKRequestMethodGET pathPattern:nil keyPath:@"succes" statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    
    [objectManager addResponseDescriptor:responseDescriptor];
    
    [objectManager getObjectsAtPath:@"api/user" parameters:nil
                            success:^(RKObjectRequestOperation *operation, RKMappingResult *result){
                                [self SauverUtilisateur];
                            }
                            failure:^(RKObjectRequestOperation *operation, NSError *error){
                                [self alerteIdentifiants];
                            }];
    
    
}




@end
