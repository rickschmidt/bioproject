//
//  XMLParser.h
//  BioVizCorePlot18
//
//  Created by Rick Schmidt on 3/8/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface RSParser : NSObject <NSXMLParserDelegate>{
	
	NSXMLDocument *xmlDoc;
	NSArray *nodes;
	
}
-(void)initXML;
-(NSArray *)initWithDirectoryOfXML;
-(NSArray *)initWithDirectoryOfXMLPaths;
-(NSArray *)getArrayForNode:(NSString *)nodeDesired;
-(NSMutableDictionary *)getSpecificNode;
-(NSMutableDictionary *)getSpecificNodeForMany:(NSArray *)withArrayOfXMLFiles;
-(NSMutableDictionary *)getSpecificNodeForManyWithParser:(NSArray *)withArrayOfXMLPaths;
@end
