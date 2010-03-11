//
//  XMLParser.m
//  BioVizCorePlot18
//
//  Created by Rick Schmidt on 3/8/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "RSParser.h"


@implementation RSParser

-(id)init
{
	NSError *err;
	NSString *inPath=@"/Users/rickschmidt/BioViz/BlastResults/out0.xml";
	NSData *data=[NSData dataWithContentsOfFile:inPath];
	//	NSString *xmlString=[NSString stringWithContentsOfFile:inPath encoding:NSASCIIStringEncoding error:err];
	xmlDoc=[[NSXMLDocument alloc] initWithData:data options:0 error:&err];
	return self;
}
-(void)initXML
{
	//[//xmlDoc release];

		
		NSError *err;
	NSString *inPath=@"/Users/rickschmidt/BioViz/BlastResults/out0.xml";
	NSData *data=[NSData dataWithContentsOfFile:inPath];
//	NSString *xmlString=[NSString stringWithContentsOfFile:inPath encoding:NSASCIIStringEncoding error:err];
	xmlDoc=[[NSXMLDocument alloc] initWithData:data options:0 error:&err];
	//NSLog(@"xmLDOC %@",xmlDoc);
}

-(NSArray *)getArrayForNode:(NSString *)nodeDesired
{
	
	NSError *err;
	nodes=[[xmlDoc nodesForXPath:nodeDesired error:&err]retain];
	NSLog(@"arary %@",nodes);
	return nodes;
		
}

-(NSArray *)getSpecificNode
{
	NSError *err;
	NSMutableDictionary *specificNodes=[[NSMutableDictionary alloc]init];
	int j=1;
	NSNumber *i=[NSNumber numberWithInt:j];
	for(int x=0;x<5;x++){
		if (![specificNodes objectForKey:[xmlDoc nodesForXPath:[NSString stringWithFormat:@".//Hit[%d]/Hit_def[%d]",x,x]  error:&err]]) {
			[specificNodes setObject:i forKey:[xmlDoc nodesForXPath:@".//Hit[1]/Hit_def[1]" error:&err]];

		}
		else if ([specificNodes objectForKey:[xmlDoc nodesForXPath:[NSString stringWithFormat:@".//Hit[%d]/Hit_def[%d]",x,x]  error:&err]])   {
			i=[NSNumber numberWithInt:[i intValue]+1];
			[specificNodes setObject:i forKey:[xmlDoc nodesForXPath:[NSString stringWithFormat:@".//Hit[%d]/Hit_def[%d]",x,x]  error:&err]];
		}
	
	
	
		NSLog(@"key %@", [specificNodes objectForKey:[xmlDoc nodesForXPath:[NSString stringWithFormat:@".//Hit[ %@]/Hit_def[ %@]",x,x] error:&err]]);
		NSLog(@"key %@ value %@",[specificNodes allKeys],[specificNodes allValues]);
	}
	return nil;
}


@end
