#import "MainScene.h"

@implementation MainScene

- (void)play {
    CCLOG(@"play button pressed");
    CCScene *gameplayScene = [CCBReader loadAsScene:@"Gameplay"];
    [[CCDirector sharedDirector] replaceScene:gameplayScene withTransition:[CCTransition transitionPushWithDirection:CCTransitionDirectionUp duration:1.0]];
}

-(void)didLoadFromCCB {
    
    OALSimpleAudio *audio = [OALSimpleAudio sharedInstance];
    [audio playBg:@"bgmusic.mp3" loop:TRUE];
}



-(void)leaderboard
{
    
}

@end
