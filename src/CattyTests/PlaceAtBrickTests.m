/**
 *  Copyright (C) 2010-2013 The Catrobat Team
 *  (http://developer.catrobat.org/credits)
 *
 *  This program is free software: you can redistribute it and/or modify
 *  it under the terms of the GNU Affero General Public License as
 *  published by the Free Software Foundation, either version 3 of the
 *  License, or (at your option) any later version.
 *
 *  An additional term exception under section 7 of the GNU Affero
 *  General Public License, version 3, is available at
 *  (http://developer.catrobat.org/license_additional_term)
 *
 *  This program is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 *  GNU Affero General Public License for more details.
 *
 *  You should have received a copy of the GNU Affero General Public License
 *  along with this program.  If not, see http://www.gnu.org/licenses/.
 */

#import <XCTest/XCTest.h>
#import "BrickTests.h"

@interface PlaceAtBrickTests : BrickTests

@end

@implementation PlaceAtBrickTests

- (void)setUp
{
    [super setUp];
    // Put setup code here; it will be run once, before the first test case.
}

- (void)tearDown
{
    // Put teardown code here; it will be run once, after the last test case.
    [super tearDown];
}


-(void)testPlaceAtBrickPositiv
{
    
    SpriteObject* object = [[SpriteObject alloc] init];
    object.position = CGPointMake(0, 0);
    
    Scene* scene = [[Scene alloc] init];
    [scene addChild:object];
    
    Formula* yPosition =[[Formula alloc] init];
    FormulaElement* formulaTree  = [[FormulaElement alloc] init];
    formulaTree.type = NUMBER;
    formulaTree.value = @"20";
    yPosition.formulaTree = formulaTree;
    
    Formula* xPosition =[[Formula alloc] init];
    FormulaElement* formulaTree1  = [[FormulaElement alloc] init];
    formulaTree1.type = NUMBER;
    formulaTree1.value = @"20";
    xPosition.formulaTree = formulaTree1;
    
    
    PlaceAtBrick* brick = [[PlaceAtBrick alloc]init];
    brick.object = object;
    brick.yPosition = yPosition;
    brick.xPosition = xPosition;
    
    dispatch_block_t action = [brick actionBlock];
    action();
    
    CGPoint testPoint = CGPointMake(20, 20);
    XCTAssertEqual(object.position, testPoint, @"PlaceAtBrick is not correctly calculated");
}

-(void)testPlaceAtBrickNegativ
{
    
    SpriteObject* object = [[SpriteObject alloc] init];
    object.position = CGPointMake(0, 0);
    
    Scene* scene = [[Scene alloc] init];
    [scene addChild:object];
    
    Formula* yPosition =[[Formula alloc] init];
    FormulaElement* formulaTree  = [[FormulaElement alloc] init];
    formulaTree.type = NUMBER;
    formulaTree.value = @"-20";
    yPosition.formulaTree = formulaTree;
    
    Formula* xPosition =[[Formula alloc] init];
    FormulaElement* formulaTree1  = [[FormulaElement alloc] init];
    formulaTree1.type = NUMBER;
    formulaTree1.value = @"-20";
    xPosition.formulaTree = formulaTree1;
    
    
    PlaceAtBrick* brick = [[PlaceAtBrick alloc]init];
    brick.object = object;
    brick.yPosition = yPosition;
    brick.xPosition = xPosition;
    
    dispatch_block_t action = [brick actionBlock];
    action();
    
    CGPoint testPoint = CGPointMake(-20, -20);
    XCTAssertEqual(object.position, testPoint, @"PlaceAtBrick is not correctly calculated");
}

-(void)testPlaceAtBrickOutOfRange
{
    
    SpriteObject* object = [[SpriteObject alloc] init];
    object.position = CGPointMake(0, 0);
    
    Scene* scene = [[Scene alloc] init];
    [scene addChild:object];
    
    Formula* yPosition =[[Formula alloc] init];
    FormulaElement* formulaTree  = [[FormulaElement alloc] init];
    formulaTree.type = NUMBER;
    formulaTree.value = @"-20000";
    yPosition.formulaTree = formulaTree;
    
    Formula* xPosition =[[Formula alloc] init];
    FormulaElement* formulaTree1  = [[FormulaElement alloc] init];
    formulaTree1.type = NUMBER;
    formulaTree1.value = @"-20000";
    xPosition.formulaTree = formulaTree1;
    
    
    PlaceAtBrick* brick = [[PlaceAtBrick alloc]init];
    brick.object = object;
    brick.yPosition = yPosition;
    brick.xPosition = xPosition;
    
    dispatch_block_t action = [brick actionBlock];
    action();
    
    CGPoint testPoint = CGPointMake(-20000, -20000);
    XCTAssertEqual(object.position, testPoint, @"PlaceAtBrick is not correctly calculated");
}

-(void)testPlaceAtBrickWrongInput
{
    
    SpriteObject* object = [[SpriteObject alloc] init];
    object.position = CGPointMake(0, 0);
    
    Scene* scene = [[Scene alloc] init];
    [scene addChild:object];
    
    Formula* yPosition =[[Formula alloc] init];
    FormulaElement* formulaTree  = [[FormulaElement alloc] init];
    formulaTree.type = NUMBER;
    formulaTree.value = @"a";
    yPosition.formulaTree = formulaTree;
    
    Formula* xPosition =[[Formula alloc] init];
    FormulaElement* formulaTree1  = [[FormulaElement alloc] init];
    formulaTree1.type = NUMBER;
    formulaTree1.value = @"a";
    xPosition.formulaTree = formulaTree1;
    
    
    PlaceAtBrick* brick = [[PlaceAtBrick alloc]init];
    brick.object = object;
    brick.yPosition = yPosition;
    brick.xPosition = xPosition;
    
    dispatch_block_t action = [brick actionBlock];
    action();
    
    CGPoint testPoint = CGPointMake(0, 0);
    XCTAssertEqual(object.position, testPoint, @"PlaceAtBrick is not correctly calculated");
}

@end