//
//  AppController.h
//  BioVizCorePlot18
//
//  Created by Rick Schmidt on 3/7/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <CorePlot/CorePlot.h>
#import "AppController.h"

@interface CorePlotView : NSObject <CPPlotDataSource, CPPlotSpaceDelegate>{
	
	IBOutlet CPLayerHostingView *hostView;
	CPXYGraph *graph;
	CGFloat xShift;
    CGFloat yShift;
    CGFloat labelRotation;
	IBOutlet NSDrawer *drawer;
	NSArray *nodes;
//	IBOutlet NSWindow *mainApplicationWindow;
}
@property CGFloat xShift;
@property CGFloat yShift;
@property CGFloat labelRotation;

-(NSArray *)getNodesArray;
@end
