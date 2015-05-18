//
//  Message.h
//  Phileas_Gestion
//
//  Created by Romain on 18/05/2015.
//  Copyright (c) 2015 Florent&Romain. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Message : NSObject

/**
 * Classe servant à la communication avec l'api Phileas via RestKit.
 * Cette classe seret à récupérer les messages via la commande message.
 */

@property (strong, nonatomic) NSString* message_title;
@property (strong, nonatomic) NSString* message_body;
@property (strong, nonatomic) NSString* created;

@end
