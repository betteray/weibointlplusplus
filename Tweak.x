/* How to Hook with Logos
Hooks are written with syntax similar to that of an Objective-C @implementation.
You don't need to #include <substrate.h>, it will be done automatically, as will
the generation of a class list and an automatic constructor.
*/
#import <UIKit/UIKit.h>

%hook WONavigationController

- (void)viewDidAppear:(BOOL)animated {

	%orig; // Call through to the original function with its original arguments.

    // UIViewController *controller = (UIViewController *)self;
    UINavigationController *navController = (UINavigationController *)self;
    if (navController) {
        UIView *backgroundView = [navController.navigationBar valueForKey:@"_backgroundView"];
        if (backgroundView) {
            NSArray *array = [backgroundView subviews];
            if (array.count >= 2) {
                UIImageView *imageView = array[1];
                if ([imageView isKindOfClass:[UIImageView class]]) {
                    imageView.image = nil;
                    imageView.backgroundColor = UIColor.blackColor;
                    UIView *myBlackView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, imageView.bounds.size.width, imageView.bounds.size.height)];
                    myBlackView.backgroundColor = UIColor.blackColor;
                    [backgroundView addSubview:myBlackView];
                }
            }
        }
    }
}

%end

%hook WOTabBarController

- (void)viewDidAppear:(BOOL)animated {
    %orig;

    UIViewController *vc = (UIViewController *) self;
    UIView *tabBar = [vc valueForKey:@"_tabBar"];
    UIImageView *imageView = [tabBar subviews][1];
    imageView.image = 0;
    imageView.backgroundColor = UIColor.blackColor;
}

%end

%hook ThemeColor

- (UIColor *)card_bg {
    return UIColor.blackColor;
}

- (UIColor *)card_sub_bg {
    return UIColor.blackColor;
}

- (UIColor *)repost_bg {
    return UIColor.blackColor;
}

- (UIColor *)sp_bg {
    return UIColor.blackColor;
}

%end

%ctor {
    %init(ThemeColor = objc_getClass("WeiboOverseas.ThemeColor"));
}
