//
//  ScanClass.h
//  STS
//
//  Created by Ian Bettison on 19/12/2012.
//  Copyright (c) 2012 Ian Bettison. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>


@interface ScanClass : NSObject{

}

-(void)PlaySound:(NSString *)resourceName withFileExtension: (NSString *)extName;
+(int)FindOrientation;
@end
