//
//  XBSortedArr.m
//  Moyu
//
//  Created by xxb on 2021/4/29.
//

#import "XBSortedArr.h"

@interface XBSortedArr ()
{
    int _order;
}
@property (nonatomic,readwrite,strong)NSMutableArray *arrmOrderKeys;
@property (nonatomic,readwrite,strong)NSMutableDictionary *objMap;
@end

@implementation XBSortedArr

- (instancetype)initWithOrder:(int)order {
    if (self = [super init]) {
        _order = order;
    }
    return self;
}

- (int)order {
    return _order;
}

- (void)addObj:(id<XBSortedObj>)obj {
    if (obj == nil) return;
    if ([obj respondsToSelector:@selector(compare:)] == false) {
        NSLog(@"需要添加的对象未实现 compare: 方法 ,对象类型 %@",[obj class]);
        return;
    }
    id identity = [self objID:obj];
    self.objMap[identity] = obj;
    
    if ([self.arrmOrderKeys containsObject:identity]){
        [self.arrmOrderKeys removeObject:identity];
    }
    
    NSInteger index = 0;
    
    for (int i = 0; i < self.arrmOrderKeys.count; i++) {
        id identityTemp = self.arrmOrderKeys[i];
        id objTemp = self.objMap[identityTemp];
        int compare = [obj compare:objTemp];
        if ((_order == 0 && compare < 1) || (_order == 1 && compare == 1)) {
            break;
        }
        index++;
    }
    [self.arrmOrderKeys insertObject:identity atIndex:index];
}

- (void)addObjsFromArr:(NSArray<id<XBSortedObj>> *)objs {
    for (id obj in objs) {
        [self addObj:obj];
    }
}

- (void)removeObjAtIndex:(NSInteger)index {
    if (index >= self.arrmOrderKeys.count || index < 0) return;
    [self.objMap removeObjectForKey:self.arrmOrderKeys[index]];
    [self.arrmOrderKeys removeObjectAtIndex:index];
}

- (void)removeObj:(id<XBSortedObj>)obj {
    NSInteger index = [self indexForObj:obj];
    if (index != -1) {
        [self removeObjAtIndex:index];
    }
}

- (void)removeAll {
    self.arrmOrderKeys = nil;
    self.objMap = nil;
}

- (NSInteger)count {
    return self.arrmOrderKeys.count;
}

/**
 未找到则返回-1
 */
- (NSInteger)indexForObj:(id<XBSortedObj>)obj {
    id identity = [self objID:obj];
    NSInteger index = [self.arrmOrderKeys indexOfObject:identity];
    if (index != NSNotFound) {
        return index;
    } else {
        return -1;
    }
}

- (id<XBSortedObj>)objAtIndex:(NSInteger)index {
    if (index >= self.arrmOrderKeys.count || index < 0) return nil;
    return self.objMap[self.arrmOrderKeys[index]];
}

- (id)objID:(id<XBSortedObj>)obj {
    if ([obj respondsToSelector:@selector(identity)] == false) {
        NSString *idStr = [NSString stringWithFormat:@"%p",obj];
        NSLog(@"需要添加的对象%@ 未实现 identity 方法，使用对象的地址作为id, id：%@",[obj class],idStr);
        return idStr;
    }
    id identity = [obj identity];
    if (identity == nil) {
        NSString *idStr = [NSString stringWithFormat:@"%p",obj];
        NSLog(@"需要添加的对象%@ identity 返回nil，使用对象的地址作为id, id：%@",[obj class],idStr);
        return idStr;
    } else {
        return identity;
    }
}

- (NSMutableArray *)arrmOrderKeys {
    if (_arrmOrderKeys == nil) {
        _arrmOrderKeys = [NSMutableArray new];
    }
    return _arrmOrderKeys;
}

- (NSMutableDictionary *)objMap {
    if (_objMap == nil) {
        _objMap = [NSMutableDictionary new];
    }
    return _objMap;
}

@end
