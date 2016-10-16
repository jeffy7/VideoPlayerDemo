//
//  ViewController.m
//  VideoPlayerDemo
//
//  Created by je_ffy on 2016/10/16.
//  Copyright © 2016年 je_ffy. All rights reserved.
//

#import "ViewController.h"
#import "MediaPlayerViewController.h"
#import "JFAVPlayerViewController.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *dataArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"VideoDemo";
    self.dataArray = @[@"MediaPlayer",@"AVPlayer"];
    [self .tableView reloadData];
    // Do any additional setup after loading the view, typically from a nib.
}

- (UITableView *)tableView {
    if (!_tableView) {
        UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
        tableView.delegate = self;
        tableView.dataSource = self;
        [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
        [self.view addSubview:_tableView = tableView];
    }
    
    return _tableView;
}

#pragma mark -
#pragma mark - UITableViewDelegate && UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = _dataArray[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0: {
            UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
            MediaPlayerViewController *mediaPlayerVC = [story instantiateViewControllerWithIdentifier:@"MediaPlayerViewController"];
            [self.navigationController pushViewController:mediaPlayerVC animated:YES];

        }
            break;
        case 1: {
            UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
            JFAVPlayerViewController *AVPlayerVC = [story instantiateViewControllerWithIdentifier:@"JFAVPlayerViewController"];
            [self.navigationController pushViewController:AVPlayerVC animated:YES];
            
        }
            break;
            
        default:
            break;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
