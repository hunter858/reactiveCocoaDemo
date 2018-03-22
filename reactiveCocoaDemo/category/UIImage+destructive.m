//
//  UIImage+destructive.m
//  reactiveCocoaDemo
//
//  Created by pengchao on 2018/3/21.
//  Copyright © 2018年 pengchao. All rights reserved.
//

#import "UIImage+destructive.h"

@implementation UIImage (destructive)
+ (nullable UIImage *)CC_imageNamed:(NSString *)name{
    UIImage *image  = [UIImage imageNamed:name];
    
    UIEdgeInsets edgeInsets = UIEdgeInsetsMake(image.size.height*0.5, image.size.width*0.5, image.size.height*0.5, image.size.width*0.5);
    
    /*
     原图大小大概是
     
     */
    UIImage *newImage = [image resizableImageWithCapInsets:edgeInsets];
    return newImage;
}


+ (nullable UIImage *)CC2_imageNamed:(NSString *)name{
     UIImage *image  = [UIImage imageNamed:name];
    return  [image stretchableImageWithLeftCapWidth:image.size.width*0.5 topCapHeight:image.size.height*0.5];
}

@end
