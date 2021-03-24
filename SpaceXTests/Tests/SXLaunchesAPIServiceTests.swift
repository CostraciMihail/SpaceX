//
//  SpaceXTests.swift
//  SpaceXTests
//
//  Created by Mihail Costraci on 11/28/20.
//

import XCTest
import Combine
@testable import SpaceX

class SXLaunchesAPIServiceTests: XCTestCase {

    var cancelBag = Set<AnyCancellable>()
  
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        cancelBag = Set<AnyCancellable>()
    }

    func test_should_return_all_launches() throws {
      
      let urlSessioMock = SXURLSessionMock()
      let mockClient = SXAPIClientMock(urlSesssion: urlSessioMock)
      let service = SXLaunchesAPIService(client: mockClient)
      let reponseMock = HTTPURLResponseMock(url: SXLaunchesEndpoint.getAllPastLaunches.fullURL,
                                            statusCode: 200,
                                            bodyData: loadJSONData(name: "SpaceX-Launches"))!
      
      urlSessioMock.add(response: reponseMock)
      
      service
        .getAllPastLaunches()
        .sink { completion in
        
          if case .failure(let error) = completion {
            print("Failure with error: \(error)")
            XCTFail(error.localizedDescription)
          }
          
      } receiveValue: { allLaunches in
      
        XCTAssertEqual(allLaunches.count, 120)
      }.store(in: &cancelBag)

    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
