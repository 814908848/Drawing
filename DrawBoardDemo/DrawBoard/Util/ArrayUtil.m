//
//  ArrayUtil.m
//  StudentClient
//
//  Created by Shadow on 14-4-22.
//  Copyright (c) 2014年 imobile. All rights reserved.
//

#import "ArrayUtil.h"
#import "CommonUtil.h"
@implementation ArrayUtil

+ (NSArray *)splitString:(NSString *)string separator:(NSString *)sep
{
    return [string componentsSeparatedByString:sep];
}

+ (BOOL)isContain:(NSArray *)array searchObj:(id)searchObj
{
    return [array containsObject:searchObj];
}

+ (NSArray *)subArray:(NSArray *)array startIndex:(int)start endIndex:(int)endIndex
{
    NSRange range = [CommonUtil getRange:start end:endIndex];
    return [array subarrayWithRange:range];
}

+ (id)lastObject:(NSArray *)array
{
    return [array lastObject];
}

+ (id)getObject:(NSArray *)array atIndex:(int)index
{
    return [array objectAtIndex:index];
}

+ (int)indexOf:(NSArray *)array searchObj:(id)obj
{
    return [NSString stringWithFormat:@"%lu",(unsigned long)[array indexOfObject:obj]].intValue;
}

+ (int)lastIndexOf:(NSArray *)array searchObj:(id)obj
{
    
    int indexMark = [NSString stringWithFormat:@"%lu",(unsigned long)[array count]].intValue;
    int index = -1;
    NSEnumerator *en = [array reverseObjectEnumerator];
    id object;
    while ((object = [en nextObject])) {
        indexMark -- ;
        if([object isEqual:obj]){
            index = indexMark;
        }
    }
    return index; 
}

+ (NSArray *)add:(NSArray *)array obj:(id)obj
{
    return [array arrayByAddingObject:obj];
}

+ (NSArray *)addAll:(NSArray *)array objs:(NSArray *)objs
{
    return [array arrayByAddingObjectsFromArray:objs];
}

+ (NSMutableArray *)coventToMutableArray:(NSArray *)array
{
    return [array mutableCopy];
}

+ (BOOL)isEmpty:(NSArray *)array
{
    if(array == nil || [array count] == 0){
        return YES;
    }else{
        return NO;
    }
}

+ (NSArray *)sort:(NSArray *)array
{
    NSCountedSet *countedSet = [[NSCountedSet alloc] initWithArray:array];
    return [[countedSet allObjects] sortedArrayUsingSelector:@selector(compare:)];
}

+ (NSArray *)reverse:(NSArray *)array
{
    return [[array reverseObjectEnumerator] allObjects];
}
@end
