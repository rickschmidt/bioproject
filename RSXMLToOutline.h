//
//  RSXMLToOutline.h
//  BioVizCorePlot18
//
//  Created by Rick Schmidt on 3/10/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface RSXMLToOutline : NSObject {

	NSXMLDocument *theDocument;
	
}

- (BOOL)readFromData:(NSData *)data ofType:(NSString *)typeName error:(NSError **)outError;
- (NSXMLDocument *)theDocument;
- (void)setTheDocument:(NSXMLDocument *)newTheDocument;

@end
