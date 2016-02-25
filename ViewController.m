//
//  ViewController.m
//  CreatePDF
//
//  Created by mac_zhu on 2/24/16.
//  Copyright (c) 2016 mac_guang. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createPDFFile];
}

#pragma mark - PDF文件方法
- (void)createPDFFile
{
    // 1. 创建PDF上下文
    /*
     1) path 保存pdf文件的路径
     2) bounds 大小如果指定CGRectZero，则建立612 * 792大小的页面
     3) documentInfo 文档信息
     */
    NSArray *array = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [array[0] stringByAppendingPathComponent:@"123.pdf"];
    
    UIGraphicsBeginPDFContextToFile(path, CGRectZero, NULL);
    
    // 2. 创建PDF内容
    /*
     
     pdf中是分页的，要一个页面一个页面的创建
     使用 UIGraphicsBeginPDFPage 方法可以创建一个PDF的页面
     */
    for (NSInteger i = 0; i < 6; i++) {
        // 1) 创建PDF页面，每个页面的装载量是有限的
        // 在默认的页面大小里面，可以装2张图片
        // 每添加了两张图片之后，需要新建一个页面
        if (i % 2 == 0) {
            UIGraphicsBeginPDFPage();
        }
        
        // 2) 将Image添加到PDF文件
        NSString *fileName = [NSString stringWithFormat:@"NatGeo%02ld.png", i + 1];
        UIImage *image = [UIImage imageNamed:fileName];
        
        [image drawInRect:CGRectMake(0, (i % 2) * 396, 612, 396)];
    }
    
    // 3. 关闭PDF上下文
    UIGraphicsEndPDFContext();
    
    NSLog(@"Get document path: %@",NSHomeDirectory());
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
