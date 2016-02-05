//
//  DrawMyTouch.m
//  RoadSafety
//
//  Created by Syed Muaz on 11/17/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "DrawMyTouch.h"

@implementation DrawMyTouch

-(id) init
{
    if( (self=[super init]))
    { }
    return self;
}

-(void)draw
{
    
    //glEnable(GL_LINE_SMOOTH);
    
    for(int i = 0; i < [touchesArray count]; i+=2)
    {
        CGPoint start = CGPointFromString([touchesArray objectAtIndex:i]);
        CGPoint end = CGPointFromString([touchesArray objectAtIndex:i+1]);
        
        //ccDrawLine(start, end);
        CCDrawNode *_line01 = [CCDrawNode node];
        [_line01 drawSegmentFrom:start to: end radius: 5.f color: [CCColor redColor]];
        [self addChild:_line01];
    }
}

@end
