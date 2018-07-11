//
//  ViewController.swift
//  Z-test
//
//  Created by troquer on 14/01/2018.
//  Copyright © 2018 acvc. All rights reserved.
//

import UIKit
import SwiftyJSON
import SideMenu


class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var arTitles = [String]()
    var arBodies = [String]()
    @IBOutlet weak var tableView: UITableView!
    let detailSegueIdentifier = "ShowDetail"
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.dataSource = self
        self.tableView.delegate = self
        SideMenuManager.default.menuFadeStatusBar = false
        SideMenuManager.default.menuPresentingViewControllerUserInteractionEnabled = true
        
        let postsService = PostsService()
        postsService.getPosts() {(data) in
            do{
                let json = try JSON(data: data)
                //let textoRespuesta = String(data: data, encoding: String.Encoding.utf8)
                //print(textoRespuesta)
                self.arTitles =  json.arrayValue.map({$0["title"].stringValue})
                self.arBodies =  json.arrayValue.map({$0["body"].stringValue})
               
                DispatchQueue.main.async{ self.tableView.reloadData() }
                
            } catch {
                print("Was not able to convert JSON into array.")
            }
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("voy pa ya")
        let destination = segue.destination as? DetailViewController
        destination?.receivedBody = arBodies[(tableView.indexPathForSelectedRow?.row)!]
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arTitles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {        
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath)
        cell.textLabel?.text = arTitles[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.delete) {
            // handle delete (by removing the data from your array and updating the tableview)
        }
    }
    
//    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]?
//    {
//        let favAction = UITableViewRowAction(style: .destructive, title: "★ \n Favorite"){ (action:UITableViewRowAction, indexPath:IndexPath) -> Void in
//     
//            let favMenu = UIAlertController(title: nil, message: "Fav this Post", preferredStyle: .actionSheet)
//            let appRateAction = UIAlertAction(title: "Fav", style: UIAlertActionStyle.default, handler: { (alert: UIAlertAction!) in
//                    let title = self.arTitles[indexPath.row]
//                    let body = self.arBodies[indexPath.row]
//                    PersistanceHelper.savePost(title: title, content: body)
//                }
//            )
//            let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil)
//            
//            favMenu.addAction(appRateAction)
//            favMenu.addAction(cancelAction)
//            self.present(favMenu, animated: true, completion: nil)
//        }
//        favAction.backgroundColor = UIColor.init(red: 0/255, green: 128/255, blue: 97/255, alpha: 1)
//        
//        return [favAction]
//    }


}

