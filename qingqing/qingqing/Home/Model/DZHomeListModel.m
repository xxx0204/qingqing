//
//Created by ESJsonFormatForMac on 18/05/24.
//

#import "DZHomeListModel.h"

@implementation DZHomeListModel

//+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass{
//    return @{@"list" : [DZHomeList class]};
//}
+(NSDictionary *)objectClassInArray{
    return @{@"list" : [DZHomeList class]};
}

@end

@implementation DZHomeList

//+(NSDictionary *)objectClassInArray{
//    return @{@"ID":@"id"};
//}
//+ (NSDictionary<NSString *,id> *)modelCustomPropertyMapper{
//    return @{@"ID":@"id"};
//}

@end


