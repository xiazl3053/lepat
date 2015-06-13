//
//  SignInViewController.m
//  LePats
//
//  Created by admin on 15/6/12.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import "SignInViewController.h"
#import "VRGCalendarView.h"
#import "NSDate+convenience.h"

@interface SignInViewController ()<VRGCalendarViewDelegate>

@end

@implementation SignInViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self initViews];
   
    
    
    
}

-(void)initViews{
    [self initSelfView];
    [self initCalendarView];
}

-(void)initSelfView{
    self.title=@"我的签到";
    self.view.backgroundColor=[UIColor whiteColor];
}

-(void)initCalendarView{
    VRGCalendarView *calendar = [[VRGCalendarView alloc] init];
    calendar.delegate=self;
    [self.view addSubview:calendar];
}

-(void)calendarView:(VRGCalendarView *)calendarView switchedToMonth:(int)month targetHeight:(float)targetHeight animated:(BOOL)animated {
    if (month==[[NSDate date] month]) {
        NSArray *dates = [NSArray arrayWithObjects:[NSNumber numberWithInt:1],[NSNumber numberWithInt:10], nil];
        [calendarView markDates:dates];
    }else{
        NSArray *dates = [NSArray arrayWithObjects:[NSNumber numberWithInt:2],[NSNumber numberWithInt:3], nil];
        [calendarView markDates:dates];
    }
}

-(void)calendarView:(VRGCalendarView *)calendarView dateSelected:(NSDate *)date {
    NSLog(@"Selected date = %@",date);
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
