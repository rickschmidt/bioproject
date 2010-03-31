//
//  RSBlastOneWithConcurrecny.m
//  BioVizCorePlot18
//
//  Created by Rick Schmidt on 3/30/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "RSBlastOneWithConcurrecny.h"


@implementation RSBlastOneWithConcurrecny


@synthesize taskShouldLaunch;

-(void)initWithArray:(NSArray *)array
{
	seqArray=array;
}

-(id)initWithParameters:(int)number andString:(NSString *)str
{
	self=[super init];
	k=number;
	blastInput=str;
	[self blast];
	
	
	
	return self;
}
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


-(id)blast
{
	
	//NSString *inputPath=[AppController textFieldInputSequence stringValue];                                                                                                  \
	
	
	NSTask *task;
	task=[[NSTask alloc]init];                                                                                                                                 \
	[task setLaunchPath:[[NSBundle mainBundle] pathForResource:@"blastcl3" ofType:nil]];                                                                         \
	
	NSCalendarDate *now;
	now=[NSCalendarDate calendarDate];
	
	
	
	NSString *numberString=[NSString stringWithFormat:@"%d",k];
	
	
	
	NSString *outPath2=[[self pathForBlastOutput] stringByAppendingString:numberString];;
	NSString *outPath=[outPath2 stringByAppendingString:@".xml"];
	
	NSString *inPath=blastInput;
	
	NSLog(@"the outpath is %@", outPath);	
 	NSMutableArray *blastArgs=[NSMutableArray array];                                                                                                          \
	[blastArgs addObject:@"-p"];                                                                                                                               \
	[blastArgs addObject:@"blastn"];                                                                                                                           \
	[blastArgs addObject:@"-i"];                                                                                                                               \
	[blastArgs addObject:inPath];    
	[blastArgs addObject:@"-F"];     
	[blastArgs addObject:@"m D"];     
	
	[blastArgs addObject:@"-d"];                                                                                                                               \
	[blastArgs addObject:@"nt"]; 
	[blastArgs addObject:@"-m"];
	[blastArgs addObject:@"7"];
	[blastArgs addObject:@"-o"];                                                                                                                               \
	[blastArgs addObject:outPath];   
	NSLog(@"outpath %@", outPath);
	
	
	[task setArguments: blastArgs];                                                                                                                            \
	
	NSPipe *pipe;                                                                                                                                              \
	pipe = [NSPipe pipe];                                                                                                                                      \
	[task setStandardOutput: pipe];                                                                                                                            \
	\
	NSFileHandle *file;                                                                                                                                        \
	file = [pipe fileHandleForReading];  
	
	//aQueue = [NSOperationQueue new];
	
	[task launch];
	
	
	
	NSData *data;                                                                                                                                              \
	data = [file readDataToEndOfFile];                                                                                                                         \
	
	NSString *string;                                                                                                                                          \
	string = [[NSString alloc] initWithData: data encoding: NSUTF8StringEncoding];                                                                             \
	NSLog (@"got\n%@", string);    
}

#pragma mark -
#pragma mark Delegate Methods

-(void)shouldTaskLaunchNo{

	//shouldTaskLaunch=NO;
}
-(void)shouldTaskLaunchYes{
	//shouldTaskLaunch=YES;
}
@end
