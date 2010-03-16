//
//  BioVizCorePlot18AppDelegate.m
//  BioVizCorePlot18
//
//  Created by Rick Schmidt on 3/7/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "BioVizCorePlot18AppDelegate.h"

@implementation BioVizCorePlot18AppDelegate

@synthesize window;
@synthesize graphWindow;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
	// Insert code here to initialize your application
	NSLog(@"APPDelegate//LAUNCHED");
}

- (void)windowShouldClose:(NSWindow *)sender                              // 1
{
	[graphWindow setReleasedWhenClosed:NO];
	
}

//-(void)array

@end
