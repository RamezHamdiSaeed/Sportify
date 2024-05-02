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
    func testGetLeagues(){
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
    
    func testGetEvents(){
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

    
    func testGetTeams(){
        MockedRemoteDataSource.getTeams(of: .football, for: "177"){result in
            switch result {
            case .success(let response):
               XCTAssertNotNil(response)
            case .failure(let failure):
                print(failure.localizedDescription)
                XCTFail()
            }
        }
    }

    
    func testGetPlayers(){
        MockedRemoteDataSource.getPlayers(of: .football, for: "4281"){
            result in
            switch result {
            case .success(let response):
               XCTAssertNotNil(response)
            case .failure(let failure):
                print(failure.localizedDescription)
                XCTFail()
            }
        }
    }

    
  

}
