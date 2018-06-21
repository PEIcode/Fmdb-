//
//  Student.h
//  Fmdb存储数组
//
//  Created by sunny&pei on 2018/3/15.
//  Copyright © 2018年 sunny&pei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Tool_FMDBModel.h"
@interface Student : Tool_FMDBModel
@property(nonatomic,copy)NSString *name;
@property(nonatomic,assign)int age;
@property(nonatomic,strong)NSMutableArray *imagesArray;
@end
