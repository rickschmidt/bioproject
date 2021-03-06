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
@synthesize inputArray;
@synthesize inputString;
@synthesize inputText;
//@synthesize inputArrayHasMoreThanOne;

@synthesize xShift;
@synthesize yShift;
@synthesize labelRotation;
@synthesize arrayController;


+(void)initialize
{
    [NSValueTransformer setValueTransformer:[[CPDecimalNumberValueTransformer new] autorelease] forName:@"CPDecimalNumberValueTransformer"];
}

-(id)init
{
	self=[super init];
	inputFrame=NSMakeRect(200.0f, 500.0f, 450.0f, 450.0f);
	graphFrame=NSMakeRect(200.0f, 500.0f, 900.0f, 900.0f);
	NSLog(@"HEREHERE %@ //AppController/init",[[mainApplicationWindow contentView]subviews]);
	RSParser *xmlStuff;
	xmlStuff=[[RSParser alloc]init];
	[xmlStuff initXML];

	nodes=[xmlStuff getArrayForNode:@".//Hit_def"];
	inputArray=[[NSMutableArray alloc]init];
	specificNodes=[xmlStuff getSpecificNode];
		//NSLog(@"node object at index 2 %@",[nodes objectAtIndex:2]);
	
	
	//NSArray *test=[[NSArray alloc]init];
	NSArray *test=[xmlStuff initWithDirectoryOfXML];
	theDictionary=[xmlStuff getSpecificNodeForMany:test];
	NSArray *keys=[theDictionary allKeys];
	NSArray *values=[theDictionary allValues];
	for (NSUInteger i=0;i<[theDictionary count];i++){
		NSLog(@"//appcontroller/awake/ the %@ and the %@ ",[values objectAtIndex:i], [keys objectAtIndex:i]);
	}
	//[xmlStuff release];
	//[theDictionary release];
	
	
	//NSArray *test2=[xmlStuff initWithDirectoryOfXMLPaths];
//	NSMutableDictionary *theDict2;
//	theDict2=[xmlStuff getSpecificNodeForManyWithParser:test2];
//	
	return self;
	
}
-(void)dealloc
{
	[graph release];
	[super release];
}
-(void)awakeFromNib
{
	
	//[self goGraph];
	
}
-(void)goGraph
{
//	[super awakeFromNib];
	NSLog(@"HEREHERE %@ //CorePlotViewer/awakeFromNib",[[mainApplicationWindow contentView]subviews]);
	//Initialize controller object for this programmed view
//	AppController *controller;
//	controller=[[AppController alloc]init];
	nodes=[self returnNodes];
	NSRect bounds=[[mainApplicationWindow contentView] bounds];
	
	// Create graph and apply a dark theme
	graph = [(CPXYGraph *)[CPXYGraph alloc] initWithFrame:bounds xScaleType:1 yScaleType:1];//initWithFrame:NSRectToCGRect(hostView.bounds)]; 	//NSLog(@"height %d",hostView.bounds.size.height);
	CPTheme *theme = [CPTheme themeNamed:kCPDarkGradientTheme];
	[graph applyTheme:theme];
	hostView.hostedLayer=graph;
	
	// Graph padding
    graph.paddingLeft = 1.0;
    graph.paddingTop = 1.0;
    graph.paddingRight = 1.0;
    graph.paddingBottom = 1.0;
	
	// Setup scatter plot space
    plotSpace = (CPXYPlotSpace *)graph.defaultPlotSpace;
	plotSpace.xRange=[CPPlotRange plotRangeWithLocation:CPDecimalFromFloat(-1.0) length:CPDecimalFromFloat(100.0)];
	plotSpace.yRange=[CPPlotRange plotRangeWithLocation:CPDecimalFromFloat(-1.0) length:CPDecimalFromFloat(5.0)];
	plotSpace.allowsUserInteraction = YES;
    plotSpace.delegate = self;
    
    // Grid line styles
	CPLineStyle *axisLineStyle = [CPLineStyle lineStyle];
    axisLineStyle.lineWidth = 10.0;
	axisLineStyle.lineColor=[CPColor blackColor];
	
    CPLineStyle *majorGridLineStyle = [CPLineStyle lineStyle];
    majorGridLineStyle.lineWidth = 3.0f;
    majorGridLineStyle.lineColor = [[CPColor grayColor] colorWithAlphaComponent:0.9 ];
    
    CPLineStyle *minorGridLineStyle = [CPLineStyle lineStyle];
    minorGridLineStyle.lineWidth = 0.5f;
    minorGridLineStyle.lineColor = [[CPColor whiteColor] colorWithAlphaComponent:0.7];    
    
    CPLineStyle *redLineStyle = [CPLineStyle lineStyle];
    redLineStyle.lineWidth = 10.0;
    redLineStyle.lineColor = [[CPColor redColor] colorWithAlphaComponent:0.5];
	
	
	
    // Axes
    // Label x axis with a fixed interval policy
	CPXYAxisSet *axisSet = (CPXYAxisSet *)graph.axisSet;
    CPXYAxis *x = axisSet.xAxis;
	x.labelingPolicy = CPAxisLabelingPolicyAutomatic;
    x.majorIntervalLength = CPDecimalFromString(@"0.5");
    x.minorTicksPerInterval = 0;
	x.tickDirection = CPSignNone;
	x.axisLineStyle = axisLineStyle;
	x.majorTickLength = 10.0;
	x.majorTickLineStyle = axisLineStyle;
    x.majorGridLineStyle = majorGridLineStyle;
	x.minorTickLength = 6.0;
    x.minorGridLineStyle = minorGridLineStyle;
	x.title = @"X Axis";
//	x.titleTextStyle = axisTitleTextStyle;
	x.titleOffset = 25.0f;
	x.labelingPolicy=CPAxisLabelingPolicyAutomatic;
	
	
	// Label y with an automatic label policy. 
    CPXYAxis *y = axisSet.yAxis;
    y.labelingPolicy = CPAxisLabelingPolicyAutomatic;
    y.orthogonalCoordinateDecimal = CPDecimalFromString(@"2");
    y.minorTicksPerInterval = 0;
    y.preferredNumberOfMajorTicks = 5;
    y.majorGridLineStyle = majorGridLineStyle;
    y.minorGridLineStyle = minorGridLineStyle;
    y.labelOffset = 10.0;
	//exclusionRanges = [NSArray arrayWithObjects:
	//					   [CPPlotRange plotRangeWithLocation:CPDecimalFromFloat(1.99) length:CPDecimalFromFloat(0.02)], 
	//					   [CPPlotRange plotRangeWithLocation:CPDecimalFromFloat(0.99) length:CPDecimalFromFloat(0.02)],
	//					   [CPPlotRange plotRangeWithLocation:CPDecimalFromFloat(3.99) length:CPDecimalFromFloat(0.02)],
	//					   nil];
	//	y.labelExclusionRanges = exclusionRanges;
    
	y.title = @"Y Axis";
	y.titleOffset = 1.0;
	y.titleLocation = CPDecimalFromString(@"1");
	
	
	
	// Set axes
	graph.axisSet.axes = [NSArray arrayWithObjects:x, y,nil];
	
	CPXYPlotSpace *barPlotSpace = [[CPXYPlotSpace alloc] init];
    barPlotSpace.xRange = [CPPlotRange plotRangeWithLocation:CPDecimalFromFloat(0.0f) length:CPDecimalFromFloat(100.0f)];
    barPlotSpace.yRange = [CPPlotRange plotRangeWithLocation:CPDecimalFromFloat(0.0f) length:CPDecimalFromFloat(5.0f)];
	[graph addPlotSpace:barPlotSpace];
    [barPlotSpace release];
	//
	//	// First bar plot
    CPBarPlot *barPlot = [CPBarPlot tubularBarPlotWithColor:[CPColor darkGrayColor] horizontalBars:NO];
    barPlot.baseValue = CPDecimalFromString(@"0");
    barPlot.dataSource = self;
	barPlot.barWidth=10.0f;
//    barPlot.barOffset = 1.0f;
    barPlot.identifier = @"Bar Plot 1";
	barPlot.plotRange = plotSpace.xRange;// [CPPlotRange plotRangeWithLocation:CPDecimalFromDouble(0.0) length:CPDecimalFromDouble(100.0f)];
    CPTextStyle *whiteTextStyle = [CPTextStyle textStyle];
    whiteTextStyle.color = [CPColor whiteColor];
    barPlot.barLabelTextStyle = whiteTextStyle;
    [graph addPlot:barPlot toPlotSpace:plotSpace]; //changed to plotSpace set above from barPlotSpace set around here this makes the bars drag with the grid lines
	
}


-(IBAction)blastWithBlastcl3:(id)sender{
	Blast *blastControl;
	blastControl=[[Blast alloc]init];
	NSInteger i=5;
	NSArray *inputSeqs;
	inputSeqs=[self csvSplit];
	//[blastControl blast:i];
	[blastControl blastMany:inputArray];
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
		num=[theDictionary count];
	
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
		theValues=[theDictionary allValues];
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
	else if ( [(NSString *)barPlot.identifier isEqualToString:@"Bar Plot 2"]  ) 
        return (id)[NSNull null];
    else
		return nil; // Use default label style
}

-(IBAction)addNewInputFile:(id)sender
{
	[inputArrayMenu addObject:[inputTextField stringValue]];
}

#pragma mark -
#pragma mark View Swapping
- (IBAction) displayInputView:(id)sender
{
	if (![[[mainApplicationWindow contentView] subviews] containsObject:inputMenuView])
	{
		
		[graph release];
		//[mainApplicationWindow setContentView:inputMenuView];
		oldWindowFrame = [mainApplicationWindow frame];
//		
//		
		
		NSRect currentSize = [[mainApplicationWindow contentView] frame];
		[inputMenuView setFrame:currentSize];
		NSView *currentView = [[[mainApplicationWindow contentView] subviews] objectAtIndex:0];
		[mainApplicationWindow setFrame:oldWindowFrame display:YES animate:YES];
		//CATransition *transition;
		//transition=[CATransition animation];
		//[transition setType:kCATransitionMoveIn];
		//currentAnimation=[NSDictionary dictionaryWithObject:transition forKey:@"newView"];
		//[currentView setAnimation:currentAnimation];
		[[[mainApplicationWindow contentView] animator ]replaceSubview:currentView with:inputMenuView];
		//[[mainApplicationWindow contentView] replaceSubview:[mainApplicationWindow contentView] with: inputMenuView];
		[mainApplicationWindow setFrame:inputFrame display:YES animate:YES];
		
	}
	
	
}
-(IBAction)displayCorePlot:(id)sender
{
	//if ([graphWindow isVisible]) {
	//	[graphWindow hid];
	//}
	
	if (![[[mainApplicationWindow contentView] subviews] containsObject:hostView])
	{
		
		//[mainApplicationWindow setContentView:hostView];
		oldWindowFrame = [mainApplicationWindow frame];
		//		
		//		
		//		
		NSRect currentSize = [[mainApplicationWindow contentView] frame];
		[hostView setFrame:currentSize];
		NSView *currentView = [[[mainApplicationWindow contentView] subviews] objectAtIndex:0];
		[mainApplicationWindow setFrame:oldWindowFrame display:YES animate:YES];
		//CATransition *transition;
		//transition=[CATransition animation];
		
		[transition setType:kCATransitionMoveIn];
		//currentAnimation=[NSDictionary dictionaryWithObject:transition forKey:@"newView"];
		//[currentView setAnimation:currentAnimation];
		[[[mainApplicationWindow contentView]  animator]replaceSubview:currentView with:hostView];
		//[[mainApplicationWindow contentView] replaceSubview:[mainApplicationWindow contentView] with: hostView];
		[mainApplicationWindow setFrame:graphFrame display:YES animate:YES];
		[self goGraph];
		
	}
	

}
-(IBAction)logInputArrayContenets:(id)sender
{
	NSLog(@"//AppController/logInputArrayConteents %@",inputArrayMenu);
	NSLog(@"//AppController/logInputArrayConteents %@",[inputArrayMenu objectAtIndex:0 ]);

}


#pragma mark -
#pragma mark PDF / image export

-(IBAction)exportToPDF:(id)sender
{
	NSSavePanel *pdfSavingDialog = [NSSavePanel savePanel];
	[pdfSavingDialog setRequiredFileType:@"pdf"];
	
	if ( [pdfSavingDialog runModalForDirectory:nil file:nil] == NSOKButton )
	{
		NSData *dataForPDF = [graph dataForPDFRepresentationOfLayer];
		[dataForPDF writeToFile:[pdfSavingDialog filename] atomically:NO];
	}		
}

-(IBAction)exportToPNG:(id)sender
{
	NSSavePanel *pngSavingDialog = [NSSavePanel savePanel];
	[pngSavingDialog setRequiredFileType:@"png"];
	
	if ( [pngSavingDialog runModalForDirectory:nil file:nil] == NSOKButton ) {
		NSImage *image = [graph imageOfLayer];
        NSData *tiffData = [image TIFFRepresentation];
        NSBitmapImageRep *tiffRep = [NSBitmapImageRep imageRepWithData:tiffData];
        NSData *pngData = [tiffRep representationUsingType:NSPNGFileType properties:nil];
		[pngData writeToFile:[pngSavingDialog filename] atomically:NO];
	}		
}

#pragma mark -
#pragma mark Snap Plot Range
-(IBAction)snapBackToCenterPlotRange:(id)sender
{
	plotSpace.xRange=[CPPlotRange plotRangeWithLocation:CPDecimalFromFloat(-10.0) length:CPDecimalFromFloat(100.0)];
	plotSpace.yRange=[CPPlotRange plotRangeWithLocation:CPDecimalFromFloat(-1.0) length:CPDecimalFromFloat(5.0)];
}


-(IBAction)openPanel:(id)sender
{
	NSOpenPanel *openPanel=[NSOpenPanel openPanel];
	[openPanel runModalForDirectory:nil file:nil types:nil];
	NSArray *openArray=[openPanel URLs];
	arrayController=[[NSArrayController alloc]init];
	 if([openArray count]>0){
		 for (NSURL *urlPath in openArray){
			NSString *urlPath1= [[urlPath absoluteString] substringFromIndex:16];
			 NSMutableArray *array=[inputArray mutableArrayValueForKey:@"inputText"];
			 [array addObject:urlPath1];
			 //[arrayController.arrangedObjects addObject:urlPath1 ];
			 NSLog(@"absolutestring %@",urlPath1);
			 for(NSString *url in inputArray){
				 
				 NSLog(@"input ARRAY OJBECT %@",url);
			 }
		 }
	 }
	
}
@end
