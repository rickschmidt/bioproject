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

@interface AppController : NSObject <CPPlotDataSource> {
	
	IBOutlet NSTextField *csvInputTextBox;
	IBOutlet NSButton *addTextField;
	IBOutlet NSTextField *inputTextField; //on RSInputMenu View
	IBOutlet RSInputMenuView *inputMenuView; //on RSInputMenu View
	NSArray *nodes;
	NSMutableArray *inputArray;
	NSString *inputString;
	NSMutableDictionary *specificNodes;
	IBOutlet NSWindow *mainApplicationWindow;
	//NSArrayController *arrayController;
	NSMutableArray *inputArrayMenu;
	NSString *inputText;
	NSRect oldWindowFrame;

	
}
@property(copy,nonatomic)NSArray *nodes;
//@property(copy,nonatomic)NSMutableArray *inputArray;
@property(readwrite,copy)NSString *inputString;
@property(readwrite,copy)NSString *inputText;

-(void)awakeFromNib;
-(IBAction)blastWithBlastcl3:(id)sender;
-(IBAction)xmlStuff:(id)sender;
-(IBAction)addButton:(id)sender;
-(IBAction)addNewInputFile:(id)sender;
- (IBAction) displayInputView:(id)sender;
-(NSArray *)csvSplit;
-(NSArray *)returnNodes;

@end
