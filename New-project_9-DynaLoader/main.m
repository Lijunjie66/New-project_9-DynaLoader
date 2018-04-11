//
//  main.m
//  New-project_9-DynaLoader
//
//  Created by Geraint on 2018/4/11.
//  Copyright © 2018年 kilolumen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "BasicGreeter.h"

int main(int argc, char * argv[]) {  // 参数argc设置了程序的参数数量,而argv数组存储了以空格分隔的参数值
    @autoreleasepool {
        
        // 这个函数先创建了一个BasicGreeter对象，并将该对象赋予一个名为greeter的变量，这个变量被声明为id类型并且遵守Greeer协议，然后该函数调用了这个对象中的 greeter: 方法,并输出。
        BasicGreeter *greeter = [[BasicGreeter alloc] init];
        
        //****  如果在 basicGreeter.h 文件里，没有  写 <Greeter>，就用下面注释的这行。
        //__strong id<Greeter> greeter = [[BasicGreeter alloc]init];
        NSLog(@"%@",[greeter greeting:@"Hello"]);
        
        
        /* 2、下面的代码可以分段理解：
                （1）获取包的路径参数
                （2）创建一个NSBundle对象
                （3）加载包
                （4）获得包中的类
                （5）卸载包
                （6）设置包路径参数
         */
        // 2、 在（通过输入参数获得的）指定路径创建一个包
        NSString *bundlePath;
        if (argc != 2) {
            // 没有获得包的路径，退出
            NSLog(@"Please provide a path for the bundle");
        } else {
            //
            bundlePath = [NSString stringWithUTF8String:argv[1]]; //
            
            NSBundle *greeterBundle = [NSBundle bundleWithPath:bundlePath];
            if (greeterBundle == nil) {
                // 没发现包路径
                NSLog(@"Bundle not found at path");
            } else {
                // 以动态方式加载包
                NSError *error;
                // （如果成功加载了包，该方法就会返回一个布尔值YES，如果没有加载包，就返回含有错误信息的NSError对象）
                BOOL isLoaded = [greeterBundle loadAndReturnError:&error];
                if (!isLoaded) {
                    // 报错
                    NSLog(@"Error = %@",[error localizedDescription]);
                } else {
                    // 接下来的代码会获得包中的类，使用这个类创建一个实例，然后调用该实例中的方法，并将这个方法返回的结果显示在输出窗格中。
                    // 加载包后，使用该包创建一个对象并向这个对象发送一条消息
                    Class greeterClass = [greeterBundle classNamed:@"CustomGreeter"];
                    greeter = [[greeterClass alloc] init];
                    NSLog(@"%@",[greeter greeting:@"Hello"]);
                    
                    // 使用完以动态方式加载的包，现在就卸载它
                    // 向释放所有用包中的类创建的对象
                    greeter = nil; // 在卸载包之前，运行时系统要求先释放通过包中类创建的对象，因此，设置为nil
                    BOOL isUnloaded = [greeterBundle unload]; //使用NSBundle类的unload方法可以卸载先前加载的包
                    
                    if (!isUnloaded) {
                        // 检查包是否已经卸载，如果没有卸载会记录一条消息
                        NSLog(@"Couldn't unload bundle");
                    }
                }
            }
        }
        
        
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
