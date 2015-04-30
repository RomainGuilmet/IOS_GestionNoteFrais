//
//  User.h
//  Phileas_Gestion
//
//  Created by Florent on 30/04/2015.
//  Copyright (c) 2015 Florent&Romain. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Frais;

@interface User : NSManagedObject

@property (nonatomic, retain) NSString * pseudo;
@property (nonatomic, retain) NSString * mdp;
@property (nonatomic, retain) Frais *fraisUser;

@end
