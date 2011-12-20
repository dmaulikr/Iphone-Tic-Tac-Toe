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

-(void) placeMarker:(int)position {
    int markY;
    int markX;
    int paddingX = 62;
    int addX = 98;
    
    CCSprite *marker;
    
    if(curPlayer == @"1") {
        marker = [CCSprite spriteWithFile:@"x.png"];
        curPlayer = @"2";
    } else {
        marker = [CCSprite spriteWithFile:@"o.png"];
        curPlayer = @"1";
    }
    
    // Top row
    if(position <= 3){
        markY = 255;
        markX = paddingX + ((position -1) * addX);
    } else if (position >=4 && position <=6){
        markY = 155;
        markX = paddingX + ((position -4) * addX);
    } else if (position >=7 && position <=9){
        markY = 58;
        markX = paddingX + ((position -7) * addX);
    }
    if([_markers objectAtIndex:position] == @"0"){
        [_markers replaceObjectAtIndex:position withObject:curPlayer];
        marker.position = ccp(markX,markY);
        [self addChild:marker];
        NSLog(@"Adding marker at position %d",position); 
    }
}

- (void) addMarker:(CGPoint)location {
    
    NSLog(@"TouchedX:%f TouchedY:%f",location.x,location.y);   

    
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
        
        if(location.x > 15 && location.x < 108) [self placeMarker:1];
        if(location.x > 110 && location.x < 203)[self placeMarker:2];
        if(location.x > 205 && location.x < 298)[self placeMarker:3];
        
    }
    // Middle row
    else if(location.y < 204 && location.y > 113){
        
        if(location.x > 15 && location.x < 108)[self placeMarker:4];
        if(location.x > 110 && location.x < 203)[self placeMarker:5];
        if(location.x > 205 && location.x < 298)[self placeMarker:6];
    }
    // Bottom row
    else if(location.y < 108 && location.y > 16){
        
        if(location.x > 15 && location.x < 108)[self placeMarker:7];
        if(location.x > 110 && location.x < 203)[self placeMarker:8];
        if(location.x > 205 && location.x < 298)[self placeMarker:9];
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
