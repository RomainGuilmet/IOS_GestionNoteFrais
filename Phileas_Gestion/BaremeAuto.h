//
//  BaremeAuto.h
//  Phileas_Gestion
//
//  Created by Florent on 30/04/2015.
//  Copyright (c) 2015 Florent&Romain. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class NSManagedObject;

@interface BaremeAuto : NSManagedObject

@property (nonatomic, retain) NSNumber * basse;
@property (nonatomic, retain) NSString * cylindre;
@property (nonatomic, retain) NSNumber * fixe;
@property (nonatomic, retain) NSNumber * haute;
@property (nonatomic, retain) NSNumber * moyenne;
@property (nonatomic, retain) NSManagedObject *indemnitesBareme;

@end
