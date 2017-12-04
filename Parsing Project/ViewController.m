//
//  ViewController.m
//  Parsing Project
//
//  Created by Student-15 on 07/11/17.
//  Copyright (c) 2017 chaitali. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.myArray=[[NSMutableArray alloc ]init];
    NSString *urlPath=@"http://www.physics.leidenuniv.nl/json/news.php";
    NSURL *url=[NSURL URLWithString: urlPath];
    NSMutableURLRequest *request=[[NSMutableURLRequest alloc]initWithURL:url];
    [request setHTTPMethod:@"Get"];
    [NSURLConnection connectionWithRequest:request delegate:self];
    // Do any additional setup after loading the view, typically from a nib.
}
-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"\nConnection Failed:%@",error.localizedDescription);
    
}
-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    _myData=[[NSMutableData alloc]init];
    [_myData setLength:0];
}
-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [_myData appendData:data];
}
-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSMutableDictionary *mainDic=[NSJSONSerialization JSONObjectWithData:_myData options:NSJSONReadingAllowFragments error:nil];
    NSLog(@"MAin Dic is:%@",mainDic);
    NSArray *titleArray=[mainDic valueForKey:@"newsItems"];
    NSLog(@"\n Title Array is:%@",titleArray);
    for (NSDictionary *tempDic in titleArray) {
        NSString *tempTitle=[tempDic objectForKey:@"title"];
        [_myArray addObject:tempTitle];
    }
    NSLog(@"\n All titles in array:%@",_myArray);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
