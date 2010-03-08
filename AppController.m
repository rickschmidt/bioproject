//
//  AppController.m
//  BioVizCorePlot18
//
//  Created by Rick Schmidt on 3/8/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "AppController.h"


@implementation AppController

-(IBAction)blastWithBlastcl3:(id)sender{
	Blast *blastControl;
	blastControl=[[Blast alloc]init];
	NSInteger i=5;
	[blastControl blast:i];
}
-(IBAction)xmlStuff:(id)sender
{
	XMLParser *xmlStuff;
	xmlStuff=[[XMLParser alloc]init];
	[xmlStuff initXML];
}
@end
