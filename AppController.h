//
//  AppController.h
//  BioVizCorePlot18
//
//  Created by Rick Schmidt on 3/8/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <CorePlot/CorePlot.h>
#import "Blast.h"
#import "RSParser.h"
#import "RSInputMenuView.h"
//#import "CorePlotView.h"
#import <QuartzCore/CAAnimation.h>

@interface AppController : NSObject <CPPlotDataSource, CPPlotSpaceDelegate> {
	
	IBOutlet NSTextField *csvInputTextBox;
	IBOutlet NSButton *addTextField;
	IBOutlet NSTextField *inputTextField; //on RSInputMenu View
	IBOutlet RSInputMenuView *inputMenuView; //on RSInputMenu View
	NSArray *nodes;
	NSMutableArray *inputArray;
	NSString *inputString;
	NSMutableDictionary *specificNodes;
	IBOutlet NSWindow *mainApplicationWindow;
	IBOutlet NSArrayController *arrayController;
	NSMutableArray *inputArrayMenu;
	NSString *inputText;
	//NSRect oldWindowFrame;
	IBOutlet NSView *viewFromCorePlot;
	IBOutlet NSView *deleteView;
	IBOutlet NSWindow *graphWindow;
	NSMutableDictionary *theDictionary;
	
	//From CorePlotView
	
	IBOutlet CPLayerHostingView *hostView;
	CPXYGraph *graph;
	CGFloat xShift;
    CGFloat yShift;
    CGFloat labelRotation;
	IBOutlet NSDrawer *drawer;
	//NSArray *nodes;
	IBOutlet NSView *newView;
	//IBOutlet NSWindow *mainApplicationWindow;
	IBOutlet NSColorPanel *colorPanel;
	
	NSRect inputFrame;
	NSRect graphFrame;
	
	NSRect							oldWindowFrame;
	CATransition					*transition;
	NSDictionary					*currentAnimation;
	CPXYPlotSpace *plotSpace;
	
	//end from CorePlotView
}
@property(copy,nonatomic)NSArray *nodes;
@property(copy,nonatomic)NSMutableArray *inputArray;
@property(readwrite,copy)NSString *inputString;
@property(readwrite,copy)NSString *inputText;
//@property(readwrite,copy)BOOL *inputArrayHasMoreThanOne;
@property(readwrite)NSArrayController *arrayController;

//From CorePlotView
@property CGFloat xShift;
@property CGFloat yShift;
@property CGFloat labelRotation;

//end from coreplotview



-(void)awakeFromNib;
-(IBAction)blastWithBlastcl3:(id)sender;
-(IBAction)xmlStuff:(id)sender;
-(IBAction)addButton:(id)sender;
-(IBAction)addNewInputFile:(id)sender;
-(IBAction) displayInputView:(id)sender;
-(IBAction)displayCorePlot:(id)sender;
-(NSArray *)csvSplit;
-(NSArray *)returnNodes;
-(IBAction)logInputArrayContenets:(id)sender;
-(void)goGraph;
//From CorePlotView
-(NSArray *)getNodesArray;
-(IBAction) displayNewView:(id)sender;
-(void) setAnimationsTypes;

//end from coreplotview

-(IBAction)exportToPDF:(id)sender;
-(IBAction)exportToPNG:(id)sender;
-(IBAction)snapBackToCenterPlotRange:(id)sender;	
-(IBAction)openPanel:(id)sender;
@end
