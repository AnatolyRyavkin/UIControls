//
//  ViewController.m
//  lesson26-UIControls
//
//  Created by Anatoly Ryavkin on 13/05/2019.
//  Copyright © 2019 AnatolyRyavkin. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end



@implementation ViewController

#pragma mark- DidLoad

- (void)viewDidLoad {
    [super viewDidLoad];
    self.cat1=[UIImage imageNamed:@"cat1.png"];
    self.cat2=[UIImage imageNamed:@"cat2.png"];
    self.cat3=[UIImage imageNamed:@"cat3.png"];
    self.cat4=[UIImage imageNamed:@"cat4.png"];
    self.viewImage.image=self.cat1;
    self.speed=self.speedSlider.value;
    self.scaleCurrent=self.speedSlider.value;
    self.statusMove= (self.switchMove.isOn) ? ChangeStatusAnimationStart : ChangeStatusAnimationStop;
    self.statusScale= (self.switchMove.isOn) ? ChangeStatusAnimationStart : ChangeStatusAnimationStop;
    self.statusRotation= (self.switchMove.isOn) ? ChangeStatusAnimationStart : ChangeStatusAnimationStop;
    self.flagRunMoveCurrent=NO;
    self.flagRunScaleCurrent=NO;

}

#pragma mark-Randoms

-(CGPoint)randomPoint{
    CGPoint point;
    CGFloat minX=CGRectGetWidth(self.viewImage.bounds)/2;
    CGFloat minY=CGRectGetHeight(self.viewImage.bounds)/2;
    CGFloat maxX=CGRectGetMaxX(self.view.bounds)-CGRectGetWidth(self.viewImage.bounds);
    CGFloat maxY=CGRectGetMinY(self.imageSegmentControl.frame)-CGRectGetHeight(self.viewImage.bounds);
    point.x=minX + (CGFloat) (arc4random() % (int)maxX);
    point.y=minY + (CGFloat) (arc4random() % (int)maxY);
    return point;
}

-(CGFloat)randomFloatFromNumber:(CGFloat) firstNumber toNumber:(CGFloat) secondNumber{

    return  firstNumber + ( (CGFloat)  (     (arc4random()*100)     %     (int)(secondNumber*100)  )  ) /100;

}


#pragma mark- ChangeImage

- (IBAction)imadeSegmentControl:(UISegmentedControl *)sender {

    switch (self.imageSegmentControl.selectedSegmentIndex) {
        case 0:
            self.viewImage.image=self.cat1;
            NSLog(@"num=%lu",(unsigned long)sender.selectedSegmentIndex);
            break;
        case 1:
            self.viewImage.image=self.cat2;
            NSLog(@"num=%lu",(unsigned long)sender.selectedSegmentIndex);
            break;
        case 2:
            self.viewImage.image=self.cat3;
            NSLog(@"num=%lu",(unsigned long)sender.selectedSegmentIndex);
            break;
        case 3:
            self.viewImage.image=self.cat4;
            NSLog(@"num=%lu",(unsigned long)sender.selectedSegmentIndex);
        default:
            break;
    }
}

#pragma mark- MoveAnimation

-(void)animationMove: (CGFloat) speed andStartOrStop: (ChangeStatusAnimation) status{

    CGPoint point=(!self.flagMoveSenderSpeed==YES)?[self randomPoint]:self.pointCurrent;
    self.pointCurrent=point;

    CGFloat lengthMove = sqrt( pow(CGRectGetMidX(self.viewImage.layer.presentationLayer.frame)-point.x,2) + pow(CGRectGetMidY(self.viewImage.layer.presentationLayer.frame)-point.y,2));
    CGFloat timeAtLength=(1/speed)*lengthMove/200;

    if(status==ChangeStatusAnimationStart && self.flagRunMoveCurrent==NO){

        self.animationMove=[[UIViewPropertyAnimator alloc]initWithDuration:timeAtLength curve:UIViewAnimationCurveEaseInOut animations:^{
            self.viewImage.layer.position=point;
            self.flagRunMoveCurrent=YES;
        }];
        ViewController* __weak weakSelf = self;
        [self.animationMove addCompletion:^(UIViewAnimatingPosition finalPosition){
            if(finalPosition==UIViewAnimatingPositionEnd){
                weakSelf.flagRunMoveCurrent=NO;
                [weakSelf animationMove:weakSelf.speedSlider.value andStartOrStop:weakSelf.statusMove];
            }
        }];
        [self.animationMove startAnimation];
    }else{
        [self.animationMove stopAnimation:NO];
        [self.animationMove finishAnimationAtPosition:UIViewAnimatingPositionCurrent];
        self.animationMove=nil;
    }
}

#pragma mark-ScaleAnimation

-(void)animationScale: (CGFloat) speed andStartOrStop: (ChangeStatusAnimation) status{

    ViewController*weakSelf = self;

    CGFloat factorScale=(!self.flagMoveSenderSpeed==YES)?[self randomFloatFromNumber:0.5 toNumber:3]:self.scaleCurrent;
    self.scaleCurrent=factorScale;

    if(status==ChangeStatusAnimationStart && self.flagRunScaleCurrent==NO){
        CGFloat timeScale=(self.speedSlider.value>0.3)?self.speedSlider.value:self.speedSlider.value*5;
        self.animationScale=[[UIViewPropertyAnimator alloc]initWithDuration:0.5/timeScale curve:UIViewAnimationCurveEaseInOut animations:^{
            self.viewImage.transform=CGAffineTransformMakeScale(factorScale,factorScale);
            self.flagRunScaleCurrent=YES;
        }];
        [self.animationScale addCompletion:^(UIViewAnimatingPosition finalPosition){
            if(finalPosition==UIViewAnimatingPositionEnd){
                weakSelf.flagRunScaleCurrent=NO;
                [weakSelf animationScale:weakSelf.speedSlider.value andStartOrStop: weakSelf.statusScale];
            }
        }];

        [self.animationScale startAnimation];

    }else{
        [self.animationScale stopAnimation:NO];
        [self.animationScale finishAnimationAtPosition:UIViewAnimatingPositionCurrent];
        self.animationScale=nil;

    }

}

#pragma mark-RotatioAnimation

-(void)animationRotation: (CGFloat) speed andStartOrStop: (ChangeStatusAnimation) status{

    ViewController*weakSelf = self;

    CGFloat angleRotation=(!self.flagMoveSenderSpeed==YES)?[self randomFloatFromNumber:0 toNumber:M_PI*2]:self.rotationAngleCurrent;
    self.rotationAngleCurrent=angleRotation;

    if(status==ChangeStatusAnimationStart && self.flagRunRotationCurrent==NO){
        CGFloat timeRotation=(self.speedSlider.value>0.3)?self.speedSlider.value:self.speedSlider.value*5;
        self.animationRotation=[[UIViewPropertyAnimator alloc]initWithDuration:4/timeRotation curve:UIViewAnimationCurveEaseInOut animations:^{
            self.viewImage.transform=CGAffineTransformMakeRotation(angleRotation);
            self.flagRunRotationCurrent=YES;
        }];
        [self.animationRotation addCompletion:^(UIViewAnimatingPosition finalPosition){
            if(finalPosition==UIViewAnimatingPositionEnd){
                weakSelf.flagRunRotationCurrent=NO;
                [weakSelf animationRotation:weakSelf.speedSlider.value andStartOrStop: weakSelf.statusRotation];
            }
        }];

        [self.animationRotation startAnimation];

    }else{
        [self.animationRotation stopAnimation:NO];
        [self.animationRotation finishAnimationAtPosition:UIViewAnimatingPositionCurrent];
        self.animationRotation=nil;
    }

}

#pragma mark-Swiths

- (IBAction)moveSwith:(UISwitch *)sender {
    self.statusMove=(sender.isOn)?ChangeStatusAnimationStart:ChangeStatusAnimationStop;
    [self animationMove:self.speedSlider.value andStartOrStop:self.statusMove];
    self.flagRunMoveCurrent=NO;

}

- (IBAction)scaleSwith:(UISwitch *)sender {
    self.statusScale=(sender.isOn)?ChangeStatusAnimationStart:ChangeStatusAnimationStop;
    [self animationScale:self.speedSlider.value andStartOrStop:self.statusScale];
    self.flagRunScaleCurrent=NO;
}

- (IBAction)rotationSwith:(UISwitch *)sender {
    self.statusRotation=(sender.isOn)?ChangeStatusAnimationStart:ChangeStatusAnimationStop;
    [self animationRotation:self.speedSlider.value andStartOrStop:self.statusRotation];
    self.flagRunRotationCurrent=NO;

}

#pragma mark-SpeedSlider

- (IBAction)speedSlider:(UISlider *)sender {
  if(sender.isContinuous==YES)
        self.flagMoveSenderSpeed=YES;
    if(sender.value<0.001){
        [self.animationMove stopAnimation:NO];
        [self.animationMove finishAnimationAtPosition:UIViewAnimatingPositionCurrent];
        self.animationMove=nil;
    }else{
        self.flagRunMoveCurrent=NO;
        [self.animationMove stopAnimation:NO];
        [self.animationMove finishAnimationAtPosition:UIViewAnimatingPositionCurrent];
        self.animationMove=nil;
        [self animationMove:self.speedSlider.value andStartOrStop:self.statusMove];
    }
    self.flagMoveSenderSpeed=NO;

}


- (IBAction)speedSliderUpInside:(UISlider *)sender {

    self.flagMoveSenderSpeed=YES;
    if(sender.value<0.001){
         [self.animationScale stopAnimation:NO];
         [self.animationScale finishAnimationAtPosition:UIViewAnimatingPositionCurrent];
         self.animationScale=nil;

        [self.animationRotation stopAnimation:NO];
        [self.animationRotation finishAnimationAtPosition:UIViewAnimatingPositionCurrent];
        self.animationRotation=nil;

    }else{
         self.flagRunScaleCurrent=NO;
         [self.animationScale stopAnimation:NO];
         [self.animationScale finishAnimationAtPosition:UIViewAnimatingPositionCurrent];
         self.animationScale=nil;
         [self animationScale:self.speedSlider.value andStartOrStop:self.statusScale];

        self.flagRunRotationCurrent=NO;
        [self.animationRotation stopAnimation:NO];
        [self.animationRotation finishAnimationAtPosition:UIViewAnimatingPositionCurrent];
        self.animationRotation=nil;
        [self animationRotation:self.speedSlider.value andStartOrStop:self.statusRotation];

    }
    self.flagMoveSenderSpeed=NO;

}







- (IBAction)speedDidEndOnExit:(UISlider *)sender {
    NSLog(@"DONT1");
}

- (IBAction)speedEditingDidBegin:(UISlider *)sender {
     NSLog(@"DONT2");
}


- (IBAction)speedEditingDidEnd:(UISlider *)sender {

    NSLog(@"DONT3");

}

- (IBAction)speedTouchDragOutside:(UISlider *)sender {
     NSLog(@"speedTouchDragOutside");
}

@end
