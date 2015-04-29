//
//  Type.h
//  Phileas_Gestion
//
//  Created by Romain on 29/04/2015.
//  Copyright (c) 2015 Florent&Romain. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Frais;

@interface Type : NSManagedObject

@property (nonatomic, retain) NSString * lib;
@property (nonatomic, retain) Frais *fraisType;

@end
