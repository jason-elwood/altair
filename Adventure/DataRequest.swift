//
//  HttpRequests.swift
//  Adventure
//
//  Created by Jason Elwood on 7/27/16.
//  Copyright © 2016 Jason Elwood. All rights reserved.
//

import Foundation

protocol DataManagerDelegate {
    func didUpdateData(data: Data)
    func didFailWithError(error: Error)
}

class DataRequest: NSObject {
    
    var dataVal:        NSMutableData       = NSMutableData()
    var urlPath:        String!
    var url:            NSURL!
    var request:        NSURLRequest!
    var connection:     NSURLConnection!

    var delegate: DataManagerDelegate?
    
    func createUser(data: NSDictionary, completion:(_ result: String) -> Void) {
        
    }

    func performRequest(with urlString: String) {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }

                if let safeData = data {
                    if self.parseJSON(safeData) != nil {
                        self.delegate?.didUpdateData(data: data!)
                    }
                }
            }
            task.resume()
        }
    }

    func getSomeData(mainClass: Any) {

        delegate = mainClass as? DataManagerDelegate
        
        let url = URL(string: "https://firestore.googleapis.com/v1/projects/altair-89e7c/databases/(default)/documents/users/test@test.com")!

        let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
            guard let data = data else {
                return

            }
            self.delegate?.didUpdateData(data: data)
            //print(String(data: data, encoding: .utf8)!)

        }

        task.resume()

//        let urlPath: String = "https://firestore.googleapis.com/v1/projects/altair-89e7c/databases/(default)/documents/users/test@test.com"
//        let url: NSURL = NSURL(string: urlPath)!
//        let request: NSMutableURLRequest = NSMutableURLRequest(url: url as URL)
//        request.httpMethod = "POST"
////        let stringPost="" // Key and Value
////        request.httpBody = stringPost.data(using: String.Encoding.utf8)
//
//        let data = urlPath.data(using: String.Encoding.utf8)
//        request.timeoutInterval = 60
//        request.httpBody = data
//        request.httpShouldHandleCookies=false
//
//        let config = URLSessionConfiguration.default
//        let session = URLSession(configuration: config)
//
//        let task = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) in
//
//            do {
//                if data == nil {
//                    print("DATA: \(String(describing: data))")
//                    //completion("nil")
//                    return
//                }
//                let json = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? NSDictionary
//                print("Response json: \(json!)")
//                //devicedata.setUserName(json!["name"] as! String)
//                //devicedata.logUserIn()
//                //completion("success")
//            } catch {
//                print("error serializing JSON: \(error)")
//                //completion("fail")
//            }
//
//        });
//
//        task.resume()
    }

    func parseJSON(_ weatherData: Data) -> DataBaseModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(ApplicationData.self, from: weatherData)
            let playerID = decodedData.playerData[0].playerID
            let pleyername = decodedData.playerData[0].playername
            let playerHitpoints = decodedData.playerData[0].hitpoints

            let playerData = DataBaseModel(playerID: 01, playername: pleyername, playerHitpoints: playerHitpoints, outgoingMessages: [], incomingMessages: [])

            print("playerID = \(playerID)")
            return playerData
        } catch {
            self.delegate?.didFailWithError(error: error)
            return nil
        }
    }
    
    func loginUser(data: NSDictionary, completion: @escaping (_ result: String) -> Void) {
        let name = data["name"]
        let pass = data["password"]
        //let urlPath: String = "http://52.40.87.162:8080/api/users/"
        let urlPath: String = "https://firestore.googleapis.com/v1/projects/altair-89e7c/databases/(default)/documents/users/?name=projects/altair-89e7c/databases/(default)/documents/users/test@test.com"
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
        
        let task = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) in
            
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

