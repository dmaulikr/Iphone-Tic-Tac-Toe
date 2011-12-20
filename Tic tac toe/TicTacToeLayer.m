//
//  HelloWorldLayer.m
//  Tic tac toe
//
//  Created by Stefan Mortensen on 2011-12-19.
//  Creative Commons Share Alike 2.5 Generic
//  http://creativecommons.org/licenses/by-sa/2.5/
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
    
    // remove sprites if any
    int arrayCount = [_markersprites count];
    for (i = 0; i < arrayCount; i++) {    
        // Do your thing with the object.
        [self removeChild:[_markersprites objectAtIndex:i] cleanup:YES];
    }
    curPlayer = @"1";
    
}

-(CCLabelTTF *) displayMessage :(NSString *)mess position:(CGPoint)position size:(int)size {


	CCLabelTTF *myLabel = [CCLabelTTF labelWithString:mess fontName:@"Marker Felt" fontSize:size];
    myLabel.position =  position;

    [self addChild: myLabel];  
    return myLabel;
    
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
        _markersprites = [[NSMutableArray alloc] init];
                        
        // ask director the the window size
		CGSize size = [[CCDirector sharedDirector] winSize];
        
        // create the background sprite
        CCSprite *gamefield = [CCSprite spriteWithFile:@"gamefield.png"];
        gamefield.position = ccp(size.width / 2,size.height / 2);
        
        [self addChild:gamefield];

        headermsg = [self displayMessage:@"Tic Tac Toe" position:CGPointMake(size.width /2 , size.height - 64)size:64];
        startmsg = [self displayMessage:@"Touch to start playing!" position:CGPointMake(size.width /2 , size.height - 120)size:32];
        turnmsg = [self displayMessage:@"" position:CGPointMake(size.width /2 , size.height - 120)size:32];
        // reset markers
        [self resetMarkers];
	}
	return self;
}

-(int) checkWinner {
    
    int i;
    for(i = 0; i <= 9; i++){
        // Check for horizontal rows
        if([_markers objectAtIndex:1] == @"1" && [_markers objectAtIndex:2] == @"1" && [_markers objectAtIndex:3] == @"1") return 1;
        if([_markers objectAtIndex:4] == @"1" && [_markers objectAtIndex:5] == @"1" && [_markers objectAtIndex:6] == @"1") return 1;
        if([_markers objectAtIndex:6] == @"1" && [_markers objectAtIndex:8] == @"1" && [_markers objectAtIndex:9] == @"1") return 1;
        
        if([_markers objectAtIndex:1] == @"2" && [_markers objectAtIndex:2] == @"2" && [_markers objectAtIndex:3] == @"2") return 2;
        if([_markers objectAtIndex:4] == @"2" && [_markers objectAtIndex:5] == @"2" && [_markers objectAtIndex:6] == @"2") return 2;
        if([_markers objectAtIndex:6] == @"2" && [_markers objectAtIndex:8] == @"2" && [_markers objectAtIndex:9] == @"2") return 2;
        
        // Check for vertical rows
        if([_markers objectAtIndex:1] == @"1" && [_markers objectAtIndex:4] == @"1" && [_markers objectAtIndex:6] == @"1") return 1;
        if([_markers objectAtIndex:2] == @"1" && [_markers objectAtIndex:5] == @"1" && [_markers objectAtIndex:8] == @"1") return 1;
        if([_markers objectAtIndex:3] == @"1" && [_markers objectAtIndex:6] == @"1" && [_markers objectAtIndex:9] == @"1") return 1;

        if([_markers objectAtIndex:1] == @"2" && [_markers objectAtIndex:4] == @"2" && [_markers objectAtIndex:6] == @"2") return 2;
        if([_markers objectAtIndex:2] == @"2" && [_markers objectAtIndex:5] == @"2" && [_markers objectAtIndex:8] == @"2") return 2;
        if([_markers objectAtIndex:3] == @"2" && [_markers objectAtIndex:6] == @"2" && [_markers objectAtIndex:9] == @"2") return 2;
        
        // Check for diagonal rows
        if([_markers objectAtIndex:1] == @"1" && [_markers objectAtIndex:5] == @"1" && [_markers objectAtIndex:9] == @"1") return 1;
        if([_markers objectAtIndex:3] == @"1" && [_markers objectAtIndex:5] == @"1" && [_markers objectAtIndex:7] == @"1") return 1;    

        if([_markers objectAtIndex:1] == @"2" && [_markers objectAtIndex:5] == @"2" && [_markers objectAtIndex:9] == @"2") return 1;
        if([_markers objectAtIndex:3] == @"2" && [_markers objectAtIndex:5] == @"2" && [_markers objectAtIndex:7] == @"2") return 1;    
        
        // If all markers is place no one won
        if([_markers objectAtIndex:1] != @"0" && [_markers objectAtIndex:2] != @"0" && [_markers objectAtIndex:3] != @"0"
        && [_markers objectAtIndex:4] != @"0" && [_markers objectAtIndex:5] != @"0" && [_markers objectAtIndex:6] != @"0"
        && [_markers objectAtIndex:7] != @"0" && [_markers objectAtIndex:8] != @"0" && [_markers objectAtIndex:9] != @"0") return 3;
    }    
    return 0;
}

-(void) placeMarker:(int)position {
    int markY;
    int markX;
    int paddingX = 62;
    int addX = 98;
    
    CCSprite *marker;
    
    if(curPlayer == @"1") {
        marker = [CCSprite spriteWithFile:@"x.png"];
    } else {
        marker = [CCSprite spriteWithFile:@"o.png"];
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
        [_markersprites insertObject:marker atIndex:0];
        NSLog(@"Adding marker at position %d",position); 
    }
    
    int winner = [self checkWinner];
    if(winner){
        // We got a winner!
        NSLog(@"We have a winner: %d",winner);
        gameActive = false;
        if(winner == 1){ 
            [turnmsg setString:@"Player X Won!"]; 
        }else if (winner == 3){
            [turnmsg setString:@"It's a draw!"];      
        }
        else {
            [turnmsg setString:@"Player O Won!"];   
        }
        return;
    }
    
    if(curPlayer == @"1") { 
        curPlayer = @"2";
        [turnmsg setString:@"Player O"];
    }
    else {
        curPlayer = @"1";
         [turnmsg setString:@"Player X"];
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
    
    if(gameActive == true){   
        UITouch *touch = [touches anyObject];
        CGPoint location = [touch locationInView:[touch view]];
        location = [[CCDirector sharedDirector] convertToGL:location];
    
        [self addMarker:location];
    } else {
        [self removeChild:startmsg cleanup:TRUE];

        [turnmsg setString:@"Player X"];
        gameActive = true;
        [self resetMarkers];
    }
}


// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
	// in case you have something to dealloc, do it in this method
	// in this particular example nothing needs to be released.
	// cocos2d will automatically release all the children (Label)
	
    [_markers release];
    _markers = nil;
    
    [_markersprites release];
    _markersprites = nil;
    
	// don't forget to call "super dealloc"
	[super dealloc];
}
@end
