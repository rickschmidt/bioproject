//
//  RSXMLToOutline.m
//  BioVizCorePlot18
//
//  Created by Rick Schmidt on 3/10/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "RSXMLToOutline.h"


@implementation RSXMLToOutline

- (BOOL)readFromData:(NSData *)data ofType:(NSString *)typeName error:(NSError **)outError

{
	
    NSXMLDocument *newDocument = [[NSXMLDocument alloc] initWithData:data
								  
															 options:NSXMLNodeOptionsNone error:nil];
	
    [self setTheDocument:newDocument];
	
    [newDocument release];
	
    return YES;
	
}



- (NSXMLDocument *)theDocument

{
	
    return [[theDocument retain] autorelease];
	
}



- (void)setTheDocument:(NSXMLDocument *)newTheDocument

{
	
    if (theDocument != newTheDocument)
		
    {
		
        [newTheDocument retain];
		
        [theDocument release];
		
        theDocument = newTheDocument;
		
    }
	
}

@end
