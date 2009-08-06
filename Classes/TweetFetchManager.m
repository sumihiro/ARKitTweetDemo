//
//  TweetFetchManager.m
//  ARKitDemo
//
//  Created by 上田 澄博 on 09/08/06.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "TweetFetchManager.h"
#import "NSString+SBJSON.h"
#import "GTMNSString+URLArguments.h"
#import "TweetFetchDefines.h"

@implementation TweetFetchManager

+(NSArray*)fetchFriends {
	id tl = [[NSString stringWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://%@:%@@twitter.com/statuses/friends_timeline.json",[kTwitterUserID gtm_stringByEscapingForURLArgument],[kTwitterPassword gtm_stringByEscapingForURLArgument]]]] JSONValue];
	NSLog(@"%@ %@",tl,[tl class]);
	
	if(!tl) {
		return nil;
	}
	if([NSStringFromClass([tl class]) isEqualToString:@"NSCFDictionary"]) {
		// error;
		return nil;
	}
	
	NSMutableArray *retArray = [NSMutableArray arrayWithObjects:nil];
	
	for(NSDictionary *t in (NSArray*)tl) {
		NSDictionary *user = [t objectForKey:@"user"];
		if(!user) {
			continue;
		}
		NSString *location = [user objectForKey:@"location"];
		if(!location) {
			continue;
		}
		if([location isEqualToString:@""]) {
			continue;
		}
		
		NSDictionary *geo = [[NSString stringWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://maps.google.com/maps/geo?q=%@&output=json&oe=utf8&sensor=false&key=%@",[location gtm_stringByEscapingForURLArgument],[kGoogleMapsAPIKey gtm_stringByEscapingForURLArgument]]]] JSONValue];
		NSLog(@"geo: %@",geo);
		if(!geo) {
			continue;
		}
		
		NSArray *placemark = [geo objectForKey:@"Placemark"];
		if(!placemark) {
			continue;
		}
		NSDictionary *place = [placemark objectAtIndex:0];
		if(!place) {
			continue;
		}
		NSDictionary *point = [place objectForKey:@"Point"];
		if(!point) {
			continue;
		}
		NSArray *coordinates = [point objectForKey:@"coordinates"];
		if(!coordinates || [coordinates count] < 2) {
			continue;
		}
		float lat = [[coordinates objectAtIndex:1] floatValue];
		float lng = [[coordinates objectAtIndex:0] floatValue];
		
		NSDictionary *aTweet = [NSDictionary dictionaryWithObjectsAndKeys:[user objectForKey:@"name"], @"title",[user objectForKey:@"profile_image_url"],@"img",[NSNumber numberWithFloat:lat],@"lat",[NSNumber numberWithFloat:lng],@"lng",nil];
		[retArray addObject:aTweet];
	}
	return retArray;
}

@end
