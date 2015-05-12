//
//  Type.h
//  Phileas_Gestion
//
//  Created by Romain on 12/05/2015.
//  Copyright (c) 2015 Florent&Romain. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Frais;

@interface Type : NSManagedObject

@property (nonatomic, retain) NSString * lib;
@property (nonatomic, retain) NSNumber * idType;
@property (nonatomic, retain) NSSet *fraisType;
@end

@interface Type (CoreDataGeneratedAccessors)

- (void)addFraisTypeObject:(Frais *)value;
- (void)removeFraisTypeObject:(Frais *)value;
- (void)addFraisType:(NSSet *)values;
- (void)removeFraisType:(NSSet *)values;

@end
