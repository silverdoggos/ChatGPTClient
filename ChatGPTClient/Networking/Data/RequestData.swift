//
//  RequestData.swift
//  ChatGPTClient
//
//  Created by Artem Shishkin on 28.03.2023.
//

import Foundation

struct RequestData {
    /**
     Just endpoint, without host name.
     */
    let endpoint: String

    /**
     URL params, the part that goes after "?"-character
     */
    var urlParams: [String: Any]?

    /**
     Request method
     */
    let method: RequestMethod

    /**
     All additional possible request headers
     */
    var headers: [String: String]?
}
