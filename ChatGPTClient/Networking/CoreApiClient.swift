//
//  CoreApiClient.swift
//  ChatGPTClient
//
//  Created by Artem Shishkin on 28.03.2023.
//

import Foundation
/**
 Implementation of the basic [ApiClient](x-source-tag://ApiClient) protocol.
 - [RequestMethod](x-source-tag://RequestMethod)
 - [ContentType](x-source-tag://ContentType)
 */
/// - Tag: CoreApiClient
class CoreApiClient: ApiClient {
    private let host: String
    private var timeout: TimeInterval
    
    init(host: String, timeout: TimeInterval = 10) {
        self.host = host
        self.timeout = timeout
    }
    
    private func getUrlString(_ requestData: RequestData) -> String {
        var result = requestData.endpoint == "" ? self.host : "\(self.host)/\(requestData.endpoint)"
        
        if let parameters = requestData.urlParams {
            result = "\(result)?"
            for key in parameters.keys {
                if let value = parameters[key] {
                    result += "\(key)=\(String(describing: value))&"
                }
            }
            result.remove(at: result.index(before: result.endIndex))
        }
        
        return result
    }
    
    /**
     Sets request timeout
     - parameters:
     - newTimeout: timeout in seconds
     */
    func setTimeout(_ newTimeout: TimeInterval) {
        self.timeout = newTimeout
    }
    
    /**
     Sends  request.
     - parameters:
     - requestData: all additional [request data](x-source-tag://RequestData)
     - payload: the request body, used as request body. must conform to Encoded protocol
     - onError: callback
     - onSuccess: callback
     */
    func send<T>(
        _ requestData: RequestData,
        payload: T?) async throws -> Data? {
            
            guard let url = URL(string: self.getUrlString(requestData)) else {
                throw ServerError(text: "cannot tranfrom source to URL") }
            let session = URLSession.shared
            var request = URLRequest(url: url)
            
            request.timeoutInterval = self.timeout
            request.httpMethod = requestData.method.rawValue
            
            if let headers = requestData.headers {
                for key in headers.keys {
                    if let value = headers[key] {
                        request.addValue(value, forHTTPHeaderField: key)
                    }
                }
            }
            
            if let body = payload {
                request.httpBody = try? JSONSerialization.data(withJSONObject: body)
            }
            do {
                let (data, _) = try await session.data(for: request)
                return data
            } catch (let error) {
                print(error.localizedDescription)
                throw ServerError(text: error.localizedDescription)
            }
        }
}
