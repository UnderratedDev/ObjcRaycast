//
//  RCViewController.h
//  ObjcRaycast
//
//  Created by Underrateddev on 10/31/2018.
//  Copyright (c) 2018 Underrateddev. All rights reserved.
//

#ifndef RCVIEWCONTROLLER_H
#define RCVIEWCONTROLLER_H

@import UIKit;

#import "RCPolygon.h"

@interface RCViewController : UIViewController {}

#pragma mark: - Properties
#pragma mark: - Object Properties
@property bool drawMode;
@property NSMutableArray *points;
@property RCPolygon *shape;
@property UIBezierPath *dotPath;
@property CAShapeLayer *dotLayer;

#pragma mark: - Static Properties

#pragma mark: - Methods
#pragma mark: - Constructor(s)
#pragma mark: - Instance Methods

- (void) setup;
- (void) setupDrawMode;
- (void) setupDetectionView;
- (void) setupPoints;
- (void) setupShape;

- (void) addPointToShape: (CGPoint) location;
- (void) createShape;
- (void) drawShape;
- (void) drawLatest;
- (void) drawHit: (CGPoint) location;
- (void) clearDraw;
- (void) clearLayer: (NSString *) name;

#pragma mark: - Static Methods

@end

#endif
