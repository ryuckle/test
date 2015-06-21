//
//  TableSectionTapVC.m
//  TabieSectionTapView
//
//  Created by 小川竜太 on 2015/06/19.
//  Copyright (c) 2015年 Ryuta Ogawa. All rights reserved.
//

#import "TableSectionTapVC.h"
#import "SessionViewController.h"
#import "PagingScrollView.h"



@interface TableSectionTapVC () <UITableViewDataSource, UITableViewDelegate, ScrollMenuBarDelegate>
@property (weak, nonatomic) IBOutlet UITableView *aTableView;
@property (nonatomic, retain) NSArray *sessionItems;
@property (nonatomic, retain) NSArray *subjectItems;
@property ScrollMenuBar *scrollMenuBar;
@property NSArray *pageTitles;

@end

static const float HEADER_HEIGHT = 80.0f;
static const float STATUS_BAR_HEIGHT = 20.0f;
static const float SCROLL_MENU_BAR_HEIGHT = 40.0f;
#define NUMBER_OF_TABLES  6
#define TAG_BASE 110
#define TAG_OFFSET  10

@implementation TableSectionTapVC {
    PagingScrollView *pagingScrollView;
    CGPoint _lastContentOffset;
    NSMutableArray *_categorizedArticlesArray;
    NSInteger _indexOfTab;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self reloadTableView];
    
//    [self.aTableView setDataSource:self];
//    [self.aTableView setDelegate:self];
    self.aTableView.separatorColor = [UIColor grayColor];
    _sessionItems = @[@"セッション1", @"セッション2", @"セッション3", @"セッション4"];
    _subjectItems = @[@"講演1", @"講演2", @"講演3", @"講演4"];
    

    
    // Do any additional setup after loading the view from its nib.
}


- (void)viewWillAppear:(BOOL)animated {
    [self loadPagingScrollView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _sessionItems.count;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _subjectItems.count + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    // セルが作成されていないか?
    if (!cell) { // yes
        // セルを作成
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    if (indexPath.row == 0) {
        cell.textLabel.text = _sessionItems[indexPath.section];
        
        // Remove seperator inset
        if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
            [cell setSeparatorInset:UIEdgeInsetsZero];
        }
        
        // Prevent the cell from inheriting the Table View's margin settings
        if ([cell respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)]) {
            [cell setPreservesSuperviewLayoutMargins:NO];
        }
        
        // Explictly set your cell's layout margins
        if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
            [cell setLayoutMargins:UIEdgeInsetsZero];
        }
    
    }else {
        cell.textLabel.text = _subjectItems[indexPath.row-1];
    }
    
    // セルにテキストを設定
    // セルの内容はNSArray型の「items」にセットされているものとする
    
    
    return cell;
}

- (void)reloadTableView {
    for(UIView *view in [pagingScrollView subviews]){
        if([view isKindOfClass:[UITableView class]]){
            UITableView *tableView = (UITableView*)view;
            tableView.delegate = self;
            tableView.dataSource = self;
            [tableView reloadData];
        }
    }
}


#pragma mark - PagingScrollView

-(void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView
{
    _lastContentOffset = scrollView.contentOffset;
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    
    //when you scroll vertically, you can't move tab index
    if (_lastContentOffset.y > scrollView.contentOffset.y || _lastContentOffset.y < scrollView.contentOffset.y){
        return;
    }
    
    _indexOfTab = scrollView.contentOffset.x / scrollView.frame.size.width;
    
    //activate tab programatically
    [_scrollMenuBar activateTabMenuWithIndex:_indexOfTab];
    
}

- (void)loadPagingScrollView
{
    
    float tableWidth = self.view.bounds.size.width;
    
    CGFloat height = self.view.bounds.size.height;
    CGRect tableBounds = CGRectMake(0.0f, 0.0f, tableWidth, CGRectGetHeight(self.view.bounds));
    
    pagingScrollView = [[PagingScrollView alloc] initWithFrame:CGRectMake(0,0,self.view.bounds.size.width, self.view.bounds.size.height)];
    pagingScrollView.delegate = self;
    
    pagingScrollView.contentSize = CGSizeMake(tableWidth * NUMBER_OF_TABLES, height);
    pagingScrollView.pagingEnabled = YES;
    pagingScrollView.bounds = tableBounds; // scrollViewのページングをtableWidth単位に。
    pagingScrollView.clipsToBounds = NO;   // 非表示になっているtableBounds外を表示。
    pagingScrollView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:pagingScrollView];
    
    // tableViewを横に並べる
    CGRect tableFrame = tableBounds;
    
    tableFrame.origin.x = 0.f;
    tableFrame.origin.y = (STATUS_BAR_HEIGHT + HEADER_HEIGHT);
    tableFrame.size.height = tableBounds.size.height - (STATUS_BAR_HEIGHT + HEADER_HEIGHT);
    
    //align multiple tableviews
    for (int i = 0; i < NUMBER_OF_TABLES; i++) {
        
        UITableView *tableView = [[UITableView alloc] initWithFrame:tableFrame style:UITableViewStylePlain];
        //        [tableView registerClass:[ArticleTableViewCell class] forCellReuseIdentifier:@"ArticleTableViewCell"];
        UINib *cellNib = [UINib nibWithNibName:@"ArticleTableViewCell" bundle:nil];
        [tableView registerNib:cellNib forCellReuseIdentifier:@"ArticleTableViewCell"];
        
        //TODO refactor
        tableView.backgroundColor = [UIColor whiteColor];
        tableView.tag = (TAG_BASE + TAG_OFFSET * i);
        
        [pagingScrollView addSubview:tableView];
        
        tableFrame.origin.x += tableWidth;
    }
    
    // Create the data model
    _pageTitles = @[@"Rails", @"iOS", @"Android", @"プロセス", @"インフラ", @"キャリア"];
    
    // メニューバー追加
    NSArray *menus = [self setupMenus];
    _scrollMenuBar = [[ScrollMenuBar alloc] initWithArray:menus point:CGPointMake(0, (STATUS_BAR_HEIGHT+ SCROLL_MENU_BAR_HEIGHT))] ;
    
    
    _scrollMenuBar.delegate = self ;
    [self.view addSubview:_scrollMenuBar];
    
    
}

/*
* create elements of menu bar
*/

- (NSArray *)setupMenus {
    return @[
             @{
                 @"title":@"Rails",
                 @"color":[ScrollMenuBar smartGreen]
                 }, @{
                 @"title":@"iOS",
                 @"color":[ScrollMenuBar smartRed]
                 }, @{
                 @"title":@"Android",
                 @"color":[ScrollMenuBar smartBlue]
                 }, @{
                 @"title":@"プロセス",
                 @"color":[ScrollMenuBar smartOrange]
                 }, @{
                 @"title":@"インフラ",
                 @"color":[ScrollMenuBar smartPurple]
                 }, @{
                 @"title":@"キャリア",
                 @"color":[ScrollMenuBar smartGray]
                 },
             ] ;
    
}

/**
 * セルが選択されたとき
 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        NSLog(@"セッション%luが選択されました", indexPath.section);
        SessionViewController *vc = [[SessionViewController alloc] initWithNibName:@"SessionViewController" bundle:nil];
        vc.sessionNum = indexPath.section;
        [self presentViewController:vc animated:YES completion:nil];
    }else {
        NSLog(@"講演%luが選択されました", indexPath.row);
    }
//    NSLog(@"「%@」が選択されました", [dataSource objectAtIndex:indexPath.row]);
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [cell setClipsToBounds:YES];
    
    float cornerSize = 11.0; // change this if necessary
    
    // round all corners if there is only 1 cell
    if (indexPath.row == 0 && [_subjectItems count] == 1) {
        UIBezierPath *maskPath;
        maskPath = [UIBezierPath bezierPathWithRoundedRect:cell.bounds byRoundingCorners:(UIRectCornerTopLeft | UIRectCornerTopRight | UIRectCornerBottomLeft | UIRectCornerBottomRight) cornerRadii:CGSizeMake(cornerSize, cornerSize)];
        
        CAShapeLayer *mlayer = [[CAShapeLayer alloc] init];
        mlayer.frame = cell.bounds;
        mlayer.path = maskPath.CGPath;
        cell.layer.mask = mlayer;
    }
    
    // round only top cell and only top-left and top-right corners
    else if (indexPath.row == 0) {
        UIBezierPath *maskPath;
        maskPath = [UIBezierPath bezierPathWithRoundedRect:cell.bounds byRoundingCorners:(UIRectCornerTopLeft | UIRectCornerTopRight) cornerRadii:CGSizeMake(cornerSize, cornerSize)];
        
        CAShapeLayer *mlayer = [[CAShapeLayer alloc] init];
        mlayer.frame = cell.bounds;
        mlayer.path = maskPath.CGPath;
        cell.layer.mask = mlayer;
    }
    
    // round bottom-most cell of group and only bottom-left and bottom-right corners
    else if (indexPath.row == [_subjectItems count]) {
        UIBezierPath *maskPath;
        maskPath = [UIBezierPath bezierPathWithRoundedRect:cell.bounds byRoundingCorners:(UIRectCornerBottomLeft | UIRectCornerBottomRight) cornerRadii:CGSizeMake(cornerSize, cornerSize)];
        
        CAShapeLayer *mlayer = [[CAShapeLayer alloc] init];
        mlayer.frame = cell.bounds;
        mlayer.path = maskPath.CGPath;
        cell.layer.mask = mlayer;
        
    }
    
    
    
}

#pragma mark - UITableViewDelegate
-(CGFloat)tableView:(UITableView *)tableView
heightForHeaderInSection:(NSInteger)section {
    return 5.0f;
}

#pragma mark - ScrollMenuBarDelegate
- (void)scrollMenuBar:(ScrollMenuBar *)scrollMenuBar selected:(NSInteger)selectedIndex
{
    int tabIndex = [_scrollMenuBar selectedIndex];
    float viewWidth = CGRectGetWidth(self.view.bounds);
    
    [pagingScrollView setContentOffset:CGPointMake(tabIndex * viewWidth, 0)];
    
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
