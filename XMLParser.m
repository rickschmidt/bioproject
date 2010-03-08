//
//  XMLParser.m
//  BioVizCorePlot18
//
//  Created by Rick Schmidt on 3/8/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "XMLParser.h"


@implementation XMLParser

-(void)initXML
{
	//[//xmlDoc release];

		
		NSError *err;
	NSString *inPath=@"/Users/rickschmidt/BioViz/BlastResults/out.xml";
	NSData *data=[NSData dataWithContentsOfFile:inPath];
//	NSString *xmlString=[NSString stringWithContentsOfFile:inPath encoding:NSASCIIStringEncoding error:err];
	xmlDoc=[[NSXMLDocument alloc] initWithData:data options:0 error:&err];
	//NSLog(@"xmLDOC %@",xmlDoc);
}

-(NSArray *)getArrayForNode:(NSString *)nodeDesired
{
	NSArray *nodes;
	NSError *err;
	nodes=[[xmlDoc nodesForXPath:nodeDesired error:&err]retain];
	NSLog(@"arary %@",nodes);
	return nodes;
		
}


@end
