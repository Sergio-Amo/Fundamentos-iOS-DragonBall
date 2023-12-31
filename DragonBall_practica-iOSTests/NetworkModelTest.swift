//
//  NetworkModelTest.swift
//  DragonBall_practica-iOSTests
//
//  Created by Sergio Amo on 1/10/23.
//

import XCTest

@testable import DragonBall_practica_iOS

final class NetworkModelTests: XCTestCase {
    private var sut: NetworkModel!
    
    override func setUp() {
        super.setUp()
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [MockURLProtocol.self]
        let session = URLSession(configuration: configuration)
        sut = NetworkModel(session: session)
    }
    
    override func tearDown() {
        super.tearDown()
        sut = nil
    }
    
    func testLogin() {
        let expectedToken = "Some Token"
        let someUser = "SomeUser"
        let somePassword = "SomePassword"
        
        MockURLProtocol.requestHandler = { request in
            let loginString = String(format: "%@:%@", someUser, somePassword)
            let loginData = loginString.data(using: .utf8)!
            let base64LogingString = loginData.base64EncodedString()
            
            XCTAssertEqual(request.httpMethod, "POST")
            XCTAssertEqual(
                request.value(forHTTPHeaderField: "Authorization"),
                "Basic \(base64LogingString)"
            )
            
            let data = try XCTUnwrap(expectedToken.data(using: .utf8))
            let response = try XCTUnwrap(
                HTTPURLResponse(
                    url: URL(string: "https://dragonball.keepcoding.education")!,
                    statusCode: 200,
                    httpVersion: nil,
                    headerFields: ["Content-Type": "application/json"]
                )
            )
            return (response, data)
        }
        
        let expectation = expectation(description: "Login success")
        
        sut.login(
            user: someUser,
            password: somePassword
        ) { result in
            guard case let .success(token) = result else {
                XCTFail("Expected success but received \(result)")
                return
            }
            
            XCTAssertEqual(token, expectedToken)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1)
    }
    
    func testGetHeroes() {
        let hero1 = Hero(id: "SomeID", name: "hero1", description: "hero1Desc", photo: URL(string: "http://someUrl.com")!, favorite: false)
        let hero2 = Hero(id: "SomeID2", name: "hero2", description: "hero2Desc", photo: URL(string: "http://someUrl2.com")!, favorite: false)
        let expectedResponse: [Hero] = [hero1,hero2]
        let jsonHeros = """
        [
            {
                "id": "SomeID",
                "photo": "http://someUrl.com",
                "favorite": false,
                "description": "hero1Desc",
                "name": "hero1"
            },
            {
                "id": "SomeID2",
                "photo": "http://someUrl2.com",
                "favorite": false,
                "description": "hero2Desc",
                "name": "hero2"
            }
        ]
        """
        
        let token = "Some Token"
        
        MockURLProtocol.requestHandler = { request in
            
            var components = URLComponents()
            components.scheme = "https"
            components.host = "dragonball.keepcoding.education"
            components.path = "/api/heros/all"
            let url = components.url
                        
            var urlComponents = URLComponents()
            urlComponents.queryItems = [URLQueryItem(name: "name", value: "")]
            
            XCTAssertEqual(request.httpMethod, "POST")
            XCTAssertEqual(
                request.value(forHTTPHeaderField: "Authorization"),
                "Bearer \(token)"
            )
            
            let data = try XCTUnwrap(jsonHeros.data(using: .utf8))
            let response = try XCTUnwrap(
                HTTPURLResponse(
                    url: url!,
                    statusCode: 200,
                    httpVersion: nil,
                    headerFields: ["Content-Type": "application/json"]
                )
            )
            return (response, data)
        }
        
        let expectation = expectation(description: "getHeroes success")
        
        sut.getHeroes() { result in
            guard case let .success(responseGiven) = result else {
                XCTFail("Expected success but received \(result)")
                return
            }
            
            XCTAssertEqual(responseGiven, expectedResponse)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1)
    }
}

// TODO: TestGetTransformations

// OHHTTPStubs
final class MockURLProtocol: URLProtocol {
    static var error: NetworkModel.NetworkError?
    static var requestHandler: ((URLRequest) throws -> (HTTPURLResponse, Data))?
    
    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }
    
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }
    
    override func startLoading() {
        if let error = MockURLProtocol.error {
            client?.urlProtocol(self, didFailWithError: error)
            return
        }
        
        guard let handler = MockURLProtocol.requestHandler else {
            assertionFailure("Received unexpected request with no handler")
            return
        }
        
        do {
            let (response, data) = try handler(request)
            client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
            client?.urlProtocol(self, didLoad: data)
            client?.urlProtocolDidFinishLoading(self)
        } catch {
            client?.urlProtocol(self, didFailWithError: error)
        }
    }
    
    override func stopLoading() { }
}
