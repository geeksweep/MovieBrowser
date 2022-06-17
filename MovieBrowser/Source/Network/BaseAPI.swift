//
//  BaseAPI.swift
//  MovieBrowser
//
//  Created by Chad Saxon on 6/13/22.
//  Copyright © 2022 Lowe's Home Improvement. All rights reserved.
//

import UIKit
import Network

// This base api takes a URL request and decodes/returns the model type passed in.

class BaseAPI: NSObject {
    
    class func getData<Model:Codable>(type:Model.Type, req:URLRequest, returning:@escaping (Model?) -> Void){
        
        let session = URLSession.shared
        let task = session.dataTask(with: req) { (data, response, error) in
           
            //here we would handle responses and errors and return them accordingly.
            
            if let data = data{
                do{
                    let json = try JSONDecoder().decode(Model.self, from: data)
                    
                    returning(json)
                }
                catch let jsonError{
                    print("trouble with (jsonDecoder): for \(Model.self) ", jsonError)
                    returning(nil)
                }
            }
            else{
                print("trouble with data: data is nil for \(Model.self)")
                returning(nil)
            }
        }
        task.resume()
    }
}
