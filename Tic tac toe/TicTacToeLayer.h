//
//  HelloWorldLayer.h
//  Tic tac toe
//
//  Created by Stefan Mortensen on 2011-12-19.
//  Creative Commons Share Alike 2.5 Generic
//  http://creativecommons.org/licenses/by-sa/2.5/
//


// When you import this file, you import all the cocos2d classes
#import "cocos2d.h"

// HelloWorldLayer
@interface TicTacToeLayer : CCLayer
{
    NSMutableArray *_markers;
    NSString       *curPlayer;

}

// returns a CCScene that contains the HelloWorldLayer as the only child
+(CCScene *) scene;

@end
