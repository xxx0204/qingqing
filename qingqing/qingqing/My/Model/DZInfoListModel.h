//
//Created by ESJsonFormatForMac on 18/06/24.
//

#import <Foundation/Foundation.h>

@class DZInfoOptionlistModel;
@interface DZInfoListModel : NSObject

@property (nonatomic, copy) NSString *desc;

@property (nonatomic, assign) NSInteger resultCode;

@property (nonatomic, strong) NSArray<DZInfoOptionlistModel *> *optionList;

@end
@interface DZInfoOptionlistModel : NSObject

@property (nonatomic, assign) NSInteger id;

@property (nonatomic, assign) long long createTime;

@property (nonatomic, copy) NSString *content;

@property (nonatomic, assign) NSInteger type;

@end

