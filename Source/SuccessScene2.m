//
//  SuccessScene2.m
//  RoadSafety
//
//  Created by Syed Muaz on 11/17/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "SuccessScene2.h"

@implementation SuccessScene2{
    CCLabelTTF *successLabel;
}

- (id)init {
    if (self = [super init]) {
        [self setUserInteractionEnabled:YES];
        [self setMultipleTouchEnabled:YES];
        NSString *str = [[NSUserDefaults standardUserDefaults] objectForKey:@"Success"];
        [successLabel setString:str];
    }
    return self;
}

-(void)nextGame
{
    CCScene *gameOver = [CCBReader loadAsScene:@"Gameplay3"];
    [[CCDirector sharedDirector] replaceScene:gameOver];
    
}




- (void)touchBegan:(UITouch *)touch withEvent:(UIEvent *)event {
    CCLOG(@"Received a touch");
    [self nextGame];
}


@end
