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
	//NSLog(@"arary %@",nodes);
	return nodes;
		
}

-(NSMutableDictionary *)getSpecificNode
{
	NSError *err;
	NSMutableDictionary *specificNodes=[[NSMutableDictionary alloc]init];
	int j=1;
	NSString *str1=@".//Hit[";
	NSNumber *k=[NSNumber numberWithInt:j];
	for(int x=1;x<50;x++){
		
		str1=[str1	stringByAppendingFormat:@"%d]/Hit_def[",x];
		str1=[str1 stringByAppendingFormat:@"%d]",1];
		//NSLog(@"str1 %@",str1);
		if (![specificNodes objectForKey:[xmlDoc nodesForXPath:str1  error:&err]]) {
			[specificNodes setObject:k forKey:[xmlDoc nodesForXPath:str1 error:&err]];

		}
		else if ([specificNodes objectForKey:[xmlDoc nodesForXPath:str1  error:&err]])   {
			[specificNodes setObject:[NSNumber numberWithInt:[[specificNodes objectForKey:[xmlDoc nodesForXPath:str1 error:&err]] intValue]+1] forKey:[xmlDoc nodesForXPath:str1  error:&err]];
		}

		//NSLog(@"key %@ value %@",[specificNodes allKeys],[specificNodes allValues]);
		str1=@".//Hit[";
	}
	return specificNodes;
}


@end
