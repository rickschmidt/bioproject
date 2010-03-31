//
//  RSBlastMany.m
//  BioVizCorePlot18
//
//  Created by Rick Schmidt on 3/30/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "RSBlastMany.h"


@implementation RSBlastMany





-(void)blastMany:(NSArray *)seqArray
{
	
	int j=[seqArray count];
	aQueue=[NSOperationQueue new];
	NSMutableArray *arrayOfOperations=[[NSMutableArray alloc]init];
	//sel.isRunning=NO;
	
	for(int i=0; i<j;i++){
		NSArray *array1=[seqArray valueForKey:@"inputText"];
		NSString *str=[array1 objectAtIndex:i];
		NSLog(@"BLAST//blastMany/object at index i %@",str);
		
		
		RSBlastOneWithConcurrecny *toBlast;
		toBlast=[[RSBlastOneWithConcurrecny alloc]init];
		[self initWithTarget:toBlast selector:(SEL)blast object:nil];
	
		//if (![toBlast isReady] &&![toBlast isCancelled] ) {
			//if ([toBlast isConcurrent]) {
				//[[toBlast initWithParameters:i andString:str]start];
				
			//}
			
		//}
		//[arrayOfOperations addObject:[toBlast initWithParameters:i andString:str]];
		NSLog(@"After adding to arrayOfoperations");
		
	}
		// [aQueue addOperations:arrayOfOperations waitUntilFinished:YES];
//			RSBlastOneWithConcurrecny *toBlast;
//		toBlast=[[RSBlastOneWithConcurrecny alloc]init];
//		NSArray *operationsArray=[[NSArray alloc]init];
//		operationsArray=[aQueue operations];
//	NSOperationQueue *secondQueue;
//	secondQueue=[NSOperationQueue new];
//	for(int i=0;i<j;i++){
//		[secondQueue addOperation:[operationsArray objectAtIndex:j]];
//		
//	}
	
}
@end
