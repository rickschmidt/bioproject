//
//  RSGraphWindow.h
//
//  Created by Rick Schmidt on 3/15/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface NSWindow : NSResponder {
    IBOutlet id delegate;
    IBOutlet NSView *initialFirstResponder;
    IBOutlet NSMenu *menu;
}
- (IBAction)deminiaturize:(id)sender;
- (IBAction)makeKeyAndOrderFront:(id)sender;
- (IBAction)miniaturize:(id)sender;
- (IBAction)orderBack:(id)sender;
- (IBAction)orderFront:(id)sender;
- (IBAction)orderOut:(id)sender;
- (IBAction)performClose:(id)sender;
- (IBAction)performMiniaturize:(id)sender;
- (IBAction)performZoom:(id)sender;
- (IBAction)print:(id)sender;
- (IBAction)runToolbarCustomizationPalette:(id)sender;
- (IBAction)toggleToolbarShown:(id)sender;
@end
