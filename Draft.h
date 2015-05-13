//
//  Draft.h
//  Phileas_Gestion
//
//  Created by Romain on 11/05/2015.
//  Copyright (c) 2015 Florent&Romain. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <RestKit/RestKit.h>

/**
 * Classe servant à la communication avec l'api Phileas via RestKit.
 * Cette classe sert à envoyer des données relatives à un frais via la commande draft.
 */

@interface Draft : NSObject

@property (strong, nonatomic) NSNumber* def_id;
@property (strong, nonatomic) NSString* amount;
@property (strong, nonatomic) NSString* date;
@property (strong, nonatomic) NSString* km;
@property (strong, nonatomic) NSData* receipt;
@property (strong, nonatomic) NSString* com;
@property (strong, nonatomic) NSString* from;
@property (strong, nonatomic) NSString* to;

+(RKObjectMapping*)mapping;

@end
