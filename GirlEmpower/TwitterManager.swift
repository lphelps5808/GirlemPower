//
//  TwitterManager.swift
//  GirlEmpower
//
//  Created by Laura Phelps on 10/3/15.
//  Copyright © 2015 Laura Phelps. All rights reserved.
//

import Foundation
import Social
import UIKit
import Accounts

private let kTwitterTimelineEndpoint = "https://api.twitter.com/1.1/statuses/user_timeline.json"

typealias TwitterCompletionHandler = (tweet: Void?, error: NSError?) -> Void

class TwitterManager {
    
    let accountStore = ACAccountStore()
    
    func getTimeline(screenName: String, completion: TwitterCompletionHandler) {
        
        let url = NSURL(string: kTwitterTimelineEndpoint)
        let params: [NSObject : AnyObject] = [
            "include_entities" : "true",
            "include_rts" : "false",
            "screen_name" : screenName,
            "count" : "10"
        ]
        
        let accountType = accountStore.accountTypeWithAccountTypeIdentifier(ACAccountTypeIdentifierTwitter)
        
        accountStore.requestAccessToAccountsWithType(accountType, options: nil) { (granted, error) -> Void in
            if granted && error == nil {
                
                let account = self.accountStore.accountsWithAccountType(accountType)[0] // this will crash if there are no accounts
                let postRequest = SLRequest(forServiceType: SLServiceTypeTwitter, requestMethod: SLRequestMethod.GET, URL: url, parameters: params)
                postRequest.account = account as! ACAccount
                postRequest.performRequestWithHandler { (data, response, error) -> Void in
                    
                    let json = try! NSJSONSerialization.JSONObjectWithData(data, options: []) as! [AnyObject]
                    
                    print(json)
                    
                    let tweets = TweetParser.parse(json)
                    
                    
                    //completion()
                    
                }
            }
        }
        
    }
    
    
}