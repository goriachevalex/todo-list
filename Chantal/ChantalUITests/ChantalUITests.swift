//
//  ChantalUITests.swift
//  ChantalUITests
//
//  Created by Alexander Goriachev on 30.05.2024.
//  Copyright © 2024 Monte Thakkar. All rights reserved.
//

import XCTest

final class ChantalUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testAddTaskToTodoList() throws {
        
        let app = XCUIApplication()
        
        //Шаг 1: Перейти на Главную
        app.launch()
        //Шаг 2: Тап по “+”
        app.navigationBars.buttons["Add"].tap()
        //открылся алерт для ввода задачи
        XCTAssertTrue(app.alerts.textFields["Enter task name..."].exists)
        //Шаг 3: ввести название задачи
        app.alerts.textFields["Enter task name..."].tap()
        app.alerts.textFields["Enter task name..."].typeText("New task")
        //Шаг 4: тап по кнопке добавления в алерте
        app.alerts.buttons["Add"].tap()
        //алерт ввода задачи закрылся
        XCTAssertFalse(app.alerts.element.exists)
        //введенная задача отображается в списке
        XCTAssertTrue(app.cells.staticTexts["New task"].exists)
    }
    
    func testMarkTaskAsDone() throws {
        
        let app = XCUIApplication()
        
        //подготовка + шаг 1
        app.launch()
        app.navigationBars.buttons["Add"].tap()
        app.alerts.textFields["Enter task name..."].tap()
        app.alerts.textFields["Enter task name..."].typeText("New task")
        app.alerts.buttons["Add"].tap()
        //Шаг 2: Свайпнуть задачу слева направо
        app.tables.staticTexts["New task"].swipeRight()
        app.tables.buttons["done"].tap()
        //проверяем что таска перешла в Done - не нашёл как проверить
        
    }
    
    func testDeleteTaskFromTodoList() throws {
        
        let app = XCUIApplication()
        
        //подготовка + шаг 1
        app.launch()
        app.navigationBars.buttons["Add"].tap()
        app.alerts.textFields["Enter task name..."].tap()
        app.alerts.textFields["Enter task name..."].typeText("New task")
        app.alerts.buttons["Add"].tap()
        //Шаг 2: Свайпнуть задачу справа налево
        app.tables.staticTexts["New task"].swipeLeft()
        app.tables.buttons["delete"].tap()
        //проверяем что таска удалена
        XCTAssertFalse(app.cells.staticTexts["New task"].exists)
        
    }
    
    func testDeleteTaskFromDoneList() throws {
        
        let app = XCUIApplication()
        
        //подготовка + шаг 1
        app.launch()
        app.navigationBars.buttons["Add"].tap()
        app.alerts.textFields["Enter task name..."].tap()
        app.alerts.textFields["Enter task name..."].typeText("New task")
        app.alerts.buttons["Add"].tap()
        app.tables.staticTexts["New task"].swipeRight()
        app.tables.buttons["done"].tap()
        //Шаг 2: Свайпнуть задачу справа налево
        app.tables.staticTexts["New task"].swipeLeft()
        app.tables.buttons["delete"].tap()
        //проверяем что таска удалена
        XCTAssertFalse(app.cells.staticTexts["New task"].exists)
    }
    
    func testMarkDoneTaskAsDone() throws {
        
        let app = XCUIApplication()
        
        //подготовка + шаг 1
        app.launch()
        app.navigationBars.buttons["Add"].tap()
        app.alerts.textFields["Enter task name..."].tap()
        app.alerts.textFields["Enter task name..."].typeText("New task")
        app.alerts.buttons["Add"].tap()
        app.tables.staticTexts["New task"].swipeRight()
        app.tables.buttons["done"].tap()
        //Шаг 2: Свайпнуть задачу слева направо
        app.tables.staticTexts["New task"].swipeRight()
        // проверяем что таска всё ещё есть
        XCTAssertTrue(app.cells.staticTexts["New task"].exists)
        
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
