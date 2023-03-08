//
//  StoreLabTests.swift
//  StoreLabTests
//
//  Created by tzh on 08/03/2023.
//

import XCTest
@testable import StoreLab
import RxSwift

final class StoreLabTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    func testEndpointsURL() {
    
        let endpointURL = APIEndpoints.getPictureList(1, 25).url()
        let expectedURL = "https://picsum.photos/v2/list?limit=25&page=1"
                
        XCTAssert(endpointURL == expectedURL)
        
    }
    func testPictureListAPI() throws {
        let exp = expectation(description: "pictures")
        let viewModel = PictureListVM()
        viewModel.getPictures(page: 1, limit: 25)
            .observeOn(MainScheduler.instance)
            .subscribe { event in
                if viewModel.pictures?.count ?? 0 > 0 {
                        exp.fulfill()
                }
        }
        waitForExpectations(timeout: 3, handler: nil)
    }
}
