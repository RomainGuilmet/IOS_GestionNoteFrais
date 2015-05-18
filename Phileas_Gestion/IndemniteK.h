//
//  IndemniteK.h
//  Phileas_Gestion
//
//  Created by Florent&Romain on 12/05/2015.
//  Copyright (c) 2015 Florent&Romain. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class BaremeAuto, Frais;

@interface IndemniteK : NSManagedObject

@property (nonatomic, retain) NSNumber * allezRetour;
@property (nonatomic, retain) NSNumber * distance;
@property (nonatomic, retain) NSString * villeArrivee;
@property (nonatomic, retain) NSString * villeDepart;
@property (nonatomic, retain) BaremeAuto *cylindree;
@property (nonatomic, retain) Frais *fraisIndemniteK;

@end
