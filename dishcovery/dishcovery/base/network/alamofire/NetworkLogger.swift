//
//  NetworkLogger.swift
//  dishcovery
//
//  Created by Vu Nguyen on 1/15/25.
//

import Foundation
import Alamofire

final class NetworkLogger: EventMonitor {
    let queue = DispatchQueue(label: "com.yourapp.networklogger")
    
    func requestDidFinish(_ request: Request) {
        print("Request finished: \(request)")
    }
    
    func request(_ request: DataRequest, didParseResponse response: DataResponse<Data, AFError>) {
        switch response.result {
        case .success(let data):
            print("Response Data: \(String(decoding: data, as: UTF8.self))")
        case .failure(let error):
            print("Response Error: \(error)")
        }
    }
}
