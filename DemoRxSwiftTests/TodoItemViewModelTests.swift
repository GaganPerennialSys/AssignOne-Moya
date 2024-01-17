//
//  TOdoItemViewModelTests.swift
//  DemoRxSwiftTests
//
import XCTest
import RxSwift
@testable import DemoRxSwift // Import your app module
import CoreData

class TodoItemViewModelTests: XCTestCase {
    
    var viewModel: TodoItemViewModel!
    
    override func setUp() {
        super.setUp()
        viewModel = TodoItemViewModel()
    }

    override func tearDown() {
        super.tearDown()
        clearCoreData()
    }

    func clearCoreData() {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "User")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        _ = try? CoreDataStack.shared.persistentContainer.persistentStoreCoordinator.execute(deleteRequest, with: CoreDataStack.shared.context)
    }

    func testAddTodoItem() {
        // Given
        viewModel.setLoggedInUsername("Admin")

        // When
        viewModel.addTodoItem(title: "Test Todo", descriptionText: "Test Description", dateTime: Date())

        // Then
        let todoItems =  viewModel.todoItems.value
        XCTAssertEqual(todoItems.count, 1)
    }

  

    func testUpdateTodoItem() {
        // Given
        viewModel.setLoggedInUsername("Admin")
        viewModel.addTodoItem(title: "Test Todo", descriptionText: "Test Description", dateTime: Date())

        // When
        viewModel.updateTodoItem(at: 0, withTitle: "Updated Todo", descriptionText: "Updated Description", dateTime: Date())

        // Then
        let todoItems = viewModel.todoItems.value
        XCTAssertEqual(todoItems.count, 1)
        XCTAssertEqual(todoItems[0].title, "Updated Todo")
        XCTAssertEqual(todoItems[0].discription, "Updated Description")
    }
    
    func testDeleteTodoItem() {
        // Given
        viewModel.setLoggedInUsername("Admin")
        viewModel.addTodoItem(title: "Test Todo", descriptionText: "Test Description", dateTime: Date())

        // When
        viewModel.deleteTodoItem(at: 0)

        // Then
        let todoItems = viewModel.todoItems.value
        XCTAssertEqual(todoItems.count, 0)
    }
}
