#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol BLCustomContentViewDelegate <NSObject>
- (void)didClickedCloseButton:(UIButton *)button;
@end

@interface BLCustomContentView : UIView
@property (nonatomic, weak) id<BLCustomContentViewDelegate> delegate;
- (void)updateTitle:(NSString *)title desc:(NSString *)desc buttonTitle:(NSString *)buttonTitle;
@end

NS_ASSUME_NONNULL_END
