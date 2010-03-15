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
@synthesize inputText;

-(id)init
{
	self=[super init];
	
	NSLog(@"HEREHERE %@ //AppController/init",[[mainApplicationWindow contentView]subviews]);
	RSParser *xmlStuff;
	xmlStuff=[[RSParser alloc]init];
	[xmlStuff initXML];
	nodes=[xmlStuff getArrayForNode:@".//Hit_id"];
	inputArray=[[NSMutableArray alloc]init];
	specificNodes=[xmlStuff getSpecificNode];
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
	//[xmlStuff initXML];
//	nodes=[xmlStuff getArrayForNode:@".//Hit_id"];
//	NSLog(@"input array %@",[inputArray objectAtIndex:0]);
//	NSLog(@"input array22 %@",[inputArray objectAtIndex:1]);
//	NSString *string1=[[inputArray objectAtIndex:0] description];
//	NSString *string2=[[inputArray objectAtIndex:1]description];
//	NSLog(@"string1 %d", string1);
//	NSLog(@"string2 %@", string2);
//	NSLog(@"inputArray %@",inputArray);
	[xmlStuff getSpecificNode];
	

	
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
		
	
		//NSLog(@"array object %@", [array objectAtIndex:i]);		
		i++;
	}
	return array;
}	
-(IBAction)addButton:(id)sender
{	
		
		NSLog(@"CLICK //AppController/addButton");
	
}
-(NSArray *)returnNodes{
	return nodes;
}


#pragma mark -
#pragma mark Arrays from XML 
//-(NSArray *)


#pragma mark -
#pragma mark Plot Data Source Methods

-(NSUInteger)numberOfRecordsForPlot:(CPPlot *)plot
{
	int num;
	if ( [plot isKindOfClass:[CPBarPlot class]] ) {
//		num=[nodes count]/50;
		num=[specificNodes count];
	
		return num;
    }
	
		else
        return [nodes count];
}

-(NSNumber *)numberForPlot:(CPPlot *)plot field:(NSUInteger)fieldEnum recordIndex:(NSUInteger)index
{
    NSDecimalNumber *num;
    if ( [plot isKindOfClass:[CPBarPlot class]] ) {
        
		NSArray *theValues;
		theValues=[specificNodes allValues];
//		int i=0;//=[theValues count];
		//for(int x=0;x<i;x++){
			
		NSLog(@"keys objectat index x %@ //AppController numberForPlot",[theValues objectAtIndex:index]);
		num = (NSDecimalNumber *)[NSDecimalNumber numberWithInt:[[theValues objectAtIndex:index]intValue]];
//		num=(NSDecimalNumber *)[CPDecimalFromUnsignedInteger:];
//		NSDecimalNumber *num=[[NSNumber numberWithUnsignedInt:index]decimalValue];
        if ( [plot.identifier isEqual:@"Bar Plot 1"] ) 
								  num; //= [num decimalNumberBySubtracting:[NSDecimalNumber decimalNumberWithString:@"10"]];
	
								  
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

-(IBAction)addNewInputFile:(id)sender
{
	[inputArrayMenu addObject:[inputTextField stringValue]];
}

- (IBAction) displayInputView:(id)sender
{
	if (![[[mainApplicationWindow contentView] subviews] containsObject:inputMenuView])
	{
		[mainApplicationWindow setContentView:inputMenuView];
		//oldWindowFrame = [mainApplicationWindow frame];
//		
//		
//		
//		NSRect currentSize = [[mainApplicationWindow contentView] frame];
//		[inputMenuView setFrame:currentSize];
		//NSView *currentView = [mainApplicationWindow contentView];// subviews] object:CPLayerHostingView];
		//[mainApplicationWindow setFrame:oldWindowFrame display:YES animate:YES];
		//transition=[CATransition animation];
		//CATransition *transition;
		//[transition setType:kCATransitionMoveIn];
		//currentAnimation=[NSDictionary dictionaryWithObject:transition forKey:@"newView"];
		//[currentView setAnimation:currentAnimation];
		//[[mainApplicationWindow contentView] replaceSubview:[mainApplicationWindow contentView] with: inputMenuView];
		
	}
	
	
}
-(IBAction)displayCorePlot:(id)sender
{
	[graphWindow display];

}
@end
