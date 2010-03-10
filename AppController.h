//
//  AppController.h
//  BioVizCorePlot18
//
//  Created by Rick Schmidt on 3/8/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "Blast.h"
#import "RSParser.h"
@interface AppController : NSObject {
	
	IBOutlet NSTextField *csvInputTextBox;
	IBOutlet NSButton *addTextField;
	NSArray *nodes;
	//NSArrayController *arrayController;
}
@property(copy,nonatomic)NSArray *nodes;
-(void)awakeFromNib;
-(IBAction)blastWithBlastcl3:(id)sender;
-(IBAction)xmlStuff:(id)sender;
-(IBAction)addButton:(id)sender;
-(NSArray *)csvSplit;
@end
