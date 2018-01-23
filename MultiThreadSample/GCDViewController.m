//
//  GCDViewController.m
//  MultiThreadSample
//
//  Created by fanqi on 17/4/26.
//  Copyright © 2017年 fanqi. All rights reserved.
//

#import "GCDViewController.h"

#define ROW_COUNT 5
#define COLUMN_COUNT 3
#define ROW_HEIGHT 100
#define ROW_WIDTH ROW_HEIGHT
#define CELL_SPACING 10

@interface GCDViewController () {
    NSMutableArray *_imageViews;
    NSMutableArray *_imageNames;
}

@end

@implementation GCDViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"GCD";
    
    [self layoutUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark 界面布局
-(void)layoutUI{
    //创建多个图片控件用于显示图片
    _imageViews=[NSMutableArray array];
    for (int r=0; r<ROW_COUNT; r++) {
        for (int c=0; c<COLUMN_COUNT; c++) {
            UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(c*ROW_WIDTH+(c*CELL_SPACING), r*ROW_HEIGHT+(r*CELL_SPACING) + 64, ROW_WIDTH, ROW_HEIGHT)];
            imageView.contentMode=UIViewContentModeScaleAspectFit;
            [self.view addSubview:imageView];
            [_imageViews addObject:imageView];
            
        }
    }
    
    UIButton *button=[UIButton buttonWithType:UIButtonTypeSystem];
    button.frame=CGRectMake(0, 0, 220, 25);
    button.center = CGPointMake(self.view.bounds.size.width * 0.5, self.view.bounds.size.height - 50);
    [button setTitle:@"加载图片" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(loadImageWithMultiThread) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    //创建图片链接
    _imageNames=[NSMutableArray array];
    for (int i=0; i<ROW_COUNT*COLUMN_COUNT; i++) {
        [_imageNames addObject:[NSString stringWithFormat:@"http://images.cnblogs.com/cnblogs_com/kenshincui/613474/o_%i.jpg",i]];
    }
}

#pragma mark 将图片显示到界面
-(void)updateImageWithData:(NSData *)data andIndex:(NSInteger)index{
    UIImage *image=[UIImage imageWithData:data];
    UIImageView *imageView= _imageViews[index];
    imageView.image=image;
}

#pragma mark 请求图片数据
-(NSData *)requestData:(NSInteger)index{
    NSURL *url=[NSURL URLWithString:_imageNames[index]];
    NSData *data=[NSData dataWithContentsOfURL:url];
    
    return data;
}

#pragma mark 加载图片
-(void)loadImage:(NSNumber *)index{
    
    //如果在串行队列中会发现当前线程打印变化完全一样，因为他们在一个线程中
    NSLog(@"thread is :%@",[NSThread currentThread]);
    
    NSInteger i=[index integerValue];
    //请求数据
    NSData *data= [self requestData:i];
    //更新UI界面,此处调用了GCD主线程队列的方法
    dispatch_queue_t mainQueue= dispatch_get_main_queue();
    dispatch_sync(mainQueue, ^{
        [self updateImageWithData:data andIndex:i];
    });
}

#pragma mark 多线程下载图片
-(void)loadImageWithMultiThread{
    
    /*
        在GCD中：
        a. 如果是用异步方法执行
            1. 如果队列类型为并行队列，则在多个线程中执行
            2. 如果队列类型为串行队列，则是在一个单一线程（非主线程）中执行
        b. 如果是用同步方法执行，则不管是串行还是并行队列，都会在主线程中执行，会造成UI阻塞
     */
    
    
    int count=ROW_COUNT*COLUMN_COUNT;
    
//    /*创建一个串行队列
//     第一个参数：队列名称
//     第二个参数：队列类型
//     */
//    dispatch_queue_t serialQueue = dispatch_queue_create("mySerialThreadQueue1", DISPATCH_QUEUE_SERIAL);
//    //创建多个线程用于填充图片
//    for (int i=0; i<count; ++i) {
//        //异步执行队列任务
//        dispatch_async(serialQueue, ^{
//            [self loadImage:[NSNumber numberWithInt:i]];
//        });
//    }
//    //非ARC环境请释放
//    //    dispatch_release(seriQueue);
    
    
    
    
    
    // 创建一个并发队列
//    dispatch_queue_t concurrentQueue = dispatch_queue_create("myConcurrentThreadQueue1", DISPATCH_QUEUE_CONCURRENT);

    /*取得全局队列
     第一个参数：线程优先级
     第二个参数：标记参数，目前没有用，一般传入0
     */
    dispatch_queue_t globalQueue=dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);

    //创建多个线程用于填充图片
    for (int i=0; i<count; ++i) {
        //异步执行队列任务
        dispatch_async(globalQueue, ^{
            [self loadImage:[NSNumber numberWithInt:i]];
        });
    }
    
//    // 这样就会只创建1个线程，效果就和上面的串行队列一样
//    dispatch_async(globalQueue, ^{
//        for (int i = 0; i < count; i++) {
//            [self loadImage:[NSNumber numberWithInt:i]];
//        }
//    });
}

@end
