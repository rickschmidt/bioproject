//
//  blast.h
//  countCharacters
//
//  Created by Rick Schmidt on 7/17/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>

#import "AppController.h"
@interface Blast : NSObject {

	//IBOutlet NSTextField *textFieldInputSequence;
	IBOutlet NSProgressIndicator *progress;
	id finishedBlasting;
	NSXMLDocument *xmlDoc;
}
-(void)blast:(NSInteger )i;
-(void)blastMany:(NSArray *)seqArray;

-(NSArray *)csvSplit;
-(bool)taskRunning;
- (id)delegate; 
- (void)setDelegate:(id)finishedBlasting1;
@end
