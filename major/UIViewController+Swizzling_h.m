//
//  practice-rongyun
//
//  Created by 李书康 on 2018/12/24.
//  Copyright © 2018 com.li.www. All rights reserved.
//

#import "UIViewController+Swizzling_h.h"
#import <objc/runtime.h>
/// swizzling修改融云定位页面navigation.tintColor
/// swift中使用swizzling并不方便,所以使用OC实现方式.
@implementation UIViewController (Swizzling_h)

+ (void)load {
    [super load];
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        //原本的willAppear方法
        Method willAppearOriginal = class_getInstanceMethod([self class], @selector(viewWillAppear:));
        //我们的willAppear方法
        Method willAppearNew = class_getInstanceMethod([self class], @selector(swizzlingViewWillAppear:));
        //交换
        if (!class_addMethod([self class], @selector(viewWillAppear:), method_getImplementation(willAppearNew), method_getTypeEncoding(willAppearNew))) {
            method_exchangeImplementations(willAppearOriginal, willAppearNew);
        }
    });
}

- (void)swizzlingViewWillAppear:(BOOL)animated {
    [self swizzlingViewWillAppear:animated];
    if ([self isMemberOfClass:NSClassFromString(@"RCAlumListTableViewController")] || [self isMemberOfClass:NSClassFromString(@"RCLocationPickerViewController")] || [self isMemberOfClass:NSClassFromString(@"RCLocationViewController")] || [self isMemberOfClass:NSClassFromString(@"PUPhotoPickerHostViewController")] || [self isMemberOfClass:NSClassFromString(@"EWPersonChatViewController")]) {
        [self configureRongCloudNavigation];
    }
}

- (void)configureRongCloudNavigation {
    ///修改navigation样式为需要的样式,已保证与原生app一致
    self.navigationController.navigationBar.shadowImage = [[UIImage alloc] init];
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor blackColor];
    self.navigationItem.rightBarButtonItem.tintColor = [UIColor blackColor];
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
}

@end
