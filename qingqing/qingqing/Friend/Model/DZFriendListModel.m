//
//Created by ESJsonFormatForMac on 18/05/27.
//

#import "DZFriendListModel.h"
@implementation DZFriendListModel

+(NSDictionary *)objectClassInArray{
    return @{@"matchList" : [DZGMModel class],@"matchNearExpireList" : [DZGMModel class],@"matchExpireList" : [DZGMModel class],@"matchExtensionList" : [DZGMModel class],@"likeMeList" : [DZGMModel class],@"friendList" : [DZGMModel class]};
}

//-(void)setMatchNearExpireList:(NSArray<DZGMModel *> *)matchNearExpireList{
//    for (DZGMModel *dz_gm_m in matchNearExpireList) {
//        dz_gm_m.type=1;
//    }
//}
-(void)setMatchNearExpireList:(NSArray<DZGMModel *> *)matchNearExpireList{
    for (DZGMModel *dz_gm_m in matchNearExpireList) {
        dz_gm_m.type=1;
    }
    _matchNearExpireList=matchNearExpireList;
}
-(void)setLikeMeList:(NSMutableArray<DZGMModel *> *)likeMeList{
    for (DZGMModel *dz_gm_m in likeMeList) {
        dz_gm_m.type=2;
    }
    _likeMeList=likeMeList;
}
-(void)setMatchList:(NSArray<DZGMModel *> *)matchList{
    for (DZGMModel *dz_gm_m in matchList) {
        dz_gm_m.type=3;
    }
    _matchList=matchList;
}
-(void)setMatchExtensionList:(NSArray<DZGMModel *> *)matchExtensionList{
    for (DZGMModel *dz_gm_m in matchExtensionList) {
        dz_gm_m.type=4;
    }
    _matchExtensionList=matchExtensionList;
}
-(void)setMatchExpireList:(NSArray<DZGMModel *> *)matchExpireList{
    for (DZGMModel *dz_gm_m in matchExpireList) {
        dz_gm_m.type=5;
    }
    _matchExpireList=matchExpireList;
}
@end

@implementation DZGMModel


@end


