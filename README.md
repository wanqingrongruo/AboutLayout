# AboutLayout
Swift4 布局方式学习



## UIStackView 
####学习资料:
* [UIStackView教程](https://www.jianshu.com/p/ebdf7d447c8b)
* [iOS8 中的 Size Class](https://blog.callmewhy.com/2014/09/12/learn-ios8-size-class/)

## Yoga
### FlexBox
一种 UI 布局方式, 支持所有浏览器. 基于 `盒装模型`. 弹性, 适应不同屏幕
每个视图都是一个矩形盒子, 拥有内外边距...沿着主轴方向
同等级的视图之间没有依赖
#### FlexBox 组成
采用 FlexBox 布局的元素称为 Flex Container.
Flex Container 的所有元素称为 Flex Item 
![FlexBox](http://p1o0sbmit.bkt.clouddn.com/FlexBox.png)

##### Flex Container 的 属性
####### Flex Direction
FlexBox 有一个主轴 main axis 和 侧轴 cross axis. 侧轴垂直于主轴.
可水平可垂直
主轴默认为 row(水平), 侧轴默认为 column
Flex Direction 决定了 Flex Container 内的主轴排布方向
- row
- rowReverse
- column
- columnReverse
```
// Yogakit 使用
 layout.flexDirection = .row
 layout.flexDirection = .rowReverse
 layout.flexDirection = .column
 layout.flexDirection = .columnReverse
 ```
 
###### Flex Wrap
决定在轴线上排列不下时,视图的换行方式
 - NoWrap: 不换行
 - Wrap: 换行
 - WrapReverse: 换行方向与 Wrap 相反
 ```
 // Yogakit 使用
 layout.flexWrap = .noWrap
 layout.flexWrap = .wrap
 layout.flexWrap = .wrapReverse
 ```
 适用于类型于微信发朋友圈时的九宫格布局
###### Display
Display 选择是否计算它,默认为 flex. 当设置为 none 时将自动忽略该视图的计算
```
// Yogakit 使用
// 布局内使用
 layout.display = .flex
 layout.display = .none
// 布局外根据条件调整 -- caseLabel 是个 UILabel,自动忽略
 castLabel.yoga.display = .flex
 castLabel.yoga.display = .none
 ```       
###### Justify Content
 用于定义 Flex Item 在主轴上的对齐方式
 - FlexStart: 主轴起点对齐
 - FlexEnd: 主轴终点对齐
 - Center: 居中对齐
 - SpaceBetween: 两端对齐
 - SpaceAround: 外边距相等对齐
 ```
  // Yogakit 使用
   layout.justifyContent = .flexStart
   layout.justifyContent = .flexEnd
   layout.justifyContent = .center
   layout.justifyContent = .spaceBetween
   layout.justifyContent = .spaceAround
   ```
###### Align Items
定义 Flex Item 在侧轴上的对齐方式
- FlexStart: 侧起点对齐
 - FlexEnd: 侧终点对齐
 - Center: 居中对齐
 - SpaceBetween: 两端对齐
 - SpaceAround: 外边距相等对齐
 - Baseline: 基线对齐(基于 Flex Item 第一行文字的基线对齐)
 - Stretch(默认值): 让 Flex Item 拉伸填充整个 Flex Container
 ps: 如果 Align Items 未设置数值,或设为 auto, 将占满整个 Flex Container 的高度
```
 // Yogakit 使用
 /* typedef YG_ENUM_BEGIN(YGAlign) {
        YGAlignAuto,
        YGAlignFlexStart,
        YGAlignCenter,
        YGAlignFlexEnd,
        YGAlignStretch,
        YGAlignBaseline,
         YGAlignSpaceBetween,
         YGAlignSpaceAround,
    } YG_ENUM_END(YGAlign);
      */
     layout.alignItems = .center
```
###### Align Content
也是侧轴里的对齐方式,只不过是以**一整行**作为最小的单位
只有一行不起作用, 调整 FlexWrap = .wrap 效果才会显示出来
属性值与 `Align Items ` 相同

##### Flex Item 的属性
Flex Container 里的属性都是作用于自己包含的 Flex Item. 
Flex Item 的属性都是作用于自己本身.
###### AlignSelf
可以让单个 Flex Item 与 其他 Flex Item 有不一样的对齐方式,**覆盖 Align Items 属性**
属性值与 `Align Items ` 相同
默认值是 `auto`, 表示继承 Flex Container 的 Align Items 属性.如果本身没有 Flex Container, 则等同于 Stretch
###### FlexGrow
设置分配剩余空间的比例. 即如何扩大
默认值为0,即如果没有定义 FlexGrow ,该布局就没有分配剩余空间的权利
>  如果所有 Flex Item 的 FlexGrow 属性都为 1 ，如果有剩余空间的话，则等分剩余空间。
如果一个 Flex Item 的 FlexGrow 属性为 2，其余 Flex Item 都为 1 ，则前者占据的剩余空间将比其他 Flex Item 多 1 倍。
作者：ZenonHuang
链接：https://juejin.im/post/5a33a6926fb9a045104a8d3c
来源：掘金
###### FlexShrink
与 FlexGrow 处理空间相反, FlexShrink 用来处理空间不足的情况,即怎么缩小
默认值为1,即如果空间不足,该项目将缩小
如果所有 Flex Item 的 FlexShrink 属性都为 1，当空间不足时，都将等比例缩小。
如果一个 Flex Item 的 FlexShrink 属性为 0 ，其余 Flex Item 都为1，则空间不足时，`FlexShrink 为 0 的 item 不缩小`, 负值无效.


###### FlexBasics
定义了再分配多余的空间之前, Flex Item 占据的 main size (主轴空间).浏览器根据这个属性计算主轴是否有多余空间
默认值为 `auto`, 即 Flex Item 的本来大小
### FlexBox 的实现 --- Yoga
[Yoga](https://github.com/facebook/yoga) 是由 C 实现的 FlexBox 布局引擎.
![YogaKit结构](http://p1o0sbmit.bkt.clouddn.com/15151378556879.jpg)
##### Properties
- isEnable: 我们每写一个控件的约束都需要开启. 默认 false

##### Methods
- applyLayout(preservingOrigin:dimensionFlexibility:)) 申请布局并保存`根视图`的 origin
- (applyLayout(preservingOrigin:dimensionFlexibility:)); 申请布局并保存`根视图`的 origin;同时设置dimensionFlexibility参数,**指明调整高度还是宽度**

### FlexLayout 学习
对 YogaKit 的再封装
##### flex 属性
通过 runtime 赋予 view 的 新属性, 与 YogaKit 中的 `yoga` 处理方式相同
包含了 yoga 和 view 两个属性. 使用时直接 赋予了 `yoga.isEnable = true`
进一步把 yoga 的所有属性及方法封装了一遍. 用户可以用链式语法进行设置(就是把 `yoga.configureLayout(:)` 以链式语法的形式实现 ); 同时把添加 `flex item` 以 block 的形式操作, 视图层次不是特别深(>3???)的行为代码看起来更舒服



## 学习资料
[Yoga](https://github.com/facebook/yoga)
[iOS 上的 FlexBox 布局](https://juejin.im/post/5a33a6926fb9a045104a8d3c)
[【翻译】Yoga 教程: 使用跨平台布局引擎](https://archimboldi.me/posts/翻译-yoga-教程-使用跨平台布局引擎.html)
[FlexLayout - 封装 YogaKit ](https://github.com/layoutBox/FlexLayout)
[Flex 布局教程：语法篇](http://www.ruanyifeng.com/blog/2015/07/flex-grammar.html)





