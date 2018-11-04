//
//  RCViewController.m
//  ObjcRaycast
//
//  Created by Underrateddev on 10/31/2018.
//  Copyright (c) 2018 Underrateddev. All rights reserved.
//

#import "RCViewController.h"
#import "RCSquare.h"

@interface RCViewController ()

@property (strong, nonatomic) IBOutlet UILabel *position;
@property (strong, nonatomic) IBOutlet UILabel *inside;
@property (strong, nonatomic) IBOutlet UIView *detectionView;

@end

@implementation RCViewController

- (void) viewDidLoad
{
    [super viewDidLoad];
    [self setup];
}

- (void) setup {
    [self setupDetectionView];
    [self setupDrawMode];
    [self setupPoints];
    [self setupShape];
}

- (void) setupDrawMode {
    self.drawMode = false;
    self.position.text = @"draw";
}

- (void) setupDetectionView {
    self.detectionView.layer.borderColor = [[UIColor blackColor] CGColor];
    self.detectionView.layer.borderWidth = 3.0;
    UITapGestureRecognizer *touchRecognizer = [[UITapGestureRecognizer alloc] initWithTarget: self action: @selector(handleDetectionViewTap:)];
    [[self detectionView] addGestureRecognizer: touchRecognizer];
}

- (void) setupPoints {
    self.points = [[NSMutableArray alloc] init];
}

- (void) setupShape {
    self.shape = [[RCPolygon alloc] init: @"shape" bounds: @[]];
}

- (void) addPointToShape: (CGPoint) location {
    [[self points] addObject: [NSValue valueWithCGPoint: location]];
}

// TODO: determine shape from name;
- (void) createShape {
    self.shape = [[RCPolygon alloc] init: @"shape" bounds: [self points]];
}

- (void) drawShape {
    [[[self view] layer] addSublayer: self.shape.shapeLayer];
}

- (void) drawLatest {
    [self createShape];
    [self drawShape];
}

- (void) drawHit: (CGPoint) location {
    int radius = 10;
    self.dotPath = [UIBezierPath bezierPathWithOvalInRect: CGRectMake(location.x, location.y, radius, radius)];
    self.dotLayer = [CAShapeLayer layer];
    self.dotLayer.path = [[self dotPath] CGPath];
    self.dotLayer.strokeColor = [[UIColor blueColor] CGColor];
    self.dotLayer.name = @"dot layer";
    [[[self view] layer] addSublayer: self.dotLayer];
}

- (void) handleDetectionViewTap: (UITapGestureRecognizer *) recognizer {
    CGPoint location = [recognizer locationInView: [recognizer.view superview]];
    NSLog(@"(%f, %f)", location.x, location.y);
    if (self.drawMode) {
        [self addPointToShape: location];
        [self clearDraw];
        [self drawLatest];
    } else {
        if (self.dotLayer != NULL)
            [self clearLayer: self.dotLayer.name];
        [self drawHit: location];
        self.inside.text = [[self shape] contains: location] ? @"is inside" : @"is not inside";
    }
}

- (void) clearLayer: (NSString *) name {
    for (CALayer *layer in self.view.layer.sublayers) {
        if ([layer.name isEqualToString: name]) {
            [layer removeFromSuperlayer];
            break;
        }
    }
}

- (void) clearDraw {
    [self clearLayer: self.shape.shapeLayer.name];
    [self clearLayer: self.dotLayer.name];
}

- (IBAction) draw: (id)sender {
    self.drawMode = true;
    self.position.text = @"start drawing";
}

- (IBAction) clear: (id)sender {
    [self setup];
    [self clearDraw];
}

- (IBAction) hit: (id)sender {
    self.drawMode = false;
    self.position.text = @"hit mode";
}

- (void) didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
