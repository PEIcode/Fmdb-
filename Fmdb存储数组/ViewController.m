//
//  ViewController.m
//  Fmdb存储数组
//
//  Created by sunny&pei on 2018/3/15.
//  Copyright © 2018年 sunny&pei. All rights reserved.
//

#import "ViewController.h"
#import "FMDB.h"
#import "Student.h"
#import "Tool_FMDBModel.h"
@interface ViewController ()
- (IBAction)saveBtn:(UIButton *)sender;
/**
 存放图片的二进制数组
 */
@property(nonatomic,strong)NSMutableArray *imageDataArr;
@property(nonatomic,strong)FMDatabase *db;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _imageDataArr = [NSMutableArray array];
    for (int i = 0; i<4; i++) {
        UIImage *image = [UIImage imageNamed:@"1"];
//        NSData *imageData = UIImageJPEGRepresentation(image, 1);
        [_imageDataArr addObject:image];
    }
    
    Student *stu1 = [[Student alloc]init];
    stu1.name = @"zhangsan";
    stu1.age = 10;
    stu1.imagesArray = _imageDataArr;
    [stu1 save];
    NSArray *he = [Student findAll];
    for (int i = 0; i<he.count; i++) {
        Student *s = he[i];
        NSLog(@"%@",s.name);
        NSLog(@"%@",s.imagesArray);
    }
//
//    Student *stu2 = [[Student alloc]init];
//    stu2.name = @"lisi";
//    stu2.age = 20;
//    stu2.imagesArray = _imageDataArr;
    
    
    
}
- (IBAction)saveBtn:(UIButton *)sender {
    //1.获取数据库文件的路径
    NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject];
    NSString *filename = [doc stringByAppendingPathComponent:@"students.sqlite"];
    //2.得到数据库
    FMDatabase *db = [FMDatabase databaseWithPath:filename];
    //3.打开数据库
    if (db.open) {
        //4.创表
        BOOL result = [db executeUpdate:@"CREATE TABLE IF NOT EXISTS t_student (id integer PRIMARY KEY AUTOINCREMENT, name text NOT NULL, age integer NOT NULL, loupan_id text);"];
        [db executeUpdate:@"CREATE TABLE IF NOT EXISTS t_images (id integer PRIMARY KEY AUTOINCREMENT, loupan_id text), image text;"];
        if (result) {
            NSLog(@"创建表成功");
            self.db = db;
            //插入数据
            NSString *name = @"lpz";
         // ?方式，参数要是对象，不是对象要包装为对象
          BOOL result2 =  [self.db executeUpdate:@"INSERT INTO t_student (name, age) VALUES (?, ?);",name,@40];
            if (result2) {
                NSLog(@"插入成功");
                //查询
                FMResultSet *resultSet = [self.db executeQuery:@"SELECT * FROM t_student"];
                while ([resultSet next]) {
                    NSString *relname = [resultSet stringForColumn:@"name"];
                    int age = [resultSet intForColumn:@"age"];
                    NSLog(@"%@ %d",relname,age);
                }
                
            }else{
                NSLog(@"插入失败");
            }
            
        }else{
            NSLog(@"失败");
        }
    }
    self.db = db;
//    NSLog(@"%@",filename);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
