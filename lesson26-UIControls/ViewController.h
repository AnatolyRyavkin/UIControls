//
//  ViewController.h
//  lesson26-UIControls
//
//  Created by Anatoly Ryavkin on 13/05/2019.
//  Copyright © 2019 AnatolyRyavkin. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,ChangeStatusAnimation){
    ChangeStatusAnimationStart,
    ChangeStatusAnimationStop
};


@interface ViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *viewImage;

@property (weak, nonatomic) IBOutlet UILabel *imageLabel;
@property (weak, nonatomic) IBOutlet UILabel *moveLabel;
@property (weak, nonatomic) IBOutlet UILabel *scaleLabel;
@property (weak, nonatomic) IBOutlet UILabel *rotationLabel;
@property (weak, nonatomic) IBOutlet UITextField *speedText;
@property (weak, nonatomic) IBOutlet UISegmentedControl *imageSegmentControl;
@property (weak, nonatomic) IBOutlet UISlider *speedSlider;
@property (weak, nonatomic) IBOutlet UISwitch *switchScale;
@property (weak, nonatomic) IBOutlet UISwitch *switchMove;
@property (weak, nonatomic) IBOutlet UISwitch *switchRotation;




- (IBAction)imadeSegmentControl:(UISegmentedControl *)sender;

- (IBAction)speedSlider:(UISlider *)sender;
- (IBAction)speedSliderUpInside:(UISlider *)sender;
- (IBAction)speedDidEndOnExit:(UISlider *)sender;
- (IBAction)speedEditingDidBegin:(UISlider *)sender;
- (IBAction)speedEditingDidEnd:(UISlider *)sender;
- (IBAction)speedTouchDragOutside:(UISlider *)sender;



- (IBAction)moveSwith:(UISwitch *)sender;
- (IBAction)scaleSwith:(UISwitch *)sender;
- (IBAction)rotationSwith:(UISwitch *)sender;


@property UIImage* cat1;
@property UIImage* cat2;
@property UIImage* cat3;
@property UIImage* cat4;

@property UIViewPropertyAnimator* animationMove;
@property UIViewPropertyAnimator* animationScale;
@property UIViewPropertyAnimator* animationRotation;

@property CGFloat speed;

@property CGPoint pointCurrent;
@property CGFloat scaleCurrent;
@property CGFloat rotationAngleCurrent;

@property ChangeStatusAnimation statusMove;
@property ChangeStatusAnimation statusScale;
@property ChangeStatusAnimation statusRotation;

@property BOOL flagRunMoveCurrent;
@property BOOL flagRunScaleCurrent;
@property BOOL flagRunRotationCurrent;

@property BOOL flagMoveSenderSpeed;


-(void)animationMove: (CGFloat) speed andStartOrStop: (ChangeStatusAnimation) status;
-(void)animationScale: (CGFloat) speed andStartOrStop: (ChangeStatusAnimation) status;
-(void)animationRotation: (CGFloat) speed andStartOrStop: (ChangeStatusAnimation) status;



-(CGPoint)randomPoint;

@end

