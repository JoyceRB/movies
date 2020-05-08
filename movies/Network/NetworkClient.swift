//
//  NetworkClient.swift
//  movies
//
//  Created by Joyce Rosario Batista on 06/05/2020.
//  Copyright © 2020 Joyce Rosario Batista. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class NetworkClient {
    
    private var session: Session
    
    init() {
        if ProcessInfo.processInfo.environment["XCTestConfigurationFilePath"] != nil {
            let configuration = URLSessionConfiguration.af.default
            configuration.protocolClasses = [MockURLProtocol.self] + (configuration.protocolClasses ?? [])
            let sessionManager = Session(configuration: configuration)            
            self.session = sessionManager
        } else {
            self.session = Session.default
        }
    }

    func getPopularMovies(_ completionHandler: @escaping (_ results: JSON?) -> Void) {
        MockURLProtocol.requestHandler = { request in
            let data = MockedData.populaMoviesJSON.data
            let response = HTTPURLResponse.init(url: request.url!, statusCode: ResponseCode.success.intValue(), httpVersion: "2.0", headerFields: nil)!
            return (response, data)
        }
        _ = session.request(getPopularMoviesURL()).responseJSON { response in
           switch response.result {
            case .success:
                let dataJson = JSON(response.data!)
                if dataJson != JSON.null {
                    completionHandler(dataJson)
                }
            case let .failure(error):
                print(error)
            }
        }
    }
    
    func getMovieDetails(_ movieID: Int, _ completionHandler: @escaping (_ results: JSON?) -> Void) {
        _ = session.request(getMovieDetailsURL(movieID)).responseJSON { response in
           switch response.result {
            case .success:
                let dataJson = JSON(response.data!)
                if dataJson != JSON.null {
                    completionHandler(dataJson)
                }
            case let .failure(error):
                print(error)
            }
        }
    }
}
