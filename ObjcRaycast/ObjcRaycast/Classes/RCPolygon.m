//
// Created by Yudhvir Raj on 2018-10-31.
//

#import "RCPolygon.h"

@implementation RCPolygon

#pragma mark: - Properties
#pragma mark: - Object Properties

#pragma mark: - Static Properties

#pragma mark: - Methods

#pragma mark: - Constructor(s)
- (instancetype) init: (NSString *) name bounds: (NSArray *) bounds {
    self = [super init];
    if (self) {
        _name = name;
        _bounds = bounds;
        [self setBoundingPoints: bounds];
        [self setupBezierPath];
        [self setupShapeLayer];
    }
    return self;
}

#pragma mark: - Instance Methods
- (void) setBoundingPoints: (NSArray *) bounds {
    CGPoint min = CGPointMake(FLT_MAX, FLT_MAX);
    CGPoint max = CGPointMake(FLT_MIN, FLT_MIN);

    unsigned int size = (unsigned int) bounds.count;
    for (unsigned int i = 0; i < size; ++i) {
        CGPoint p = [bounds[i] CGPointValue];
        if (p.x < min.x)
            min.x = p.x;

        if (p.x > max.x)
            max.x = p.x;

        if (p.y < min.y)
            min.y = p.y;

        if (p.y > max.y)
            max.y = p.y;
    }

    _min = min;
    _max = max;
}

/**
 *
 * @param point to determine if inside
 * @return boolean true if (x, y) are in bounds
 */
- (bool) contains: (CGPoint) point {
    int count = 0;
    unsigned int size = (unsigned int) self.bounds.count;

    if (![self inBounds: point])
        return false;

    for (unsigned int i = 0; i < size; ++i) {
        CGPoint vertex1 = [self.bounds[i] CGPointValue];
        CGPoint vertex2 = [self.bounds[(i + 1) % size] CGPointValue];
        if ([self west: vertex1 b: vertex2 point: point])
            ++count;
    }
    return (count % 2) == 1;
}

/**
 *
 * @param point to determine if inside
 * @return boolean true if (lat, lng) are in bounds
 */
- (bool) containsLocation: (MKMapPoint) point {
    CGPoint check = CGPointMake((float) point.x, (float) point.y);
    return [self contains: check];
}

/**
 *
 * @param a start point of the segment
 * @param b end point of the segment
 * @param point to check
 * @return boolean true if point(x, y) is west of the line segment connecting A and B
 */
- (bool) west: (CGPoint) a b: (CGPoint) b point: (CGPoint) point {
    if (a.y <= b.y) {
        if (point.y <= a.y || point.y > b.y || (point.x >= a.x && point.x >= b.x)) {
            return false;
        } else if (point.x < a.x && point.x < b.x) {
            return true;
        } else {
            return (point.y - a.y) / (point.x - a.x) > (b.y - a.y) / (b.x - a.x);
        }
    }

    return [self west: b b: a point: point];
}

/**
 *
 * @param a point to be determined if in general bounds of shape
 * @return boolean true if (x, y) is in general bounds
 */
- (bool) inBounds: (CGPoint) a {
    return !(a.x < self.min.x || a.y < self.min.y || a.x > self.max.x || a.y > self.max.y);
}

- (void) setupBezierPath {
    unsigned int count = (unsigned int) self.bounds.count;
    if (count < 1)
        return;
    
    self.path = [UIBezierPath bezierPath];
    [self.path moveToPoint: [self.bounds[0] CGPointValue]];
    
    for (unsigned int i = 1; i < count; ++i) {
        [self.path addLineToPoint: [self.bounds[i] CGPointValue]];
    }
    
//    if (count > 2)
//        [self.path addLineToPoint: [self.bounds[0] CGPointValue]];
    
    [[self path] closePath];
}

- (void) setupShapeLayer {
    self.shapeLayer = [CAShapeLayer layer];
    self.shapeLayer.path = [self.path CGPath];
    self.shapeLayer.strokeColor = [[UIColor blueColor] CGColor];
    self.shapeLayer.lineWidth = 3.0;
    self.shapeLayer.fillColor = [[UIColor clearColor] CGColor];
    self.shapeLayer.name = [NSString stringWithFormat: @"%s layer", self.name];
}

#pragma mark: - Static Methods


@end
