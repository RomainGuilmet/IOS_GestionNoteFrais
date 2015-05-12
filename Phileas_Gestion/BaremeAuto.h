//
//  BaremeAuto.h
//  Phileas_Gestion
//
//  Created by Romain on 12/05/2015.
//  Copyright (c) 2015 Florent&Romain. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class IndemniteK;

@interface BaremeAuto : NSManagedObject

@property (nonatomic, retain) NSNumber * basse;
@property (nonatomic, retain) NSString * cylindre;
@property (nonatomic, retain) NSNumber * fixe;
@property (nonatomic, retain) NSNumber * haute;
@property (nonatomic, retain) NSNumber * moyenne;
@property (nonatomic, retain) NSSet *indemnitesBareme;
@end

@interface BaremeAuto (CoreDataGeneratedAccessors)

- (void)addIndemnitesBaremeObject:(IndemniteK *)value;
- (void)removeIndemnitesBaremeObject:(IndemniteK *)value;
- (void)addIndemnitesBareme:(NSSet *)values;
- (void)removeIndemnitesBareme:(NSSet *)values;

@end
