//
//  ViewController.swift
//  Z-test
//
//  Created by troquer on 14/01/2018.
//  Copyright © 2018 acvc. All rights reserved.
//

import UIKit
import SwiftyJSON


class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var arTitles = [String]()
    var arBodies = [String]()
    @IBOutlet weak var tableView: UITableView!
    let detailSegueIdentifier = "ShowDetail"
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        
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
        
        destination?.selectedIndex = tableView.indexPathForSelectedRow?.row
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arTitles.count
    }
    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath)
//        cell.textLabel?.text = arTitles[indexPath.row]
//
//        return cell
//    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath)
            as! PostCell
        
        cell.cellTitle?.text = arTitles[indexPath.row]
        if (indexPath.row > 19) {
            cell.cellDot.image = nil
        } else {
            cell.cellDot.image = UIImage(named: "circle")
        }
        
//        let headline = headlines[indexPath.row]
//        cell.headlineTitleLabel?.text = headline.title
//        cell.headlineTextLabel?.text = headline.text
//        cell.headlineImageView?.image = UIImage(named: headline.image)
        
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
    


}

