//
//  Gameplay2.m
//  RoadSafety
//
//  Created by Syed Muaz on 11/16/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "Gameplay2.h"
#import "DrawMyTouch.h"

@implementation Gameplay2 {
    CCNode *pauseNode;

}

- (id)init {
    if (self = [super init]) {
        [self setUserInteractionEnabled:YES];
        [self setMultipleTouchEnabled:YES];
        
        touchesArray = [[NSMutableArray alloc] init];
        [CCBReader load:@"PauseNode" owner:self];
        
        [self schedule:@selector(countDown:) interval:1 repeat:0 delay:10];
        
    }
    return self;
}

- (void)touchBegan:(UITouch *)touch withEvent:(UIEvent *)event {
    CCLOG(@"Received a touch BEGAN");
}

- (void)touchMoved:(UITouch *)touch withEvent:(UIEvent *)event {

    CGPoint currentTouchArea = [touch locationInView:[touch view] ];
    CGPoint lastTouchArea = [touch previousLocationInView:[touch view]];
    
    currentTouchArea = [[CCDirector sharedDirector] convertToGL:currentTouchArea];
    lastTouchArea = [[CCDirector sharedDirector] convertToGL:lastTouchArea];
    
    [touchesArray addObject:NSStringFromCGPoint(currentTouchArea)];
    [touchesArray addObject:NSStringFromCGPoint(lastTouchArea)];

}

- (void)touchEnded:(UITouch *)touch withEvent:(UIEvent *)event {
    CCLOG(@"Received a touch END");
    //glEnable(GL_LINE_SMOOTH);
    
    for(int i = 0; i < [touchesArray count]; i+=2)
    {
        CGPoint start = CGPointFromString([touchesArray objectAtIndex:i]);
        CGPoint end = CGPointFromString([touchesArray objectAtIndex:i+1]);
        
        CCDrawNode *_line01 = [CCDrawNode node];
        [_line01 drawSegmentFrom:start to: end radius: 5.f color: [CCColor whiteColor]];
        [self addChild:_line01];
        
    }
}


-(void)nextGame
{
    CCScene *gameOver = [CCBReader loadAsScene:@"SuccessScene2"];
    [[CCDirector sharedDirector] replaceScene:gameOver];
    
}

-(void)countDown:(id)sender
{
    NSLog(@"done timer");
    
    CCScene *gameOver = [CCBReader loadAsScene:@"GameOver"];
    [[CCDirector sharedDirector] replaceScene:gameOver];
    
    
}


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



@end
