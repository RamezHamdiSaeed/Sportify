//
//  SportifyTests.swift
//  SportifyTests
//
//  Created by Hadir on 30/04/2024.
//

import XCTest
@testable import Sportify

final class SportifyTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testGetLeagues(){
        let expectation = expectation(description: "Waiting for api")
        
        RemoteDataSourceImpl.getLeagues(of: .football){
            result in
            switch result {
            case .success(let success):
                XCTAssertNotNil(success, "Response is nil")
            case .failure(let failure):
                XCTFail()
            }
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 10)
    }
    
    func testGetEvents(){
        let expectation = expectation(description: "Waiting for api")
        
        RemoteDataSourceImpl.getEvents(of: .football, from: "2021-12-01", to: "2024-04-01", for: "177"){
            result in
            switch result {
            case .success(let success):
                XCTAssertNotNil(success, "Response is nil")
            case .failure(let failure):
                XCTFail()
            }
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 10)
    }
    
    func testGetTeams(){
        let expectation = expectation(description: "Waiting for api")
        
        RemoteDataSourceImpl.getTeams(of: .football, for: "205"){
            result in
            switch result {
            case .success(let success):
                XCTAssertNotNil(success, "Response is nil")
            case .failure(let failure):
                XCTFail()
            }
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 10)
    }

    func testGetPlayers(){
        let expectation = expectation(description: "Waiting for api")
        
        RemoteDataSourceImpl.getPlayers(of: .football, for: "96"){
            result in
            switch result {
            case .success(let success):
                XCTAssertNotNil(success, "Response is nil")
            case .failure(let failure):
                XCTFail()
            }
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 10)
    }
}
