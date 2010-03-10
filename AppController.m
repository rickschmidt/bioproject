//
//  AppController.m
//  BioVizCorePlot18
//
//  Created by Rick Schmidt on 3/8/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "AppController.h"


@implementation AppController


@synthesize nodes;
//@synthesize inputArray;
@synthesize inputString;
-(id)init
{
	self=[super init];
	
	
	RSParser *xmlStuff;
	xmlStuff=[[RSParser alloc]init];
	[xmlStuff initXML];
	nodes=[xmlStuff getArrayForNode:@".//Hit_id"];
	inputArray=[[NSMutableArray alloc]init];
		//NSLog(@"node object at index 2 %@",[nodes objectAtIndex:2]);
	
	return self;
	
}
-(IBAction)blastWithBlastcl3:(id)sender{
	Blast *blastControl;
	blastControl=[[Blast alloc]init];
	NSInteger i=5;
	NSArray *inputSeqs;
	inputSeqs=[self csvSplit];
	//[blastControl blast:i];
	[blastControl blastMany:inputSeqs];
	NSLog(@"Done");
}
-(IBAction )xmlStuff:(id)sender
{
	RSParser *xmlStuff;
	xmlStuff=[[RSParser alloc]init];
	[xmlStuff initXML];
	nodes=[xmlStuff getArrayForNode:@".//Hit_id"];
	NSLog(@"input array %@",[inputArray objectAtIndex:0]);
	NSLog(@"input array22 %@",[inputArray objectAtIndex:1]);
	NSString *string1=[[inputArray objectAtIndex:0] description];
	NSString *string2=[[inputArray objectAtIndex:1]description];
	NSLog(@"string1 %d", string1);
	NSLog(@"string2 %@", string2);
	NSLog(@"inputArray %@",inputArray);
	

	
}
-(NSArray *)csvSplit
{
	//	NSString *returnValue=[csvInputField stringValue];
	//NSString *returnValue=@"CAGTGAATTCGAGCTCGGTACCCGGGGATCCTCTAGAGGGTTCTTAGAATTAAGTATTAGACAAAAAAGAAAATTTGATTCTTGGAAAAGATTATCAGAATTATATGAAAATCCAATTGTTATGTCACCATATTTATATAATAATTGTATAAGACAAGGTTTTGTTGCGGATTGTTCTTTTCTGTCTTCATTAACAGTATTAATAGAATATGAGAAAAAACATAAGATACCTGTTATTTCTAGTATTATAACACCTTGTAGTTGGAATTATTTATGTATAAATAAAACGTGGCCTATTTTTAATCCTTGTGGTATGTATATATGTAGACTTCATTGTAATGGTATACAAAGAAAGATAATAATAGATGATTATGTACCGGTTAAGAACAATAATTCATTGCTTGTGGCTTATTCAAATAATCAAAAAGAATTATGGGTTACCTTATTAGAAAAAGCTTTTGTTAAATTGATGGGAGGATCATATTCTATGTTTGGTTCTAATCCTGGTTCTGATTTGTATTATTTGACAGGTTGGATACCAGTAACCATATCTTTGAAATCTAAGATTAGTAGTTCTCCCCCTTCTTTTGACAAACATAGTACGCATTCTTTAATAAGGGATGAGCGTATAGATGAATGGNATATGAAACTAACGAGGTAATGATAAATAAGAAACATGGATATGTTACAGTGTTGAATTTGTAGAGGACCCAAAGTATAATCATATTATTATTATTATTATTATTTAAAATAATCGGAACTTGATCCAAATTGTGTGAAGATTAATTTGTTAAAATATACA,AATTCGAGCTCGGTACCCGGGGATCCTCTAGAGGGTTCTTAGAATTAAGTATTAGACAAAAAAGAAAATTTGATTCTTGGAAAAGATTATCAGAATTATATGAAAATCCAATTGTTATGTCACCATATTTATATAATAATTGTATAAGACAAGGTTTTGTTGCGGATTGTTCTTTTCTGTCTTCATTAACAGTATTAATAGAATATGAGAAAAAACATAAGATACCTGTTATTTCTAGTATTATAACACCTTGTAGTTGGAATTATTTATGTATAAATAAAACGTGGCCTATTTTTAATCCTTGTGGTATGTATATATGTAGACTTCATTGTAATGGTATACAAAGAAAGATAATAATAGATGATTATGTACCGGTTAAGAACAATAATTCATTGCTTGTGGCTTATTCAAATAATCAAAAAGAATTATGGGTTACCTTATTAGAAAAAGCTTTTGTTAAATTGATGGGAGGATCATATTCTATGTTTGGTTCTAATCCTGGTTCTGATTTGTATTATTTGACAGGTTGGATACCAGTAACCATATCTTTGAAATCTAAGATTAGTAGTTCTCCCCCTTCTTTTGACAAACATAGTACGCATTCTTTAATAAGGGATGAGCGTATAGATGAATGGNATATGAAACTAACGAGGTAATGATAAATAAGAAACATGGATATGTTACAGTGTTGAATTTGTAGAGGACCCAAAGTATAATCATATTATTATTATTATTATTATTTAAAATAATCGGAACTTGATCCAAATTGTGTGAAGATTAATTTGTTAAAATATACA";
	//NSString *returnValue=[[NSString alloc]init];
	//returnValue=[csvInputTextBox stringValue];
	//NSString *returnValue=@"GU134730.1,CAGTGAATTCGAGCTCGGTACCCGGGGATCCTCTAGAGGGTTCTTAGAATTAAGTATTAGACAAAAAAGAAAATTTGATTCTTGGAAAAGATTATCAGAATTATATGAAAATCCAATTGTTATGTCACCATATTTATATAATAATTGTATAAGACAAGGTTTTGTTGCGGATTGTTCTTTTCTGTCTTCATTAACAGTATTAATAGAATATGAGAAAAAACATAAGATACCTGTTATTTCTAGTATTATAACACCTTGTAGTTGGAATTATTTATGTATAAATAAAACGTGGCCTATTTTTAATCCTTGTGGTATGTATATATGTAGACTTCATTGTAATGGTATACAAAGAAAGATAATAATAGATGATTATGTACCGGTTAAGAACAATAATTCATTGCTTGTGGCTTATTCAAATAATCAAAAAGAATTATGGGTTACCTTATTAGAAAAAGCTTTTGTTAAATTGATGGGAGGATCATATTCTATGTTTGGTTCTAATCCTGGTTCTGATTTGTATTATTTGACAGGTTGGATACCAGTAACCATATCTTTGAAATCTAAGATTAGTAGTTCTCCCCCTTCTTTTGACAAACATAGTACGCATTCTTTAATAAGGGATGAGCGTATAGATGAATGGNATATGAAACTAACGAGGTAATGATAAATAAGAAACATGGATATGTTACAGTGTTGAATTTGTAGAGGACCCAAAGTATAATCATATTATTATTATTATTATTATTTAAAATAATCGGAACTTGATCCAAATTGTGTGAAGATTAATTTGTTAAAATATACA";
	NSString *returnValue;
	
	
	returnValue=[csvInputTextBox stringValue];
	NSLog(@"return value %@",returnValue);
	NSScanner *scanner=[[NSScanner alloc]init];
	scanner=[NSScanner scannerWithString:returnValue];
	NSCharacterSet *characterSet=[NSCharacterSet characterSetWithCharactersInString:@","];
	
	NSArray *array;  //=[[NSArray alloc]init];
	
	
	array=[returnValue componentsSeparatedByCharactersInSet:characterSet];
	int j=[array count];
	int i=0;
	while (i<j) {
		
	
		NSLog(@"array object %@", [array objectAtIndex:i]);		
		i++;
	}
	return array;
}	
-(IBAction)addButton:(id)sender
{	
		
		NSLog(@"CLICK");
	
}
-(NSArray *)returnNodes{
	return nodes;
}
#pragma mark -
#pragma mark Plot Data Source Methods

-(NSUInteger)numberOfRecordsForPlot:(CPPlot *)plot
{
    if ( [plot isKindOfClass:[CPBarPlot class]] ) 
        return 8;
    else
        return [nodes count];
}

-(NSNumber *)numberForPlot:(CPPlot *)plot field:(NSUInteger)fieldEnum recordIndex:(NSUInteger)index
{
    NSDecimalNumber *num;
    if ( [plot isKindOfClass:[CPBarPlot class]] ) {
        num = (NSDecimalNumber *)[NSDecimalNumber numberWithInt:(index+1)*(index+1)];
        if ( [plot.identifier isEqual:@"Bar Plot 2"] ) 
            num = [num decimalNumberBySubtracting:[NSDecimalNumber decimalNumberWithString:@"10"]];
    }
    else {
        num = [[nodes objectAtIndex:index] valueForKey:(fieldEnum == CPScatterPlotFieldX ? @"x" : @"y")];
        if ( fieldEnum == CPScatterPlotFieldY ) num = [num decimalNumberByAdding:[NSDecimalNumber one]];
    }
    return num;
}

-(CPFill *)barFillForBarPlot:(CPBarPlot *)barPlot recordIndex:(NSUInteger)index
{
	return nil;
}

-(CPTextLayer *) barLabelForBarPlot:(CPBarPlot *)barPlot recordIndex:(NSUInteger)index 
{
	if ( [(NSString *)barPlot.identifier isEqualToString:@"Bar Plot 2"] )
		return (id)[NSNull null]; // Don't show any label
	else if ( [(NSString *)barPlot.identifier isEqualToString:@"Bar Plot 1"] && index < 4 ) 
        return (id)[NSNull null];
    else
		return nil; // Use default label style
}
@end
