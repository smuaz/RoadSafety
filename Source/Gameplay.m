//
//  Gameplay.m
//  RoadSafety
//
//  Created by Syed Muaz on 11/15/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "Gameplay.h"
#import <CoreMotion/CoreMotion.h>

@implementation Gameplay  { // important: only create one instance of a motion manager
    CMMotionManager *_motionManager;
    CCLabelTTF *_label;
    CCNode *_helmet;
    CCNode *_girl;
    CCNode *pauseNode;

    CGPoint originalCenter;
}

- (id)init {
    if (self = [super init]) {

        [CCBReader load:@"PauseNode" owner:self];

        _motionManager = [[CMMotionManager alloc] init];
        _motionManager.deviceMotionUpdateInterval = 1.0/60.0;

        if (_motionManager.isDeviceMotionAvailable) {
            [_motionManager startDeviceMotionUpdates];
        }
        
        originalCenter = _helmet.anchorPoint;
        
        [_motionManager startDeviceMotionUpdatesToQueue:[NSOperationQueue mainQueue] withHandler:^(CMDeviceMotion *motion, NSError *error) {
            _helmet.anchorPoint = CGPointMake(originalCenter.x - motion.gravity.x / 8.0 * 100.0, originalCenter.y - motion.gravity.y / 8.0 * 100.0);
        }];

        [self schedule:@selector(countDown:) interval:1 repeat:0 delay:10];

        
    }
    return self;
}

-(void)countDown:(id)sender
{
    NSLog(@"done timer");
    
    [[NSUserDefaults standardUserDefaults] setObject:@"Wearing Helmet is important when you cycle" forKey:@"Success"];

    
    CCScene *gameOver = [CCBReader loadAsScene:@"GameOver"];
    [[CCDirector sharedDirector] replaceScene:gameOver];

    
}
- (void)onEnter {
    [super onEnter];
    [_motionManager startAccelerometerUpdates];
}

- (void)onExit {
    [super onExit];
    [_motionManager stopAccelerometerUpdates];
}

- (void)update:(CCTime)delta {
    
    CMDeviceMotion *currentDeviceMotion = _motionManager.deviceMotion;
    
    CMAttitude *currentAttitude = currentDeviceMotion.attitude;

    float yaw = currentAttitude.yaw;
    
    _helmet.rotation = CC_RADIANS_TO_DEGREES(yaw);
    
    CMAccelerometerData *accelerometerData = _motionManager.accelerometerData;
    CMAcceleration acceleration = accelerometerData.acceleration;
    CGFloat newXPosition = _helmet.position.x + acceleration.y * 200 * delta;
    newXPosition = clampf(newXPosition, 0, self.contentSize.width);
    
    CGFloat newYPosition = _helmet.position.y + acceleration.x * 200 * delta;
    newYPosition = clampf(newYPosition, 0, self.contentSize.height);

    _helmet.position = CGPointMake(newXPosition, newYPosition);
    
    if (CGRectIntersectsRect(_helmet.boundingBox, _girl.boundingBox)) {
        
        CCLOG(@"collision detected");

        [[NSUserDefaults standardUserDefaults] setObject:@"Awesome! You're wearing helmet when !" forKey:@"Success"];

        CCScene *successScene = [CCBReader loadAsScene:@"SuccessScene"];
        [[CCDirector sharedDirector] replaceScene:successScene];

    }}

-(void)pause
{
    NSLog(@"pause");
    [[CCDirector sharedDirector] pause];
    [self addChild:pauseNode];
}

-(void)resume
{
    NSLog(@"resume");
    [self removeChild:pauseNode];
    
    [[CCDirector sharedDirector] resume];
}

-(void)quit
{
    NSLog(@"quit");
    [self removeChild:pauseNode];
    [[CCDirector sharedDirector] resume];
    
    CCScene *gameplayScene = [CCBReader loadAsScene:@"MainScene"];
    [[CCDirector sharedDirector] replaceScene:gameplayScene];
}


- (void)touchesBegan:(NSSet*)touches withEvent:(UIEvent*)event
{
    NSLog(@"Touch on screen.");

}


@end
