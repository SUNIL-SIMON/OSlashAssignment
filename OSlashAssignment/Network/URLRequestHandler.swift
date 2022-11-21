//
//  URLRequestHandler.swift
//  OSlashAssignment
//
//  Created by SIMON on 19/11/22.
//

import Foundation
import UIKit
class URLRequestHandler
{
    var task: URLSessionDataTask?
    var session = URLSession.shared
    func makeServerCall(urlString : String, completion : @escaping (Data,URLResponse,Bool) -> Void)
    {
        guard let url = URL(string: urlString) else {return}
        let urlSession = URLSession.shared.dataTask(with: url, completionHandler: {(data,responce,error) in
            if data != nil && responce != nil{
                completion(data!,responce!, error == nil)
            }
            else{
                completion(Data(),URLResponse(), false)
            }
        })
        urlSession.resume()
    }

}
