//
//  HelloWorldLayer.m
//  Tic tac toe
//
//  Created by Stefan Mortensen on 2011-12-19.
//  Copyright Dynamic Jester 2011. All rights reserved.
//


// Import the interfaces
#import "TicTacToeLayer.h"

// HelloWorldLayer implementation
@implementation TicTacToeLayer

+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	TicTacToeLayer *layer = [TicTacToeLayer node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

- (void) resetMarkers {
    
    // Loop through the array of markers and set all markers to false
    int i;
    for(i = 0; i <= 8; i++){
        [_markers insertObject:@"0" atIndex:i]; 
    }
    
    curPlayer = @"1";
    
}

// on "init" you need to initialize your instance
-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super" return value
	if( (self=[super init])) {
        
        // Enable touch
        self.isTouchEnabled = YES;
        
        // allocate memory
        _markers = [[NSMutableArray alloc] init];
        
        // ask director the the window size
		CGSize size = [[CCDirector sharedDirector] winSize];
        
        // create the background sprite
        CCSprite *gamefield = [CCSprite spriteWithFile:@"gamefield.png"];
        gamefield.position = ccp(size.width / 2,size.height / 2);
        
        [self addChild:gamefield];
        
		// create and initialize a Label
		CCLabelTTF *label = [CCLabelTTF labelWithString:@"Tic Tac Toe" fontName:@"Marker Felt" fontSize:64];
	
		// position the label on the center of the screen
		label.position =  ccp( size.width /2 , size.height - 64 );
		
		// add the label as a child to this Layer
		[self addChild: label];
        
        // reset markers
        [self resetMarkers];
	}
	return self;
}



- (void) addMarker:(CGPoint)location {
    
    NSLog(@"TouchedX:%f TouchedY:%f",location.x,location.y);   
    CCSprite *marker = [CCSprite spriteWithFile:@"x.png"];
    
    // Calculate what field to place marker in
    /*
     2011-12-19 21:58:09.103 Tic tac toe[5169:c503] TouchedX:17.000000 TouchedY:305.000000
     2011-12-19 21:58:15.234 Tic tac toe[5169:c503] TouchedX:303.000000 TouchedY:306.000000
     2011-12-19 21:58:22.038 Tic tac toe[5169:c503] TouchedX:16.000000 TouchedY:16.000000
     2011-12-19 21:58:24.536 Tic tac toe[5169:c503] TouchedX:303.000000 TouchedY:13.000000
    */
    
    // Ignore clicks outside of playing field
    if(location.x < 17 || location.x > 303) return;
    if(location.y < 13 || location.y > 306) return;
    
    /*
     2011-12-19 22:01:38.026 Tic tac toe[5245:c503] TouchedX:15.000000 TouchedY:304.000000
     2011-12-19 22:01:42.908 Tic tac toe[5245:c503] TouchedX:109.000000 TouchedY:304.000000
     2011-12-19 22:01:46.196 Tic tac toe[5245:c503] TouchedX:108.000000 TouchedY:211.000000
     2011-12-19 22:01:48.727 Tic tac toe[5245:c503] TouchedX:18.000000 TouchedY:213.000000
    */
    // Top row 
    if(location.y < 306 && location.y > 213){
        if(location.x > 15 && location.x < 108){
            if([[_markers objectAtIndex:0] intValue] == 0){
                [_markers insertObject:curPlayer atIndex:0];
                marker.position = ccp(62,255);
                NSLog(@"Placed marker at position 0");
            }
        }
        if(location.x > 110 && location.x < 203){
            if([[_markers objectAtIndex:1] intValue] == 0){
                [_markers insertObject:curPlayer atIndex:1];
                marker.position = ccp(160,255);
            }
        }        
    }
    else {
        return;
    }

    
    [self addChild:marker];
    
}

-(void) ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
   
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInView:[touch view]];
    location = [[CCDirector sharedDirector] convertToGL:location];
    
    [self addMarker:location];
}


// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
	// in case you have something to dealloc, do it in this method
	// in this particular example nothing needs to be released.
	// cocos2d will automatically release all the children (Label)
	
    [_markers release];
    _markers = nil;
    
	// don't forget to call "super dealloc"
	[super dealloc];
}
@end
