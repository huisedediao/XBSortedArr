//
//  XBSortedArr.h
//  Moyu
//
//  Created by xxb on 2021/4/29.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol XBSortedObj <NSObject>

//返回的指针的值相等，两个obj才相等
- (id)identity;

/**
 1  : 当前对象大于传入的对象
 0  : 当前对象等于传入的对象
 -1 : 当前对象小于传入的对象
 */
- (int)compare:(id<XBSortedObj>)obj;

@end

@interface XBSortedArr : NSObject

/**
 默认 0
 0：升序
 1：降序
 */
- (instancetype)initWithOrder:(int)order;

/**
 当前排序方式
 */
- (int)order;

/**
 如果已经存在相同identity的对象，则会覆盖，并重新排序
 */
- (void)addObj:(id<XBSortedObj>)obj;

- (void)addObjsFromArr:(NSArray<id<XBSortedObj>> *)objs;

- (void)removeObjAtIndex:(NSInteger)index;

- (void)removeObj:(id<XBSortedObj>)obj;

- (void)removeAll;

- (NSInteger)count;

/**
 未找到则返回-1
 */
- (NSInteger)indexForObj:(id<XBSortedObj>)obj;

- (id<XBSortedObj>)objAtIndex:(NSInteger)index;

@end

NS_ASSUME_NONNULL_END
