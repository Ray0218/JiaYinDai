//
//  JYTabBar.m
//  JiaYinDai
//
//  Created by 吴孔亮 on 2017/3/24.
//  Copyright © 2017年 嘉远控股. All rights reserved.
//

#import "JYTabBar.h"

#import <OAStackView/OAStackView.h>

@interface JYTabBarItemView : UIView
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *badgeLabel;
@property (nonatomic, weak) JYTabBarItem *item;
@end


@implementation JYTabBarItemView

- (instancetype)initWithItem:(JYTabBarItem *)item {
    if (self = [super init]) {
        _item = item;
        
        [self setupProperty];
        [self setupConstraints];
        
        RAC(self.titleLabel, text) = RACObserve(self.item, title);
        @weakify(self);
        [RACObserve(self.item, badgeValue) subscribeNext:^(NSString *title) {
            @strongify(self);
            self.badgeLabel.text = title;
            self.badgeLabel.hidden = title.length == 0 || title.integerValue == 0;
        }];
    }
    return self;
}

- (void)setupProperty {
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.backgroundColor = [UIColor clearColor];
    _titleLabel.font = [UIFont systemFontOfSize:14];
    _titleLabel.textColor = [UIColor colorWithRed:0.49 green:0.44 blue:0.4 alpha:1];
    _titleLabel.highlightedTextColor = [UIColor  blueColor];
    
    _badgeLabel = [[UILabel alloc] init];
    _badgeLabel.backgroundColor = [UIColor colorWithRed:0.9 green:0.24 blue:0.22 alpha:1];
    _badgeLabel.font = [UIFont systemFontOfSize:8];
    _badgeLabel.textColor = [UIColor whiteColor];
    _badgeLabel.layer.cornerRadius = 6;
    _badgeLabel.layer.masksToBounds = YES;
    _badgeLabel.textAlignment = NSTextAlignmentCenter;
}

- (void)setupConstraints {
    [self addSubview:self.titleLabel];
    [self addSubview:self.badgeLabel];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
    }];
    [self.badgeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel.mas_right);
        make.centerY.equalTo(self.titleLabel.mas_top);
        make.height.equalTo(@12);
        make.width.equalTo(@16);
    }];
}

@end

@interface JYTabBarItem ()
@end

@implementation JYTabBarItem

- (instancetype)initWithTitle:(NSString *)title {
    
    return [self initWithTitle:title badgeValue:nil];
}

- (instancetype)initWithTitle:(NSString *)title badgeValue:(NSString *)badgeValue {
    if (self = [super init]) {
        _title = title;
        _badgeValue = badgeValue;
    }
    return self;
}

@end

@interface JYTabBar (){
    
@private
    RACSubject *_rac_signalForSelectedItem;
}
@property (nonatomic, strong) OAStackView *stackView;
@property (nonatomic, strong) NSArray *tabBarItemViews;
@property (nonatomic, assign) NSInteger selectedIndex;
@property (nonatomic, strong) UIView *lineView;

@end

@implementation JYTabBar

@synthesize selectedItem = _selectedItem;

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewDidTapped:)]];
    }
    return self;
}

- (void)viewDidTapped:(UITapGestureRecognizer *)tapGesture {
    CGPoint point = [tapGesture locationInView:self.stackView];
    for (int i = 0; i < self.tabBarItemViews.count; i++) {
        JYTabBarItemView *view = self.tabBarItemViews[i];
        if (CGRectContainsPoint(view.frame, point)) {
            [self setSelectedItem:view.item animation:YES execute:YES];
            break;
        }
    }
}

- (void)makeLineContraintWithView:(UIView *)view {
    [self.lineView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view).offset(20);
        make.right.equalTo(view).offset(-20);
        make.height.equalTo(@3);
        make.bottom.equalTo(self).offset(-0.5);
    }];
}

#pragma mark - getter, setter

- (RACSignal *)rac_signalForSelectedItem {
    if (!_rac_signalForSelectedItem) {
        _rac_signalForSelectedItem = [RACSubject subject];
    }
    return _rac_signalForSelectedItem;
}

- (void)setSelectedItem:(JYTabBarItem * )selectedItem animation:(BOOL)animation execute:(BOOL)execute   {
    if ([self.items containsObject:selectedItem]) {
        NSInteger selectedIndex = [self.items indexOfObject:selectedItem];
        [self willChangeValueForKey:@"selectedIndex"];
        _selectedIndex = selectedIndex;
        [self didChangeValueForKey:@"selectedIndex"];
        _selectedItem = selectedItem;
        
        [_tabBarItemViews enumerateObjectsUsingBlock:^(JYTabBarItemView *itemView, NSUInteger idx, BOOL *stop) {
            itemView.titleLabel.highlighted = idx == selectedIndex;
        }];
        
        // 调整指示条
        [self makeLineContraintWithView:self.tabBarItemViews[selectedIndex]];
        [self setNeedsLayout];
        
        if (animation) {
            [UIView animateWithDuration:0.3
                                  delay:0
                 usingSpringWithDamping:1
                  initialSpringVelocity:1
                                options:UIViewAnimationOptionCurveEaseInOut
                             animations:^{
                                 [self layoutIfNeeded];
                             }
                             completion:nil];
        }
        
        // 执行命令
        if (execute && _rac_signalForSelectedItem) {
            [_rac_signalForSelectedItem sendNext:selectedItem];
        }
        
    }
}

- (void)setSelectedItem:(JYTabBarItem *)selectedItem {
    [self setSelectedItem:selectedItem animation:YES execute:NO];
}

- (JYTabBarItem *)selectedItem {
    if (_selectedIndex < _items.count) {
        return _items[_selectedIndex];
    }
    return nil;
}

- (void)setItems:(NSArray *)items {
    NSAssert(items.count > 0, @"Can not be empty.");
    
    if ([_items isEqualToArray:items]) {
        return;
    }
    
    _items = items.copy;
    
    [self.stackView removeFromSuperview];
    if (self.lineView.superview == nil) {
        [self addSubview:self.lineView];
    }
    
    // 重新生成item, 并布局
    NSMutableArray *tabBarItemViews = [NSMutableArray arrayWithCapacity:items.count];
    //    for (JYTabBarItem *item in items) {
    
    for (int i = 0; i < items.count; i++) {
        
        JYTabBarItem *item = items[i] ;
        item.tag = 1000 + i ;
        
        JYTabBarItemView *itemView = [[JYTabBarItemView alloc] initWithItem:item];
        itemView.backgroundColor = [UIColor clearColor];
        [tabBarItemViews addObject:itemView];
    }
    OAStackView *stackView = [[OAStackView alloc] initWithArrangedSubviews:tabBarItemViews];
    stackView.alignment = OAStackViewAlignmentFill;
    stackView.axis = UILayoutConstraintAxisHorizontal;
    stackView.spacing = 0;
    stackView.distribution = OAStackViewDistributionFillEqually;
    [self addSubview:stackView];
    [stackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    //
    _stackView = stackView;
    _tabBarItemViews = tabBarItemViews;
    
    // 选中第一个
    _selectedItem = [items firstObject];
    
    [self willChangeValueForKey:@"selectedIndex"];
    _selectedIndex = 0;
    [self didChangeValueForKey:@"selectedIndex"];
    
    
    [_tabBarItemViews enumerateObjectsUsingBlock:^(JYTabBarItemView *itemView, NSUInteger idx, BOOL *stop) {
        itemView.titleLabel.highlighted = idx == _selectedIndex;
    }];
    
    
    [self makeLineContraintWithView:[tabBarItemViews firstObject]];
    [self setNeedsLayout];
}

- (UIView *)lineView {
    if (_lineView == nil) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = [UIColor blueColor];
    }
    return _lineView;
}

#pragma mark - draw function

- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGColorRef color = [UIColor colorWithRed:0.83 green:0.84 blue:0.79 alpha:1].CGColor;
    
    CGContextSetFillColorWithColor(context, color);
    CGContextFillRect(context, CGRectMake(0, CGRectGetHeight(rect) - 0.5, CGRectGetWidth(rect), 0.5));
}

@end
