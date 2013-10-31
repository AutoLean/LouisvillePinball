//
//  Comment.h
//  LouisvillePinball
//
//  Created by Jeffrey Jackson on 6/27/11.
//  Copyright 2011 AutoLean, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Comment : NSObject {
    NSString *commentName;
    NSString *commentText;
    NSString *commentDate;
}

@property (nonatomic,copy) NSString *commentName;
@property (nonatomic,copy) NSString *commentText;
@property (nonatomic,copy) NSString *commentDate;

@end
