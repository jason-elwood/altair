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
    
    func createUser(data: NSDictionary, completion:(result: String) -> Void) {
        
    }
    
    func loginUser(data: NSDictionary, completion:(result: String) -> Void) {
        let name = data["name"]
        let pass = data["password"]
        let urlPath: String = "http://52.40.87.162:8080/api/users/"
        let url: NSURL = NSURL(string: urlPath)!
        let request: NSMutableURLRequest = NSMutableURLRequest(URL: url)
        //let devicedata = DeviceData.sharedInstance
        
        request.HTTPMethod = "POST"
        let stringPost="name=\(name!)&password=\(pass!)" // Key and Value
        request.HTTPBody = stringPost.dataUsingEncoding(NSUTF8StringEncoding)
        
        let data = stringPost.dataUsingEncoding(NSUTF8StringEncoding)
        
        request.timeoutInterval = 60
        request.HTTPBody=data
        request.HTTPShouldHandleCookies=false
        
        //let url = NSURL(string: "https://itunes.apple.com/search?term=\(searchTerm)&media=software")
        //let request = NSURLRequest(URL: url)
        let config = NSURLSessionConfiguration.defaultSessionConfiguration()
        let session = NSURLSession(configuration: config)
        
        let task = session.dataTaskWithRequest(request, completionHandler: {(data, response, error) in
            
            do {
                if data == nil {
                    completion(result:"nil")
                    return
                }
                let json = try NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments) as? NSDictionary
                print("Response json: \(json!)")
                //devicedata.setUserName(json!["name"] as! String)
                //devicedata.logUserIn()
                completion(result: "success")
            } catch {
                print("error serializing JSON: \(error)")
                completion(result: "fail")
            }
            
        });
        
        task.resume()
    }
    
    func connection(connection: NSURLConnection!, didReceiveData data: NSData!) {
        dataVal.appendData(data)
        print("We got some data: %s", data)
    }
    
    func connectionDidFinishLoading(connection: NSURLConnection!) {
        do {
            if let jsonResult = try NSJSONSerialization.JSONObjectWithData(dataVal, options: []) as? NSDictionary {
                print(jsonResult)
            }
        } catch let error as NSError {
            print("Error" + error.localizedDescription)
        }
    }
    
    func sendData(data: NSObject) {
        
    }
}