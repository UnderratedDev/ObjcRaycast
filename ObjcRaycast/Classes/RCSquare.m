//
// Created by Yudhvir Raj on 2018-10-31.
//

#import "RCSquare.h"

@implementation RCSquare

#pragma mark: - Properties
#pragma mark: - Object Properties

#pragma mark: - Static Properties

#pragma mark: - Methods

#pragma mark: - Constructor(s)
- (instancetype) init: (NSString *) name a: (CGPoint ) a b: (CGPoint ) b {
    NSArray *bounds = @[
            [NSValue valueWithCGPoint: a],
            [NSValue valueWithCGPoint: CGPointMake(b.x, a.y)],
            [NSValue valueWithCGPoint: b],
            [NSValue valueWithCGPoint: CGPointMake(a.x, b.y)]
    ];
    self = [super init: name bounds: bounds];
    return self;
}

#pragma mark: - Instance Methods

#pragma mark: - Static Methods

@end
