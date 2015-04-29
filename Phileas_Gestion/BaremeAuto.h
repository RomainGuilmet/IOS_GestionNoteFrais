//
//  BaremeAuto.h
//  Phileas_Gestion
//
//  Created by Romain on 29/04/2015.
//  Copyright (c) 2015 Florent&Romain. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface BaremeAuto : NSManagedObject

@property (nonatomic, retain) NSString * cylindre;
@property (nonatomic, retain) NSNumber * basse;
@property (nonatomic, retain) NSNumber * moyenne;
@property (nonatomic, retain) NSNumber * haute;
@property (nonatomic, retain) NSNumber * fixe;

@end
