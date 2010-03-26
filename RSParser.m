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
	//NSError *err;
//	NSString *inPath=@"/Users/rickschmidt/BioViz/BlastResults/out0.xml";
//	NSData *data=[NSData dataWithContentsOfFile:inPath];
//	//	NSString *xmlString=[NSString stringWithContentsOfFile:inPath encoding:NSASCIIStringEncoding error:err];
//	xmlDoc=[[NSXMLDocument alloc] initWithData:data options:0 error:&err];
	return self;
}
-(void)initXML
{
	//[//xmlDoc release];
	
	
	NSError *err;
	NSString *inPath=@"/Users/rickschmidt/Library/Application Support/BioProject/BLAST_results_0.xml";
	NSData *data=[NSData dataWithContentsOfFile:inPath];
	//	NSString *xmlString=[NSString stringWithContentsOfFile:inPath encoding:NSASCIIStringEncoding error:err];
	xmlDoc=[[NSXMLDocument alloc] initWithData:data options:0 error:&err];
	//NSLog(@"xmLDOC %@",xmlDoc);
}

-(NSArray *)initWithDirectoryOfXML
{
	//Scans Through the Application Support Dir for XML files, adds them all to an array.
	
	
	NSError *err;
	NSFileManager *fileManager=[[NSFileManager alloc]init];
	NSString *folder=@"~/Library/Application Support/BioProject";
	folder=[folder stringByExpandingTildeInPath];
	NSArray *inputFiles=[fileManager contentsOfDirectoryAtPath:folder error:&err];
	NSMutableArray *xmlArray=[[NSMutableArray alloc]init];
	NSXMLDocument *localXMLDoc;
	for( NSString *inPath in inputFiles){
		NSData *data=[NSData dataWithContentsOfFile:[folder stringByAppendingPathComponent:inPath]];
		localXMLDoc=[[NSXMLDocument alloc] initWithData:data options:0 error:&err];
		[xmlArray addObject:localXMLDoc];
				
	}
	NSArray *arrayOfXMLFiles=xmlArray;
	return arrayOfXMLFiles;
}
-(NSArray *)initWithDirectoryOfXMLPaths
{
	//Scans Through the Application Support Dir for XML files, adds all of the PATHS to an array.
	
	
	NSError *err;
	NSFileManager *fileManager=[[NSFileManager alloc]init];
	NSString *folder=@"~/Library/Application Support/BioProject";
	folder=[folder stringByExpandingTildeInPath];
	NSArray *inputFiles=[fileManager contentsOfDirectoryAtPath:folder error:&err] ;
	NSMutableArray *arrayOfPaths=[[NSMutableArray alloc]init];
	for( NSString *inPath in inputFiles){
		[arrayOfPaths addObject: [folder stringByAppendingPathComponent:inPath]];

		
	}
	NSArray *arrayOfXMLPaths=arrayOfPaths;
	NSLog(@"//rsparser/initwithDiroFXMLPaths/ %@",[arrayOfXMLPaths objectAtIndex:1]);
	return arrayOfXMLPaths;
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

-(NSMutableDictionary *)getSpecificNodeForMany:(NSArray *)withArrayOfXMLFiles
{
	NSError *err;
	NSMutableDictionary *specificNodes=[[NSMutableDictionary alloc]init];
	int j=1;
	NSString *str1=@".//Hit[";
	NSNumber *k=[NSNumber numberWithInt:j];
	for (NSXMLDocument *localXMLDoc in withArrayOfXMLFiles){
		
	
		for(int x=1;x<50;x++){
			
			str1=[str1	stringByAppendingFormat:@"%d]/Hit_def[",x];
			str1=[str1 stringByAppendingFormat:@"%d]",1];
			NSArray *xPathArray=[localXMLDoc nodesForXPath:str1 error:&err];
			//NSLog(@"str1 %@",str1);
			if (![specificNodes objectForKey:xPathArray]) {
				[specificNodes setObject:k forKey:xPathArray];
				
			}
			else if ([specificNodes objectForKey:xPathArray])   {
				[specificNodes setObject:[NSNumber numberWithInt:[[specificNodes objectForKey:xPathArray] intValue]+1] forKey:xPathArray];
			}
			
			//NSLog(@"key %@ value %@",[specificNodes allKeys],[specificNodes allValues]);
			str1=@".//Hit[";
			[xPathArray release];
		}
		
	}
	return specificNodes;
}

-(NSMutableDictionary *)getSpecificNodeForManyWithParser:(NSArray *)withArrayOfXMLPaths
{
	NSMutableDictionary *specificNodes=[[NSMutableDictionary alloc]init];
	for (NSString *localXMLPath	in withArrayOfXMLPaths){
		NSData *xmlData=[[NSData alloc] initWithContentsOfFile:localXMLPath];
		NSXMLParser *parser=[[NSXMLParser alloc]initWithData:xmlData];
		[parser setDelegate:self];
		NSLog(@"//rsparser/getspecNodForManyWPar/ %@ ",[parser delegate]);
		[parser parse];
	}
	return specificNodes;
}


-(void)parser:(NSXMLParser *)parser foundElementDeclarationWithName:(NSString *)elementName model:(NSString *)model
{
	if (elementName=@"Hit_def") {
		NSLog(@"found hit_def");
	}
}

- (void)parserDidStartDocument:(NSXMLParser *)parser
{
	NSLog(@"//rsparser/parserdidStartdoc/made it here");
}
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qualifiedName attributes:(NSDictionary *)attributeDict
{
	if (elementName=@"Hit_id") {
		NSMutableDictionary *specificNodes=[[NSMutableDictionary alloc]init];
		//[attributeDict objectForKey:@"Hit_def"]
		if (![specificNodes objectForKey:[attributeDict objectForKey:@"Hit_def"]]) {
			[specificNodes setObject:1 forKey:[attributeDict objectForKey:"Hit_def"]];
			
		}
		else if ([specificNodes objectForKey:[attributeDict objectForKey:"Hit_def"]])   {
			[specificNodes setObject:[NSNumber numberWithInt:[[specificNodes objectForKey:[attributeDict objectForKey:"Hit_def"]] intValue]+1] forKey:[attributeDict objectForKey:"Hit_def"]];
		}
		
	}
}

@end
