//
//  HttpRequests.swift
//  Adventure
//
//  Created by Jason Elwood on 7/27/16.
//  Copyright © 2016 Jason Elwood. All rights reserved.
//

import Foundation

class DataRequest: NSObject {
    
    var dataVal:        NSMutableData       = NSMutableData()
    var urlPath:        String!
    var url:            NSURL!
    var request:        NSURLRequest!
    var connection:     NSURLConnection!
    
    func createUser(data: NSDictionary, completion:(_ result: String) -> Void) {
        
    }
    
    func loginUser(data: NSDictionary, completion:(_ result: String) -> Void) {
        let name = data["name"]
        let pass = data["password"]
        let urlPath: String = "http://52.40.87.162:8080/api/users/"
        let url: NSURL = NSURL(string: urlPath)!
        let request: NSMutableURLRequest = NSMutableURLRequest(url: url as URL)
        //let devicedata = DeviceData.sharedInstance
        
        request.httpMethod = "POST"
        let stringPost="name=\(name!)&password=\(pass!)" // Key and Value
        request.httpBody = stringPost.data(using: String.Encoding.utf8)
        
        let data = stringPost.data(using: String.Encoding.utf8)
        
        request.timeoutInterval = 60
        request.httpBody=data
        request.httpShouldHandleCookies=false
        
        //let url = NSURL(string: "https://itunes.apple.com/search?term=\(searchTerm)&media=software")
        //let request = NSURLRequest(URL: url)
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        let task = session.dataTask(with: request as URLRequest, completionHandler: {(data, response, error) in
            
            do {
                if data == nil {
                    completion("nil")
                    return
                }
                let json = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? NSDictionary
                print("Response json: \(json!)")
                //devicedata.setUserName(json!["name"] as! String)
                //devicedata.logUserIn()
                completion("success")
            } catch {
                print("error serializing JSON: \(error)")
                completion("fail")
            }
            
        });
        
        task.resume()
    }
    
    func connection(connection: NSURLConnection!, didReceiveData data: NSData!) {
        dataVal.append(data as Data)
        print("We got some data: %s", data!)
    }
    
    func connectionDidFinishLoading(connection: NSURLConnection!) {
        do {
            if let jsonResult = try JSONSerialization.jsonObject(with: dataVal as Data, options: []) as? NSDictionary {
                print(jsonResult)
            }
        } catch let error as NSError {
            print("Error" + error.localizedDescription)
        }
    }
    
    func sendData(data: NSObject) {
        
    }
}
