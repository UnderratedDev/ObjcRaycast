//
// Created by Yudhvir Raj on 2018-10-31.
//

#ifndef RCSQUARE_H
#define RCSQUARE_H

#import <CoreGraphics/CoreGraphics.h>
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "RCPolygon.h"

@interface RCSquare : RCPolygon

#pragma mark: - Properties
#pragma mark: - Object Properties

#pragma mark: - Static Properties

#pragma mark: - Methods

#pragma mark: - Constructor(s)
- (instancetype) init: (NSString *) name a: (CGPoint) a b: (CGPoint) b;

#pragma mark: - Instance Methods

#pragma mark: - Static Methods

@end

#endif
