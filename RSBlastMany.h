//
//  RSBlastMany.h
//  BioVizCorePlot18
//
//  Created by Rick Schmidt on 3/30/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "RSBlastOneWithConcurrecny.h"

@interface RSBlastMany : NSObject{
	
	NSOperationQueue *aQueue;

}

-(void)blastMany:(NSArray *)seqArray;

@end
