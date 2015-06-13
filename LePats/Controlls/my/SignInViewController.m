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
#import "SignRecordViewController.h"

@interface SignInViewController ()<VRGCalendarViewDelegate>{
    VRGCalendarView *_calendar;
}
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
    [self initStatus];
}

-(void)initSelfView{
    self.title=@"签到";
    self.view.backgroundColor=[UIColor whiteColor];
    [self setRightHidden:NO];
    [self setRightTitle:@"记录"];
    __weak typeof (self)weakSelf = self;
    [self addRightEvent:^(id sender)
     {
         SignRecordViewController *add=[[SignRecordViewController alloc]init];
         [weakSelf.navigationController pushViewController:add animated:YES];
         
     }];
}

-(void)initCalendarView{
    
}

-(void)initStatus{
    
    UIScrollView *scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, [self barSize].height, self.view.width, self.view.height-[self barSize].height)];
    scrollView.contentSize=CGSizeMake(self.view.width, 700);
    
    VRGCalendarView *calendar = [[VRGCalendarView alloc] init];
    calendar.delegate=self;
    [scrollView addSubview:calendar];
    _calendar=calendar;
    
    UIView *content=[[UIView alloc]initWithFrame:CGRectMake(0, 360, self.view.width, 300)];
    
    UIButton *sign=[[UIButton alloc] initWithFrame:CGRectMake(10, 0, self.view.width-20, 40)];
    [sign setTitle:@"立即签到" forState:UIControlStateNormal];
    [sign addTarget:self action:@selector(sign:) forControlEvents:UIControlEventTouchUpInside];
    [sign setBackgroundColor:RGB(15,173,225)];
    [sign setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [sign.layer setMasksToBounds:YES];
    sign.layer.cornerRadius = 3.0f;
    [content addSubview:sign];
    
    UIView *alert=[[UIView alloc]initWithFrame:CGRectMake(20, sign.bottom+20, self.view.width-40, 40)];
    UILabel *cur=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, alert.width, 20)];
    cur.text=@"每日签到奖励积分: 10 ,您已连续签到 0 天";
    cur.font=[UIFont systemFontOfSize:14];
    [alert addSubview:cur];
    
    UILabel *contiune=[[UILabel alloc]initWithFrame:CGRectMake(0, cur.bottom+15, alert.width, 20)];
    contiune.text=@"连续签到奖励:";
    contiune.textColor=UIColorFromRGB(0x1b9bfb);
    contiune.font=[UIFont systemFontOfSize:14];
    [alert addSubview:contiune];
    
    UILabel *contiune1=[[UILabel alloc]initWithFrame:CGRectMake(20, contiune.bottom+10, alert.width, 20)];
    //contiune1.text=@"连续签到10天,额外奖励积分 20";
    contiune1.font=[UIFont systemFontOfSize:14];
    [alert addSubview:contiune1];
    NSMutableAttributedString *str1 = [[NSMutableAttributedString alloc] initWithString:@"连续签到10天,额外奖励积分 20"];
    [str1 addAttribute:NSForegroundColorAttributeName value:UIColorFromRGB(0x1b9bfb) range:NSMakeRange(4,2)];
    [str1 addAttribute:NSForegroundColorAttributeName value:UIColorFromRGB(0x1b9bfb) range:NSMakeRange(str1.length-2,2)];
    contiune1.attributedText=str1;
    
    UILabel *contiune2=[[UILabel alloc]initWithFrame:CGRectMake(20, contiune1.bottom+10, alert.width, 20)];
    //contiune2.text=@"连续签到20天,额外奖励积分 30";
    contiune2.font=[UIFont systemFontOfSize:14];
    [alert addSubview:contiune2];
    
    NSMutableAttributedString *str2 = [[NSMutableAttributedString alloc] initWithString:@"连续签到20天,额外奖励积分 30"];
    [str2 addAttribute:NSForegroundColorAttributeName value:UIColorFromRGB(0x1b9bfb) range:NSMakeRange(4,2)];
    [str2 addAttribute:NSForegroundColorAttributeName value:UIColorFromRGB(0x1b9bfb) range:NSMakeRange(str2.length-2,2)];
    contiune2.attributedText=str2;
    
    UILabel *contiune3=[[UILabel alloc]initWithFrame:CGRectMake(20, contiune2.bottom+10, alert.width, 20)];
    //contiune3.text=@"连续签到30天,额外奖励积分 40";
    contiune3.font=[UIFont systemFontOfSize:14];
    [alert addSubview:contiune3];
    
    NSMutableAttributedString *str3 = [[NSMutableAttributedString alloc] initWithString:@"连续签到30天,额外奖励积分 40"];
    [str3 addAttribute:NSForegroundColorAttributeName value:UIColorFromRGB(0x1b9bfb) range:NSMakeRange(4,2)];
    [str3 addAttribute:NSForegroundColorAttributeName value:UIColorFromRGB(0x1b9bfb) range:NSMakeRange(str3.length-2,2)];
    contiune3.attributedText=str3;
    
    UILabel *rule=[[UILabel alloc]initWithFrame:CGRectMake(0, contiune3.bottom+10, alert.width, 20)];
    rule.text=@"签到规则限制:";
    rule.font=[UIFont systemFontOfSize:14];
    rule.textColor=UIColorFromRGB(0x1b9bfb);
    [alert addSubview:rule];
    
    UILabel *rule1=[[UILabel alloc]initWithFrame:CGRectMake(20, rule.bottom+10, alert.width, 20)];
    rule1.text=@"每个用户,每个手机设备只能签到一个账号,";
    rule1.font=[UIFont systemFontOfSize:14];
    [alert addSubview:rule1];
    
    UILabel *rule2=[[UILabel alloc]initWithFrame:CGRectMake(20, rule1.bottom+10, alert.width, 20)];
    rule2.text=@"每个账号每个连续签到只能获得一次!";
    rule2.font=[UIFont systemFontOfSize:14];
    [alert addSubview:rule2];
    
    [content addSubview:alert];
    
    
    [scrollView addSubview:content];
    
    [self.view addSubview:scrollView];

}

-(void)sign:(UIButton *)aBtn{

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
