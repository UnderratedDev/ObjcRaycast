//
// Created by Yudhvir Raj on 2018-10-31.
//

#ifndef RCPOLYGON_H
#define RCPOLYGON_H

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>
#import <MapKit/MapKit.h>

@interface RCPolygon : NSObject {}

#pragma mark: - Properties
#pragma mark: - Object Properties
@property NSString *name;
@property NSArray *bounds;
@property CGPoint min;
@property CGPoint max;
@property UIBezierPath *path;
@property CAShapeLayer *shapeLayer;

#pragma mark: - Static Properties

#pragma mark: - Methods

#pragma mark: - Constructor(s)
- (instancetype) init: (NSString *) name bounds: (NSArray *) bounds;

#pragma mark: - Instance Methods
/**
 *
 * @param bounds bounds of polygon
 */
- (void) setBoundingPoints: (NSArray *) bounds;

/**
 *
 * @param point to determine if inside
 * @return boolean true if (x, y) are in bounds
 */
- (bool) contains: (CGPoint) point;

/**
 *
 * @param point to determine if inside
 * @return boolean true if (lat, lng) are in bounds
 */
- (bool) containsLocation: (MKMapPoint) point;

/**
 *
 * @param a start point of the segment
 * @param b end point of the segment
 * @param point to check
 * @return boolean true if point(x, y) is west of the line segment connecting A and B
 */
- (bool) west: (CGPoint) a b: (CGPoint) b point: (CGPoint) point;

/**
 *
 * @param a point to be determined if in general bounds of shape
 * @return boolean true if (x, y) is in general bounds
 */
- (bool) inBounds: (CGPoint) a;

- (void) setupBezierPath;
- (void) setupShapeLayer;

#pragma mark: - Static Methods

@end

#endif
