//
//  TwitterModel.swift
//  GirlEmpower
//
//  Created by Laura Phelps on 10/4/15.
//  Copyright © 2015 Laura Phelps. All rights reserved.
//

import Foundation
import Social

struct Tweet: CustomStringConvertible {
    let screen_name : String?
    let created_at : NSDate?
    let retweet_count : Int?
    let text : String?
    let verified : Bool?
    let profile_image_url : String?
    
    var description: String {
        return "\(screen_name)\n\(created_at)\n\(retweet_count)\n\(text)\n\(verified)\n\(profile_image_url)\n"
    }
}

struct TweetParser {
    static func parse(data: [AnyObject]) -> [Tweet] {
        
        var tweetsArray = [Tweet]()
        
        // FIXME: - Possible Refactor
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "EEE MMM dd HH:mm:ss ZZZ yyyy"
        
        for tweetObj in data {
            if let parsedTweetObj = tweetObj as? [String : AnyObject] {
                
                var date: NSDate?
                if let dateString = parsedTweetObj["created_at"] as? String {
                    date = dateFormatter.dateFromString(dateString)
                }
                
                let tweet = Tweet(
                    screen_name: parsedTweetObj["user"]?["screen_name"] as? String,
                    created_at: date,
                    retweet_count: parsedTweetObj["retweeted"] as? Int,
                    text: parsedTweetObj["text"] as? String,
                    verified: parsedTweetObj["user"]?["verified"] as? Bool,
                    profile_image_url: parsedTweetObj["user"]?["profile_image_url"] as? String
                )
                
                print(tweet)
                
                tweetsArray.append(tweet)
               
            }
        }
        
        return tweetsArray
    }
}
