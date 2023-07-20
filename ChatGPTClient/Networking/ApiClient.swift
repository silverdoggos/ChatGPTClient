//
//  ApiClient.swift
//  ChatGPTClient
//
//  Created by Artem Shishkin on 28.03.2023.
//

import Foundation
/**
 Basic api client protocol. Please refer to the [sample api](x-source-tag://SampleApi) to see the recommended way to use it
 - [RequestMethod](x-source-tag://RequestMethod)
 - [ContentType](x-source-tag://ContentType)
 */
/// - Tag: ApiClient
protocol ApiClient {
    /**
     Sets request timeout
     - parameters:
        - newTimeout: timeout in seconds
     */
    func setTimeout(_ newTimeout: TimeInterval)

    /**
     Sends asynchronous request in background.
     - parameters:
        - requestData: all additional [request data](x-source-tag://RequestData)
        - payload: the request payload, is a request body. Must conform to Encoded protocol
        - onError: callback
        - onSuccess: callback
     */
    func sendAsyncInBackground<T: Encodable>(
        _ requestData: RequestData,
        payload: T?,
        onError: @escaping (Error?) -> Void,
        onSuccess: @escaping (URLResponse?, Data?) -> Void
    )
    
    /**
     Sends asynchronous request.
     - parameters:
        - requestData: all additional [request data](x-source-tag://RequestData)
        - payload: the request payload, is a request body. Must conform to Encoded protocol
        - onError: callback
        - onSuccess: callback
     */
    func send<T>(
        _ requestData: RequestData,
        payload: T?) async throws -> Data?

    /**
     Force cancel the request sent
     */
    func cancelRequest()
}
