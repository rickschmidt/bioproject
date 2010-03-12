//
//  RSInputMenu.h
//  BioVizCorePlot18
//
//  Created by Rick Schmidt on 3/12/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface RSInputMenuView : NSView {
	IBOutlet NSTextField *inputTextField;
	NSString *inputText;
	

}
@property(readwrite,copy)NSString *inputText;


@end
