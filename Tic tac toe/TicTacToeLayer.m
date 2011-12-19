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
    for(i = 0; i <= 10; i++){
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
    CCSprite *marker;
    
    NSLog(@"TouchedX:%f TouchedY:%f",location.x,location.y);   
    if(curPlayer == @"1") {
        marker = [CCSprite spriteWithFile:@"x.png"];
        curPlayer = @"2";
    } else {
        marker = [CCSprite spriteWithFile:@"o.png"];
        curPlayer = @"1";
    }
    
    int i;
    for(i = 1; i <= 9; i++){
        NSLog(@"Object at %d: %d",i,[[_markers objectAtIndex:i]intValue]); 
    }
    
    // Calculate what field to place marker in

    // Ignore clicks outside of playing field
    if(location.x < 17 || location.x > 303) return;
    if(location.y < 13 || location.y > 306) return;
    
    // Top row 
    if(location.y < 306 && location.y > 213){
        
        if(location.x > 15 && location.x < 108){
            if([_markers objectAtIndex:1] == @"0"){
                [_markers replaceObjectAtIndex:1 withObject:curPlayer];
                marker.position = ccp(62,255);
                [self addChild:marker];
                NSLog(@"Adding marker at position 1"); 
                return;
            }
        }

        if(location.x > 110 && location.x < 203){
             if([_markers objectAtIndex:2] == @"0"){
                [_markers replaceObjectAtIndex:2 withObject:curPlayer];
                marker.position = ccp(160,255);
                [self addChild:marker];
                  NSLog(@"Adding marker at position 2"); 
                 return;
            }
        }  
        if(location.x > 205 && location.x < 298){
             if([_markers objectAtIndex:3] == @"0"){
                [_markers replaceObjectAtIndex:3 withObject:curPlayer];
                marker.position = ccp(258,255);
                [self addChild:marker];
                  NSLog(@"Adding marker at position 3"); 
                 return;
            }
        } 
    }
    // Middle row
    else if(location.y < 204 && location.y > 113){
        
        if(location.x > 15 && location.x < 108){
             if([_markers objectAtIndex:4] == @"0"){
                [_markers replaceObjectAtIndex:4 withObject:curPlayer];
                marker.position = ccp(62,158);
                [self addChild:marker];
                  NSLog(@"Adding marker at position 4"); 
                 return;
            }
        }
        if(location.x > 110 && location.x < 203){
             if([_markers objectAtIndex:5] == @"0"){
                [_markers replaceObjectAtIndex:5 withObject:curPlayer];
                marker.position = ccp(160,158);
                [self addChild:marker];
                  NSLog(@"Adding marker at position 5"); 
                 return;
            }
        }  
        if(location.x > 205 && location.x < 298){
             if([_markers objectAtIndex:6] == @"0"){
                [_markers replaceObjectAtIndex:6 withObject:curPlayer];
                marker.position = ccp(258,158);
                [self addChild:marker];
                  NSLog(@"Adding marker at position 6"); 
                 return;
            }
        } 
    }
    // Bottom row
    else if(location.y < 108 && location.y > 16){
        
        if(location.x > 15 && location.x < 108){
             if([_markers objectAtIndex:7] == @"0"){
                [_markers replaceObjectAtIndex:7 withObject:curPlayer];
                marker.position = ccp(62,60);
                [self addChild:marker];
                  NSLog(@"Adding marker at position 7"); 
                 return;
            }
        }
        if(location.x > 110 && location.x < 203){
             if([_markers objectAtIndex:8] == @"0"){
                [_markers replaceObjectAtIndex:8 withObject:curPlayer];
                marker.position = ccp(160,60);
                [self addChild:marker];
                  NSLog(@"Adding marker at position 8"); 
                 return;
            }
        }  
        if(location.x > 205 && location.x < 298){
             if([_markers objectAtIndex:9] == @"0"){
                [_markers replaceObjectAtIndex:9 withObject:curPlayer];
                marker.position = ccp(258,60);
                [self addChild:marker];
                  NSLog(@"Adding marker at position 9"); 
                 return;
            }
        } 
    }
    else {
        return;
    }

    

    
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
