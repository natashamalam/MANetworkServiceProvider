//
//  Response.swift
//  MANetworkServiceProvider
//
//  Created by Mahjabin Alam on 2020/10/05.
//

import Foundation


struct Response {
    var response: [[String:Any]]
    var errorMsg: String?
    
    init(_ response: [[String:Any]], errorMessage msg: String?) {
        self.response = response
        if let errorMsg = msg{
            self.errorMsg = errorMsg
        }
        else{
            self.errorMsg = nil
        }
    }
}
