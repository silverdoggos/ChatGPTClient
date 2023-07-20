//
//  CoreApiClient.swift
//  ChatGPTClient
//
//  Created by Artem Shishkin on 28.03.2023.
//

import Foundation
/**
 Implementation of the basic [ApiClient](x-source-tag://ApiClient) protocol. Please refer to the [sample api](x-source-tag://SampleApi) to see the recommended way to use it.
 - [RequestMethod](x-source-tag://RequestMethod)
 - [ContentType](x-source-tag://ContentType)
 */
/// - Tag: CoreApiClient
class CoreApiClient: ApiClient {
    private let host: String
    private var timeout: TimeInterval
    private var task: URLSessionTask?
    var delegate: URLSessionTaskDelegate?
    private let queue = DispatchQueue.global(qos: .background)
    
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
            } catch {
                throw ServerError(text: "")
            }
        }
    
    /**
     Sends asynchronous request.
     - parameters:
     - requestData: all additional [request data](x-source-tag://RequestData)
     - payload: the request body, used as request body. must conform to Encoded protocol
     - onError: callback
     - onSuccess: callback
     */
    func sendAsyncInBackground<T: Encodable>(
        _ requestData: RequestData,
        payload: T?,
        onError: @escaping (Error?) -> Void,
        onSuccess: @escaping (URLResponse?, Data?) -> Void
    ) {
        queue.async {
            guard let url = URL(string: self.getUrlString(requestData)) else {
                onError(ServerError(text: "cannot tranfrom source to URL"))
                return
            }
            
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
                do {
                    let encoder = JSONEncoder()
                    encoder.outputFormatting = .prettyPrinted
                    request.httpBody = try encoder.encode(body)
                } catch {
                    onError(error)
                    return
                }
            }
            
            self.task = session.dataTask(with: request as URLRequest) { data, response, error in
                guard error == nil else {
                    onError(error)
                    return
                }
                
                guard let data = data else {
                    onError(error)
                    return
                }
                
                onSuccess(response, data)
                self.task = nil
            }
            
            self.task?.resume()
        }
    }
    
    /**
     Force cancel the request sent
     */
    func cancelRequest() {
        self.task?.cancel()
        self.task = nil
    }
}
