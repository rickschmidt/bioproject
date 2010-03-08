 //
//  blast.m
//  countCharacters
//
//  Created by Rick Schmidt on 7/17/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "Blast.h"

#import "XMLParser.h"

@implementation Blast


-(void)blast:(NSInteger )i
{
	i++;
	//NSString *inputPath=[AppController textFieldInputSequence stringValue];                                                                                                  \
	
	XMLParser *xmlParse;
	xmlParse=[[XMLParser alloc]init];
	[xmlParse initXML:xmlDoc];
	NSTask *task;                                                                                                                                              \
	task=[[NSTask alloc]init];                                                                                                                                 \
	[task setLaunchPath:[[NSBundle mainBundle] pathForResource:@"blastcl3" ofType:nil]];                                                                         \
	//NSString *outPath=[[NSBundle mainBundle] pathForResource:@"outNow" ofType:@"txt"];
	NSCalendarDate *now;
	now=[NSCalendarDate calendarDate];
	//NSString *fileName=now;
	
	//NSLog(@"filename is %@", fileName);
	NSString *outPath=@"/Users/rickschmidt/BioViz/BlastResults/out.xml";
	//NSString *inPath=@"/Users/rickschmidt/Desktop/seqShort.txt"; 
	NSString *inPath=@"/Users/rickschmidt/BioViz/BlastResults/seqShort.txt";
	NSString *inti=[NSString stringWithFormat:@"%d",i];
	NSLog(@"the outpath is %@", outPath);	NSMutableArray *blastArgs=[NSMutableArray array];                                                                                                          \
	[blastArgs addObject:@"-p"];                                                                                                                               \
	[blastArgs addObject:@"blastn"];                                                                                                                           \
	[blastArgs addObject:@"-i"];                                                                                                                               \
	[blastArgs addObject:inPath];    
	[blastArgs addObject:@"-F"];     
	[blastArgs addObject:@"m D"];     
	                                                                                                                          \
	[blastArgs addObject:@"-d"];                                                                                                                               \
	[blastArgs addObject:@"nt"]; 
	[blastArgs addObject:@"-m"];
	[blastArgs addObject:@"7"];
	[blastArgs addObject:@"-o"];                                                                                                                               \
	[blastArgs addObject:outPath];   
	NSLog(@"outpath %@", outPath);
	
	//arguments = [NSArray arrayWithObjects: @"-p",@"blastn", @"-i",@"%d", @"-p",@"blastn", @"-d",@"nr",@"-o",@"/Users/rickschmidt/out2.txt", inputPath];      \
	//./blastcl3 -p blastn -i /Users/rickschmidt/seqFile2.txt -p blastn -d nr -o /Users/rickschmidt/out2.out                                                   
	[task setArguments: blastArgs];                                                                                                                            \
	
	NSPipe *pipe;                                                                                                                                              \
	pipe = [NSPipe pipe];                                                                                                                                      \
	[task setStandardOutput: pipe];                                                                                                                            \
	\
	NSFileHandle *file;                                                                                                                                        \
	file = [pipe fileHandleForReading];                                                                                                                        \
	\
	[task launch];                                                                                                                                             \
	\
	while ([task isRunning]) {
		[self taskRunning];
	}
	NSData *data;                                                                                                                                              \
	data = [file readDataToEndOfFile];                                                                                                                         \
	\
	NSString *string;                                                                                                                                          \
	string = [[NSString alloc] initWithData: data encoding: NSUTF8StringEncoding];                                                                             \
	NSLog (@"got\n%@", string);    
	}

-(void)blastMany:(NSArray *)seqArray
{
	
}

-(bool)taskRunning
{
	bool blastFinished=0;
	NSLog(@"here!");
	return blastFinished;
}
-(NSString *)blastOutPath:(NSString *)fileName
{
	NSString *outPath=[[NSBundle mainBundle] pathForResource:fileName ofType:@"xml"];
	NSLog(@"outPath @%", outPath);
	return outPath;
}
-(void)setDelegate:(id)finishedBlasting1
{
	finishedBlasting=0;
}

@end
