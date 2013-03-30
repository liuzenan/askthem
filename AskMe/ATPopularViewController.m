//
//  ATPopularViewController.m
//  AskMe
//
//  Created by Zenan on 29/3/13.
//  Copyright (c) 2013 nus.cs3217. All rights reserved.
//

#import "ATPopularViewController.h"
#import "ATQuestionViewController.h"
#import "ATNewQuestionViewController.h"
#import "PopularCell.h"

@interface ATPopularViewController ()

@end

@implementation ATPopularViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{

    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    [self setNavigationBar];
    
//    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectInfinite];
//    titleLabel.backgroundColor = [UIColor clearColor];
//    titleLabel.text = @"POPULAR";
//    titleLabel.font = [UIFont fontWithName:@"ProximaNova-Semibold" size:18.0f];
//    [titleLabel sizeToFit];
//    titleLabel.textColor = [UIColor whiteColor];
//    self.navigationItem.titleView = titleLabel;
    
    self.navigationItem.title = @"POPULAR";
}

-(void)selectGender
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)setNavigationBar
{
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(0, 0, 49, 49);
    backButton.backgroundColor = [UIColor clearColor];
    UIImage *backBtnImage = [UIImage imageNamed:@"homebtn"];
    [backButton setBackgroundImage:backBtnImage forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(selectGender) forControlEvents:UIControlEventTouchUpInside];
    backButton.backgroundColor = [UIColor clearColor];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:backButton];
    
    UIButton *createNew = [UIButton buttonWithType:UIButtonTypeCustom];
    createNew.frame = CGRectMake(0, 0, 49, 49);
    createNew.backgroundColor = [UIColor clearColor];
    UIImage *createNewImage = [UIImage imageNamed:@"postbtn"];
    [createNew setBackgroundImage:createNewImage forState:UIControlStateNormal];
    [createNew addTarget:self action:@selector(createNewQuestion) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:createNew];
}

-(void)viewDidAppear:(BOOL)animated{
    
    
    [[ATQuestionController shared] getPopularQuestions:^(NSArray *objects, NSError *error) {
        self.popularQuestions = objects;

        [self.tableView reloadData];
        [self setNavigationBar];
    }];
    
    //[self createNewQuestion];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) createNewQuestion
{
    ATNewQuestionViewController *newQuestion = [[UIStoryboard storyboardWithName:STORYBOARD_IPHONE bundle:nil] instantiateViewControllerWithIdentifier:@"AskQuestion"];
    [self.navigationController pushViewController:newQuestion animated:YES];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    // Return the number of rows in the section.
    return [self.popularQuestions count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"PopularQuestionCell";
    PopularCell *cell = (PopularCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"PopularCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    PFObject *question = [self.popularQuestions objectAtIndex:indexPath.row];

    NSString *title = [question objectForKey:kATQuestionTitleKey];
    cell.titleLabel.text = title;
    cell.titleLabel.font = [UIFont fontWithName:@"ProximaNova-Bold" size:16.0f];
    [cell.titleLabel sizeToFit];
    
    NSString *body = [question objectForKey:kATQuestionBodyKey];
    cell.bodyLabel.text = body;
    cell.bodyLabel.font = [UIFont fontWithName:@"ProximaNova-Regular" size:16.0f];
    cell.bodyLabel.textColor = [UIColor darkGrayColor];
    cell.bodyLabel.lineBreakMode = NSLineBreakByWordWrapping;
    cell.bodyLabel.numberOfLines = 3;
    //Calculate the expected size based on the font and linebreak mode of your label
    // FLT_MAX here simply means no constraint in height
    CGSize maximumLabelSize = CGSizeMake(296, FLT_MAX);
    CGSize expectedLabelSize = [body sizeWithFont:cell.bodyLabel.font constrainedToSize:maximumLabelSize lineBreakMode:cell.bodyLabel.lineBreakMode];
    CGRect newFrame = cell.bodyLabel.frame;
    newFrame.size.height = expectedLabelSize.height;
    cell.bodyLabel.frame = newFrame;
    
    
    cell.timeLabel.text = @"5 days ago";
    cell.timeLabel.font = [UIFont fontWithName:@"ProximaNova-Regular" size:16.0f];
    cell.timeLabel.textColor = [UIColor grayColor];
    cell.timeLabel.textAlignment = NSTextAlignmentRight;
    [cell.timeLabel sizeToFit];
    // Configure the cell...
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PFObject *question = [self.popularQuestions objectAtIndex:indexPath.row];
    NSString *body = [question objectForKey:kATQuestionBodyKey];
    CGSize constraintSize = {245.0, 65};
    CGSize neededSize = [body sizeWithFont:[UIFont systemFontOfSize:16.0f] constrainedToSize:constraintSize lineBreakMode:UILineBreakModeCharacterWrap];
    if ( neededSize.height <= 18){
        return 45;
    }else{
        return neededSize.height + 45; 
    }
        
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    ATQuestionViewController *singleQuestionViewController = [[UIStoryboard storyboardWithName:STORYBOARD_IPHONE bundle:nil] instantiateViewControllerWithIdentifier:@"SingleQuestion"];
     // Pass the selected object to the new view controller.
    PFObject *question = [self.popularQuestions objectAtIndex:indexPath.row];
    singleQuestionViewController.questionID = question.objectId;
    [self.navigationController pushViewController:singleQuestionViewController animated:YES];
}

- (void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    
    [super viewWillDisappear:animated];
}

@end
