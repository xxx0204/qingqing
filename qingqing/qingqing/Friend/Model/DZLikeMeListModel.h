//
//  DZLikeMeListModel.h
//  qingqing
//
//  Created by Gavin on 2018/6/10.
//  Copyright © 2018年 ShenZhen GaoShengTong Computer software development Co., LTD. All rights reserved.
//

#import <Foundation/Foundation.h>

@class DZAccountModel;
@interface DZLikeMeListModel : NSObject
@property (nonatomic, copy) NSString *desc;
@property (nonatomic, assign) NSInteger resultCode;
@property (nonatomic, strong) NSArray<DZAccountModel *> *otherAccountList;

@end

@interface DZAccountModel : NSObject
@property (nonatomic, assign) NSInteger id;
@property (nonatomic, assign) NSInteger sex;
@property (nonatomic, assign) NSInteger age;
@property (nonatomic, copy) NSString *nickname;
@property (nonatomic, copy) NSString *headPicUrl;
@property (nonatomic, copy) NSString *profession;//职业
@property (nonatomic, copy) NSString *city;//城市
@property (nonatomic, copy) NSString *constellation;//星座
@property (nonatomic, strong)NSArray *pictureUrlList;
@end
