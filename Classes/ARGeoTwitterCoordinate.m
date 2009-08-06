//
//  ARGeoTwitterCoordinate.m
//  ARKitDemo
//
//  Created by 上田 澄博 on 09/08/05.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "ARGeoTwitterCoordinate.h"


@implementation ARGeoTwitterCoordinate

@synthesize imageURL;

+ (ARGeoTwitterCoordinate *)coordinateWithLocation:(CLLocation *)location withImageURL:(NSString*)imageURLString {
	ARGeoTwitterCoordinate *newCoordinate = [[ARGeoTwitterCoordinate alloc] init];
	newCoordinate.geoLocation = location;
	newCoordinate.imageURL = imageURLString;
	
	NSLog(@"Geolocation: %@",location);
	
	newCoordinate.title = @"GEOTWITTER";
	
	return [newCoordinate autorelease];
	
}

@end
