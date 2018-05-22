//
//  PersistanceHelper.swift
//  Z-test
//
//  Created by troquer on 01/04/2018.
//  Copyright © 2018 acvc. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class PersistanceHelper{
    
    

    static func savePost(title:String, content:String) -> Void {
        // do a post request and return post data
        //return ["someData" : "someData"]
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let postsEntity = NSEntityDescription.entity(forEntityName: "Posts", in: context)
        let newPost = NSManagedObject(entity: postsEntity!, insertInto: context)
        newPost.setValue(title, forKey: "title")
        newPost.setValue(content, forKey: "body")
        do {
            try context.save()
        } catch {
            print("Failed saving")
        }
    }
}
