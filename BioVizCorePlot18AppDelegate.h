//
//  BioVizCorePlot18AppDelegate.h
//  BioVizCorePlot18
//
//  Created by Rick Schmidt on 3/7/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <CorePlot/CorePlot.h>
#import "AppController.h"


@interface BioVizCorePlot18AppDelegate : NSObject <NSApplicationDelegate> {
    NSWindow *window;
	NSWindow *graphWindow;
}

@property (assign) IBOutlet NSWindow *window;
@property (assign) IBOutlet NSWindow *graphWindow;


@end
