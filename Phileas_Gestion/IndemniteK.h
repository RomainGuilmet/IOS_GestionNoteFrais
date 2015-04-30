//
//  IndemniteK.h
//  Phileas_Gestion
//
//  Created by Florent on 30/04/2015.
//  Copyright (c) 2015 Florent&Romain. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class BaremeAuto, Frais;

@interface IndemniteK : NSManagedObject

@property (nonatomic, retain) NSString * villeDepart;
@property (nonatomic, retain) NSString * villeArrivee;
@property (nonatomic, retain) NSNumber * allezRetour;
@property (nonatomic, retain) Frais *fraisIndemniteK;
@property (nonatomic, retain) BaremeAuto *cylindree;

@end
