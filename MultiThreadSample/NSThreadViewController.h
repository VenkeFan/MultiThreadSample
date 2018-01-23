//
//  NSThreadViewController.h
//  MultiThreadSample
//
//  Created by fanqi on 17/4/26.
//  Copyright © 2017年 fanqi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSThreadViewController : UIViewController

@end

@interface KCImageData : NSObject

@property (nonatomic,assign) NSInteger index;   ///< 索引
@property (nonatomic,strong) NSData *data;      ///< 图片数据

@end
