//
//  AppController.m
//  BioVizCorePlot18
//
//  Created by Rick Schmidt on 3/7/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "CorePlotView.h"


@implementation CorePlotView

@synthesize xShift;
@synthesize yShift;
@synthesize labelRotation;

+(void)initialize
{
    [NSValueTransformer setValueTransformer:[[CPDecimalNumberValueTransformer new] autorelease] forName:@"CPDecimalNumberValueTransformer"];
}
-(void)awakeFromNib
{
	[super awakeFromNib];
	AppController *controller;
	controller=[[AppController alloc]init];
	nodes=[controller returnNodes];
	//NSSize *size=[NSMakeSize(50.0, 100.0)];
//	[drawer setContentSize:size;
	graph = [(CPXYGraph *)[CPXYGraph alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 100.0f, 100.0f)];
	CPTheme *theme = [CPTheme themeNamed:kCPDarkGradientTheme];
	[graph applyTheme:theme];
	hostView.hostedLayer=graph;
	// Setup scatter plot space
    CPXYPlotSpace *plotSpace = (CPXYPlotSpace *)graph.defaultPlotSpace;
    plotSpace.allowsUserInteraction = YES;
    plotSpace.delegate = self;
    
    // Grid line styles
    CPLineStyle *majorGridLineStyle = [CPLineStyle lineStyle];
    majorGridLineStyle.lineWidth = 0.75;
    majorGridLineStyle.lineColor = [[CPColor colorWithGenericGray:0.2] colorWithAlphaComponent:0.75];
    
    CPLineStyle *minorGridLineStyle = [CPLineStyle lineStyle];
    minorGridLineStyle.lineWidth = 0.25;
    minorGridLineStyle.lineColor = [[CPColor whiteColor] colorWithAlphaComponent:0.1];    
    
    CPLineStyle *redLineStyle = [CPLineStyle lineStyle];
    redLineStyle.lineWidth = 10.0;
    redLineStyle.lineColor = [[CPColor redColor] colorWithAlphaComponent:0.5];
	
    // Axes
    // Label x axis with a fixed interval policy
	CPXYAxisSet *axisSet = (CPXYAxisSet *)graph.axisSet;
    CPXYAxis *x = axisSet.xAxis;
    x.majorIntervalLength = CPDecimalFromString(@"0.5");
    x.orthogonalCoordinateDecimal = CPDecimalFromString(@"2");
    x.minorTicksPerInterval = 2;
    x.majorGridLineStyle = majorGridLineStyle;
    x.minorGridLineStyle = minorGridLineStyle;
	NSArray *exclusionRanges = [NSArray arrayWithObjects:
								[CPPlotRange plotRangeWithLocation:CPDecimalFromFloat(1.99) length:CPDecimalFromFloat(0.02)], 
								[CPPlotRange plotRangeWithLocation:CPDecimalFromFloat(0.99) length:CPDecimalFromFloat(0.02)],
								[CPPlotRange plotRangeWithLocation:CPDecimalFromFloat(2.99) length:CPDecimalFromFloat(0.02)],
								nil];
	x.labelExclusionRanges = exclusionRanges;
	
	x.title = @"X Axis";
	x.titleOffset = 30.0;
	x.titleLocation = CPDecimalFromString(@"3.0");
	
	// Label y with an automatic label policy. 
    CPXYAxis *y = axisSet.yAxis;
    y.labelingPolicy = CPAxisLabelingPolicyAutomatic;
    y.orthogonalCoordinateDecimal = CPDecimalFromString(@"2");
    y.minorTicksPerInterval = 2;
    y.preferredNumberOfMajorTicks = 8;
    y.majorGridLineStyle = majorGridLineStyle;
    y.minorGridLineStyle = minorGridLineStyle;
    y.labelOffset = 10.0;
	exclusionRanges = [NSArray arrayWithObjects:
					   [CPPlotRange plotRangeWithLocation:CPDecimalFromFloat(1.99) length:CPDecimalFromFloat(0.02)], 
					   [CPPlotRange plotRangeWithLocation:CPDecimalFromFloat(0.99) length:CPDecimalFromFloat(0.02)],
					   [CPPlotRange plotRangeWithLocation:CPDecimalFromFloat(3.99) length:CPDecimalFromFloat(0.02)],
					   nil];
	y.labelExclusionRanges = exclusionRanges;
    
	y.title = @"Y Axis";
	y.titleOffset = 30.0;
	y.titleLocation = CPDecimalFromString(@"2.7");
	
	//CPScatterPlot *dataSourceLinePlot = [[[CPScatterPlot alloc] init] autorelease];
//    dataSourceLinePlot.identifier = @"Data Source Plot";
//	dataSourceLinePlot.dataLineStyle.lineWidth = 3.0;
//    dataSourceLinePlot.dataLineStyle.lineColor = [CPColor greenColor];
//    dataSourceLinePlot.dataSource = self;
//    [graph addPlot:dataSourceLinePlot];
	
	CPXYPlotSpace *barPlotSpace = [[CPXYPlotSpace alloc] init];
    barPlotSpace.xRange = [CPPlotRange plotRangeWithLocation:CPDecimalFromFloat(0.0f) length:CPDecimalFromFloat(1000.0f)];
    barPlotSpace.yRange = [CPPlotRange plotRangeWithLocation:CPDecimalFromFloat(0.0f) length:CPDecimalFromFloat(15.0f)];
	[graph addPlotSpace:barPlotSpace];
    [barPlotSpace release];
	//
//	// First bar plot
    CPBarPlot *barPlot = [CPBarPlot tubularBarPlotWithColor:[CPColor darkGrayColor] horizontalBars:NO];
    barPlot.baseValue = CPDecimalFromString(@"20");
    barPlot.dataSource = self;
    barPlot.barOffset = -0.25f;
    barPlot.identifier = @"Bar Plot 1";
	barPlot.plotRange = [CPPlotRange plotRangeWithLocation:CPDecimalFromDouble(0.0) length:CPDecimalFromDouble(7.0)];
    CPTextStyle *whiteTextStyle = [CPTextStyle textStyle];
    whiteTextStyle.color = [CPColor whiteColor];
    barPlot.barLabelTextStyle = whiteTextStyle;
    [graph addPlot:barPlot toPlotSpace:barPlotSpace];

	// Create one plot that uses bindings
//	CPScatterPlot *boundLinePlot = [[[CPScatterPlot alloc] init] autorelease];
//    boundLinePlot.identifier = @"Bindings Plot";
//	boundLinePlot.dataLineStyle.miterLimit = 1.0;
//	boundLinePlot.dataLineStyle.lineWidth = 3.0;
//	boundLinePlot.dataLineStyle.lineColor = [CPColor blueColor];
//[graph addPlot:boundLinePlot];
//	[boundLinePlot bind:CPScatterPlotBindingXValues toObject:self withKeyPath:@"arrangedObjects.x" options:nil];
//	[boundLinePlot bind:CPScatterPlotBindingYValues toObject:self withKeyPath:@"arrangedObjects.y" options:nil];

	// Create a second plot that uses the data source method
//	CPScatterPlot *dataSourceLinePlot = [[[CPScatterPlot alloc] init] autorelease];
//    dataSourceLinePlot.identifier = @"Data Source Plot";
//	dataSourceLinePlot.dataLineStyle.lineWidth = 3.0;
//    dataSourceLinePlot.dataLineStyle.lineColor = [CPColor greenColor];
//    dataSourceLinePlot.dataSource = self;
//    [graph addPlot:dataSourceLinePlot];
}
#pragma mark -
#pragma mark Plot Data Source Methods

-(NSUInteger)numberOfRecordsForPlot:(CPPlot *)plot
{
    if ( [plot isKindOfClass:[CPBarPlot class]] ) 
        return [nodes count];
}

-(NSNumber *)numberForPlot:(CPPlot *)plot field:(NSUInteger)fieldEnum recordIndex:(NSUInteger)index
{
    NSDecimalNumber *num;
    if ( [plot isKindOfClass:[CPBarPlot class]] ) {
        num = (NSDecimalNumber *)[NSDecimalNumber numberWithInt:(index+1)*(index+1)];
        if ( [plot.identifier isEqual:@"Bar Plot 1"] ) 
            num = [num decimalNumberBySubtracting:[NSDecimalNumber decimalNumberWithString:@"10"]];
    }
    else {
        //num = [[nodes objectAtIndex:index] valueForKey:(fieldEnum == CPScatterPlotFieldX ? @".//Hit_id" : @"y")];
        //if ( fieldEnum == CPScatterPlotFieldY ) num = [num decimalNumberByAdding:[NSDecimalNumber one]];
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


//-(IBAction)plot:(id)sender{
@end
