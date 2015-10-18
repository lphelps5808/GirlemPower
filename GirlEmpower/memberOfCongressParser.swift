//
//  memberOfCongressParser.swift
//  GirlEmpower
//
//  Created by Laura Phelps on 10/11/15.
//  Copyright © 2015 Laura Phelps. All rights reserved.
//

import Foundation

typealias MemberOfCongressCompletionBlock = (returnMembers : [MemberOfCongress]?, returnError : NSError?) -> Void

class memberOfCongressParser {
    
    var dataSource = [MemberOfCongress]()
    
    func pullGovTrackData(completion: MemberOfCongressCompletionBlock) {
        
        
        let urlString = "https://www.govtrack.us/api/v2/role?current=true&limit=700"
        
        let url = NSURL(string: urlString)!
        
        let urlRequest = NSURLRequest(URL: url)
        
        let task = NSURLSession.sharedSession().dataTaskWithRequest(urlRequest) { [weak self](data, response, error) -> Void in
      
            if let _self = self {
                
                if let data = data where error == nil {
                    
                    let json = try! NSJSONSerialization.JSONObjectWithData(data, options: [])
                    
                    
                let parsedMembersofCongress = MemberOfCongress.parsedMembersOfCongress(json)
                    
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                   _self.dataSource = parsedMembersofCongress
                    completion(returnMembers: parsedMembersofCongress, returnError: nil)
                    
                
                    //print(parsedMembersofCongress)
                    
                })
                    
                }
                
            }
            
            
        }
        
        task.resume()
        
        
    }
    
    
    
}