//
//  ARGeoTwitterCoordinate.h
//  ARKitDemo
//
//  Created by 上田 澄博 on 09/08/05.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ARGeoCoordinate.h"

@interface ARGeoTwitterCoordinate : ARGeoCoordinate {
	NSString *imageURL;
}

@property (nonatomic,retain) NSString *imageURL;

+ (ARGeoTwitterCoordinate *)coordinateWithLocation:(CLLocation *)location withImageURL:(NSString*)imageURLString;

@end
