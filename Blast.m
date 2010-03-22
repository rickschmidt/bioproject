 //
//  blast.m
//  countCharacters
//
//  Created by Rick Schmidt on 7/17/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "Blast.h"



@implementation Blast


-(NSString *)pathForBlastOutput
{
	NSError **err;
	NSFileManager *fileManager=[[NSFileManager alloc]init];
	NSString *folder=@"~/Library/Application Support/BioProject";
	folder=[folder stringByExpandingTildeInPath];
	
	if([fileManager fileExistsAtPath:folder]==NO)
	{
		[fileManager createDirectoryAtPath:folder withIntermediateDirectories:YES attributes:nil error:err];
		
	}
	NSString *fileName=@"BLAST_results_";
	return [folder stringByAppendingPathComponent:fileName];
}
-(void)blast:(int)k:(NSString *)blastInput
{

	//NSString *inputPath=[AppController textFieldInputSequence stringValue];                                                                                                  \
	
	RSParser *xmlParse;
	xmlParse=[[RSParser alloc]init];
	[xmlParse initXML];
	NSTask *task;                                                                                                                                              \
	task=[[NSTask alloc]init];                                                                                                                                 \
	[task setLaunchPath:[[NSBundle mainBundle] pathForResource:@"blastcl3" ofType:nil]];                                                                         \
	//NSString *outPath=[[NSBundle mainBundle] pathForResource:@"outNow" ofType:@"txt"];
	NSCalendarDate *now;
	now=[NSCalendarDate calendarDate];
	//NSString *fileName=now;
	
	//NSLog(@"filename is %@", fileName);
	NSString *numberString=[NSString stringWithFormat:@"%d",k];
	//NSString *outPath1=@"/Users/rickschmidt/BioViz/BlastResults/out";
	
	
	NSString *outPath2=[[self pathForBlastOutput] stringByAppendingString:numberString];;
	NSString *outPath=[outPath2 stringByAppendingString:@".xml"];
	
	//NSString *inPath=@"/Users/rickschmidt/Desktop/seqShort.txt"; 
//	NSString *inPath=@"/Users/rickschmidt/BioViz/BlastResults/seqShort.txt";
	NSString *inPath=blastInput;
	//NSString *inti=[NSString stringWithFormat:@"%d",i];
	NSLog(@"the outpath is %@", outPath);	
	NSMutableArray *blastArgs=[NSMutableArray array];                                                                                                          \
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


	int j=[seqArray count];
	for(int i=0; i<j;i++){
		NSArray *array1=[seqArray valueForKey:@"inputText"];
		NSString *str=[array1 objectAtIndex:i];
		NSLog(@"BLAST//blastMany/object at index i %@",str);

		[self blast:i:str];
	}

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


@end
