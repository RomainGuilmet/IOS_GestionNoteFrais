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

- (void)viewDidLoad
{
    [super viewDidLoad];
    self->_appDelegate = [[UIApplication sharedApplication] delegate];
    
    context = self.appDelegate.managedObjectContext;
    
    [self VerifierUser];
    NSLog(@"%@",((Login*)[_login objectAtIndex:0]).succes);

}

#pragma mark - actions
- (IBAction)Connexion:(id)sender {    
    utilisateur = [[User alloc] initWithPseudo:self.pseudoTextField.text motDePasse:self.mdpTextField.text andContext:context];
    
    NSError *erreur = nil;
    if(![context save:&erreur]){
        NSLog(@"Impossible de sauvegarder l'utilisateur ! %@ %@", erreur, [erreur localizedDescription]);
    }
}

#pragma mark - TextFieldDelegates
- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.pseudoTextField resignFirstResponder];
    [self.mdpTextField resignFirstResponder];
    [self.view endEditing:YES];
}

- (void) VerifierUser
{
    NSURL *baseUrl = [[NSURL alloc] initWithString:@"https://app-phileas.dpinfo.fr"];
    RKObjectManager* objectManager = [RKObjectManager managerWithBaseURL:baseUrl];
    
    [objectManager.HTTPClient setAuthorizationHeaderWithUsername:@"cbertrand-6" password:@"test-6"];
    
    RKObjectMapping *mapping = [RKObjectMapping mappingForClass:[Login class]];
    [mapping addAttributeMappingsFromArray:@[@"succes"]];
    
    RKResponseDescriptor* responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:mapping method:RKRequestMethodGET pathPattern:nil keyPath:nil statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    
    [objectManager addResponseDescriptor:responseDescriptor];
    
    [objectManager getObjectsAtPath:@"api/user" parameters:nil
                            success:^(RKObjectRequestOperation *operation, RKMappingResult *result){
                                _login = [result array];
                            }
                            failure:^(RKObjectRequestOperation *operation, NSError *error){
                                NSLog(@"Mauvais identifiants ou mot de passe !");
                            }];
}


@end
