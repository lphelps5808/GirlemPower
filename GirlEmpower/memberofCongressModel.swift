//
//  memberofCongressModel.swift
//  GirlEmpower
//
//  Created by Laura Phelps on 10/11/15.
//  Copyright © 2015 Laura Phelps. All rights reserved.
//

import Foundation
import UIKit

struct MemberOfCongress {
    
    let description : String?
    let district : Int?
    let contactURL : String?
    let party : String?
    let bioguideid : String?
    let cspanid : Int?
    let firstname : String
    let gender : String
    let lastname : String
    let twitterid : String?
    let youtubeid : String?
    let phone : String?
    let role_type : String?
    let state : String
    let title_long : String?
    let website : String?

    //static means it can be called on the class itself and not an instance of a class
    static func parsedMembersOfCongress(json : AnyObject) -> [MemberOfCongress] {
        
        var membersOfCongress = [MemberOfCongress]()
        
        if let membersDictionary = json as? [String : AnyObject] {
            if let objectsArray = membersDictionary["objects"] as? [AnyObject] {
                for object in objectsArray {
                    if let objectDictionary = object as? [String : AnyObject] {
                        if let person = object["person"] as? [String : AnyObject],
                            firstName = person["firstname"] as? String,
                            lastName = person["lastname"] as? String,
                            gender = person["gender"] as? String,
                            state = object["state"] as? String {

                                let member = MemberOfCongress(
                                    description: objectDictionary["description"] as? String,
                                    district: objectDictionary["district"] as? Int,
                                    contactURL: objectDictionary["extra"]?["contact_form"] as? String,
                                    party: objectDictionary["party"] as? String,
                                    bioguideid: person["bioguideid"] as? String,
                                    cspanid: person["cspanid"] as? Int,
                                    firstname: firstName,
                                    gender: gender,
                                    lastname: lastName,
                                    twitterid: person["twitterid"] as? String,
                                    youtubeid: person["youtubeid"] as? String,
                                    phone: objectDictionary["phone"] as? String,
                                    role_type: objectDictionary["role_type"] as? String,
                                    state: state,
                                    title_long: objectDictionary["title_long"] as? String,
                                    website: objectDictionary["website"] as? String)
                                
                                membersOfCongress.append(member)
                                
                        }
                    }
                }
            }
        }

        return membersOfCongress
    }
    
    
}

