//
//  UITableView+PPCategory.m
//  PPLibTest
//
//  Created by Paul Wang on 12-6-13.
//  Copyright (c) 2012年 pengjay.cn@gmail.com. All rights reserved.
//

#import "UITableView+PPCategory.h"
#import "UIWindow+PPCategory.h"
#import "UIView+PPCategory.h"

@implementation UITableView (PPCategory)
///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)scrollToTop:(BOOL)animated {
    [self setContentOffset:CGPointMake(0,0) animated:animated];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)scrollToBottom:(BOOL)animated {
    NSUInteger sectionCount = [self numberOfSections];
    if (sectionCount) {
        NSUInteger rowCount = [self numberOfRowsInSection:0];
        if (rowCount) {
            NSUInteger ii[2] = {0, rowCount-1};
            NSIndexPath* indexPath = [NSIndexPath indexPathWithIndexes:ii length:2];
            [self scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom
                                animated:animated];
        }
    }
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)scrollToFirstRow:(BOOL)animated {
    if ([self numberOfSections] > 0 && [self numberOfRowsInSection:0] > 0) {
        NSIndexPath* indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
        [self scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop
                            animated:animated];
    }
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)scrollToLastRow:(BOOL)animated {
    if ([self numberOfSections] > 0) {
        NSInteger section = [self numberOfSections]-1;
        NSInteger rowCount = [self numberOfRowsInSection:section];
        if (rowCount > 0) {
            NSIndexPath* indexPath = [NSIndexPath indexPathForRow:rowCount-1 inSection:section];
            [self scrollToRowAtIndexPath:indexPath
                        atScrollPosition:UITableViewScrollPositionBottom animated:NO];
        }
    }
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)scrollFirstResponderIntoView {
    UIView* responder = [self.window findFirstResponder];
    UITableViewCell* cell = (UITableViewCell*)[responder
                                               ancestorOrSelfWithClass:[UITableViewCell class]];
    if (cell) {
        NSIndexPath* indexPath = [self indexPathForCell:cell];
        if (indexPath) {
            [self scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionMiddle
                                animated:YES];
        }
    }
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)touchRowAtIndexPath:(NSIndexPath*)indexPath animated:(BOOL)animated {
    if (![self cellForRowAtIndexPath:indexPath]) {
        [self reloadData];
    }
    
    if ([self.delegate respondsToSelector:@selector(tableView:willSelectRowAtIndexPath:)]) {
        [self.delegate tableView:self willSelectRowAtIndexPath:indexPath];
    }
    
    [self selectRowAtIndexPath:indexPath animated:animated
                scrollPosition:UITableViewScrollPositionTop];
    
    if ([self.delegate respondsToSelector:@selector(tableView:didSelectRowAtIndexPath:)]) {
        [self.delegate tableView:self didSelectRowAtIndexPath:indexPath];
    }
}

@end
