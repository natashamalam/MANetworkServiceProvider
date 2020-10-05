//
//  MAServiceProvider.swift
//  MANetworkServiceProvider
//
//  Created by Mahjabin Alam on 2020/10/05.
//

import Foundation

class MAServiceProvider {
    
    static let sharedInstance = MAServiceProvider()
    
    func post(_ jsonObject: Dictionary<String, Any>, remoteURL urlString: String, completion: @escaping(Bool, Response)->()){
        
        var res = Response([], errorMessage: nil)
        
        if let url = URL(string: urlString){
            var urlRequest = URLRequest(url: url)
            urlRequest.addValue("application/json", forHTTPHeaderField: "content-type")
            urlRequest.httpMethod = "POST"
            
            do{
                let body = try JSONSerialization.data(withJSONObject: jsonObject, options: [])
                urlRequest.httpBody = body
            }
            catch{
                res.errorMsg = "Json Object serialization failed."
                completion(false, res)
            }
            let session = URLSession.shared
            let dataTask = session.dataTask(with: urlRequest) { (data, response, error) in
                if let jsonData = data{
                    do{
                        let jsonObject = try JSONSerialization.jsonObject(with: jsonData, options: [])
                        if self.isDictionary(jsonObject){
                            let dict = jsonObject as! [String: Any]
                            res.response.append(dict)
                        }
                        else if self.isArray(jsonObject){
                            res.response += jsonObject as! [[String: Any]]
                        }
                        else{
                            print("Unknow object type")
                        }
                        completion(true, res)
                    }
                    catch{
                        res.errorMsg = "Posting Data failed.\n" + error.localizedDescription
                        completion(false, res)
                    }
                }
                else{
                    res.errorMsg = "Posting Json Data failed.\n"
                    completion(false, res)
                }
            }
            dataTask.resume()
        }
        else{
            res.errorMsg = "Failed to generate URL."
            completion(false, res)
        }
    }
    
    func update(atRemoteURL urlString: String, completion: @escaping(Bool, Response)->()){
        
    }
    
    func get(fromRemoteURL urlString: String, completion: @escaping(Bool, Response)->()){
        var res = Response([], errorMessage: nil)
        if let url = URL(string: urlString){
            var urlRequest = URLRequest(url: url)
            urlRequest.addValue("application/json", forHTTPHeaderField: "content-type")
            urlRequest.httpMethod = "GET"
            
            let session = URLSession.shared
            let dataTask = session.dataTask(with: urlRequest) { (data, response, error) in
                if let jsonData = data{
                    do{
                        let jsonObject = try JSONSerialization.jsonObject(with: jsonData, options: [])
                        if self.isDictionary(jsonObject){
                            let dict = jsonObject as! [String: Any]
                            res.response.append(dict)
                        }
                        else if self.isArray(jsonObject){
                            res.response += jsonObject as! [[String: Any]]
                        }
                        else{
                            print("Unknow object type")
                        }
                        completion(true, res)
                    } catch{
                        res.errorMsg = "Getting Data failed.\n" + error.localizedDescription
                        completion(false, res)
                    }
                }
                else{
                    res.errorMsg = "Getting Data failed."
                    completion(false, res)
                }
            }
            dataTask.resume()
        }
        else{
            res.errorMsg = "Failed to generate URL."
            completion(false, res)
        }
    }
    
    func delete(fromRemoteURL urlString: String, completion: @escaping(Bool, Response)->()){
        var res = Response([], errorMessage: nil)
        if let url = URL(string: urlString){
            var urlRequest = URLRequest(url: url)
            urlRequest.addValue("application/json", forHTTPHeaderField: "content-type")
            urlRequest.httpMethod = "DELETE"
            
            let session = URLSession.shared
            let dataTask = session.dataTask(with: urlRequest) { (data, response, error) in
                if let jsonData = data{
                    do{
                        let jsonObject = try JSONSerialization.jsonObject(with: jsonData, options: [])
                        if self.isDictionary(jsonObject){
                            let dict = jsonObject as! [String: Any]
                            res.response.append(dict)
                        }
                        else if self.isArray(jsonObject){
                            res.response += jsonObject as! [[String: Any]]
                        }
                        else{
                            print("Unknow object type")
                        }
                        completion(true, res)
                    } catch{
                        res.errorMsg = "Deleting Data failed.\n" + error.localizedDescription
                        completion(false, res)
                    }
                }
                else{
                    res.errorMsg = "Deleting Data failed."
                    completion(false, res)
                }
            }
            dataTask.resume()
        }
        else{
            res.errorMsg = "Failed to generate URL."
            completion(false, res)
        }
    }
    
    private func isDictionary(_ object: Any)-> Bool{
        if object is [AnyHashable: Any]{
            return true
        }
        return false
    }
    private func isArray(_ object: Any)-> Bool{
        if object is [[AnyHashable: Any]]{
            return true
        }
        return false
    }
    
}
