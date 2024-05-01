//
//  MockingNetworkTest.swift
//  SportifyTests
//
//  Created by Hadir on 30/04/2024.
//

import XCTest
@testable import Sportify

final class MockingNetworkTest: XCTestCase {
    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {

    }
    func testgetLeagues(){
        MockedRemoteDataSource.getLeagues(of: .football){
            result in
            switch result {
            case .success(let response):
                XCTAssertTrue(response.success == 1)
            case .failure(let failure):
                print(failure.localizedDescription)
                XCTFail()
            }
        }
    }
    
    func testgetEvents(){
        MockedRemoteDataSource.getEvents(of: .football, from: "2018-05-23", to: "2018-05-23", for: "812"){
            result in
            switch result {
            case .success(let response):
                XCTAssertTrue(response.success == 1)
            case .failure(let failure):
                print(failure.localizedDescription)
                XCTFail()
            }
        }
    }
//    var networkService : MockedNetworkService? = nil
//
//    override func setUpWithError() throws {
//        networkService = MockedNetworkService(isError: false)
//    }
//
//    override func tearDownWithError() throws {
//        networkService = nil
//    }
//
//    // when network available
//    func testfetchPostsNetworkAvailable() throws {
//        networkService!.fetchPosts(){
//            response in
//            print(response)
//             XCTAssertNotNil(response)
//
//        }
//
//    }
//
//    // when network notAvailable
//    func testfetchPostsNetworkNotAvailable() throws {
//        networkService!.isError = true
//        networkService!.fetchPosts(){
//            response in
//            print(response)
//                XCTAssertNil(response)
//
//        }
//
//    }
//


  

}
