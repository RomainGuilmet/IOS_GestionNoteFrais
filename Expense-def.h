//
//  Expense-def.h
//  Phileas_Gestion
//
//  Created by Florent&Romain on 12/05/2015.
//  Copyright (c) 2015 Florent&Romain. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <RestKit/RestKit.h>

/**
 * Classe servant à la communication avec l'api Phileas via RestKit.
 * Cette classe seret à récupérer les type de frais via la commande expense-def.
 */

@interface Expense_def : NSObject

@property (strong, nonatomic) NSNumber* expense_def_id;
@property (strong, nonatomic) NSString* name_fr;

@end
