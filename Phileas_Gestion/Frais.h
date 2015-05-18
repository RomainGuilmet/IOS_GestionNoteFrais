//
//  Frais.h
//  Phileas_Gestion
//
//  Created by Florent&Romain on 12/05/2015.
//  Copyright (c) 2015 Florent&Romain. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class IndemniteK, Type, User;

@interface Frais : NSManagedObject

@property (nonatomic, retain) NSString * commentaire;
@property (nonatomic, retain) NSDate * date;
@property (nonatomic, retain) NSData * image;
@property (nonatomic, retain) NSString * localisation;
@property (nonatomic, retain) NSNumber * montant;
@property (nonatomic, retain) IndemniteK *indemniteKFrais;
@property (nonatomic, retain) User *owner;
@property (nonatomic, retain) Type *typeFrais;

@end
