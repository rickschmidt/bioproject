//
//  RSBlastOneWithConcurrecny.h
//  BioVizCorePlot18
//
//  Created by Rick Schmidt on 3/30/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "RSParser.h"

@interface RSBlastOneWithConcurrecny : NSInvocationOperation {
	id taskShouldLaunch;
	int k;
	NSString *blastInput;
	NSArray *seqArray;
}

@property(readwrite) id taskShouldLaunch;

-(id)initWithParameters:(int)number andString:(NSString *)str;
-(id)blast;
-(NSString *)pathForBlastOutput;
@end
