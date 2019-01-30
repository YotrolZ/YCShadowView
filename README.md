# YCShadowView

![](https://github.com/YotrolZ/YCShadowView/blob/master/Example/YCShadowView/example%402x.png)

## Example
- To run the example project, clone the repo, and run `pod install` from the Example directory first.

## How to use YCShadowView

- Installation with CocoaPods：
    - `pod 'YCShadowView'`
    -  `#import <YCShadowView/YCShadowView.h>` 
- Manual import：
    - Drag the YCShadowView folder to project
    - `#import "YCShadowView.h"`

- Use
```Objc
YCShadowView *view = [[YCShadowView alloc] initWithFrame:CGRectMake(200, 250, 100, 100)];
view.backgroundColor = [UIColor whiteColor];
[view yc_shaodwRadius:10 shadowColor:[UIColor colorWithWhite:0 alpha:0.5] shadowOffset:CGSizeMake(0, 0) byShadowSide:(YCShadowSideRight)];
[view yc_cornerRadius:10 byRoundingCorners:(UIRectCornerBottomLeft)];
```

## Author

yotrolz, 207213149@qq.com

## License

YCShadowView is available under the MIT license. See the LICENSE file for more info.
