//
//  ExpressActivityIndicatorView.m
//  ExpressVerify
//
//  Created by Apple on 2018/5/9.
//

#import "ExpressActivityIndicatorView.h"

@interface ExpressActivityIndicatorView()

@property (nonatomic,strong) UIImageView *indicatorImageView;
@property (nonatomic, readwrite) BOOL isAnimating;


@end

@implementation ExpressActivityIndicatorView

+(instancetype)defaultIndicator{
    
    return [[self alloc] initWithFrame:CGRectZero];
    
}


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initialize];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self initialize];
    }
    return self;
}



-(void)initialize{
    
    self.backgroundColor = [UIColor clearColor];
    [self addSubview:self.indicatorImageView];
}

-(void)layoutSubviews{
    
    [super layoutSubviews];
    
    UIView *superView = [self superview];
    CGRect frame = superView.frame;
    
    CGSize size = _indicatorImageView.image.size;
    
    self.indicatorImageView.frame = CGRectMake((frame.size.width - size.width)*0.5, (frame.size.height - size.height)*0.5, size.width, size.height);
    
}



-(UIImageView *)indicatorImageView{
    
    if (!_indicatorImageView) {
        
        
        _indicatorImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"IndicatorViewLoading"]];
    }
    return _indicatorImageView;
}



- (void)startAnimating{
    
    if (self.isAnimating)
        return;
    
    CABasicAnimation* rotationAnimation;
    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI * 2.0 ];
    rotationAnimation.duration = 2.0;
    rotationAnimation.cumulative = YES;
    rotationAnimation.repeatCount = MAXFLOAT;
    
    [_indicatorImageView.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
    
    self.isAnimating = true;
    
    if (self.hidesWhenStopped) {
        self.hidden = NO;
    }
    
}
- (void)stopAnimating{
    
    if (!self.isAnimating)
        return;
    
    [self.indicatorImageView.layer removeAllAnimations];
    
    self.isAnimating = false;
    
    if (self.hidesWhenStopped) {
        self.hidden = YES;
    }
    
}


- (BOOL)isAnimating{
    return _isAnimating;
}

- (void)setHidesWhenStopped:(BOOL)hidesWhenStopped {
    _hidesWhenStopped = hidesWhenStopped;
    self.hidden = !self.isAnimating && hidesWhenStopped;
}

@end
