//
//Created by ESJsonFormatForMac on 18/06/11.
//

#import "DZInfoModel.h"
@implementation DZInfoModel

+ (NSDictionary *)objectClassInArray{
    return @{@"otherAccountList" : [DZOtherAccounModel class]};
}

@end

@implementation DZOtherAccounModel

+ (NSDictionary *)objectClassInArray{
    return @{@"flagList" : [DZFlagModel class],@"qaList" : [DZQaListModel class]};
}

@end

@implementation DZFlagModel

@end

@implementation DZQaListModel

@end
