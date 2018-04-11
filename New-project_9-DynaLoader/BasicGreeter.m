//
//  BasicGreeter.m
//  New-project_9-DynaLoader
//
//  Created by Geraint on 2018/4/11.
//  Copyright © 2018年 kilolumen. All rights reserved.
//

#import "BasicGreeter.h"

@implementation BasicGreeter

// 该方法返回以其输入参数开头的文本字符串
- (NSString *) greeting:(NSString *)salutating {
    return [NSString stringWithFormat:@"%@,World!",salutating];
}

@end
