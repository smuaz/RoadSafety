//
//  Gameplay3.m
//  RoadSafety
//
//  Created by Syed Muaz on 11/17/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "Gameplay3.h"

@implementation Gameplay3 {
    CCNode *pauseNode;
    
}

- (id)init {
    if (self = [super init]) {
        [self setUserInteractionEnabled:YES];
        [self setMultipleTouchEnabled:YES];
        
        [CCBReader load:@"PauseNode" owner:self];
        
        [self schedule:@selector(countDown:) interval:1 repeat:0 delay:10];
        
    }
    return self;
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
