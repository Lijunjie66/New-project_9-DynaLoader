//
//  Greeter.h
//  New-project_9-DynaLoader
//
//  Created by Geraint on 2018/4/11.
//  Copyright © 2018年 kilolumen. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol Greeter <NSObject>

// 该协议声明了一个名为greeting的方法，该方法接受NSString类型的指针作为参数，并返回一个NSString类型的指针。
- (NSString *) greeting:(NSString *)salutating;

@end
