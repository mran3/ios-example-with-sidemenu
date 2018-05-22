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
        postsService.getPosts(onSuccess: {
            (data) in
            do{
                let json = try JSON(data: data)
                let textoRespuesta = String(data: data, encoding: String.Encoding.utf8)
                //print(textoRespuesta)
                self.arTitles =  json.arrayValue.map({$0["title"].stringValue})
                self.arBodies =  json.arrayValue.map({$0["body"].stringValue})
               
                DispatchQueue.main.async{
                    self.tableView.reloadData()
                }
                
            } catch {
                print("No pude procesar convertir json en arreglo")
            }
        })
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("voy pa ya")
        let destination = segue.destination as? DetailViewController
//        let currentCell = tableView.cellForRow(at: tableView.indexPathForSelectedRow!)!
        
        //destination?.detailLabel?.text = arBodies[(tableView.indexPathForSelectedRow?.row)!]
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
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]?
    {
        // 1
        let shareAction = UITableViewRowAction(style: UITableViewRowActionStyle.default, title: "⤴ \n Share" , handler: { (action:UITableViewRowAction, indexPath: IndexPath) -> Void in
            // 2
            let shareMenu = UIAlertController(title: nil, message: "Share using", preferredStyle: .actionSheet)
            
            let twitterAction = UIAlertAction(title: "Twitter", style: UIAlertActionStyle.default, handler: nil)
            let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil)
            
            shareMenu.addAction(twitterAction)
            shareMenu.addAction(cancelAction)
            
            self.present(shareMenu, animated: true, completion: nil)
        })
        shareAction.backgroundColor = UIColor.blue

        // 3
        let favAction = UITableViewRowAction(style: UITableViewRowActionStyle.default, title: "★ \n Favorite" , handler: { (action:UITableViewRowAction, indexPath:IndexPath) -> Void in
            // 4
            let rateMenu = UIAlertController(title: nil, message: "Fav this Post", preferredStyle: .actionSheet)
            
            let appRateAction = UIAlertAction(title: "Fav", style: UIAlertActionStyle.default, handler: { (alert: UIAlertAction!) in
                    let title = self.arTitles[indexPath.row]
                    let body = self.arBodies[indexPath.row]//[(tableView.indexPathForSelectedRow?.row)!]
                    PersistanceHelper.savePost(title: title, content: body)
                }
            )
            let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil)
            
            rateMenu.addAction(appRateAction)
            rateMenu.addAction(cancelAction)
            
            self.present(rateMenu, animated: true, completion: nil)
        })
        favAction.backgroundColor = UIColor.init(red: 0/255, green: 128/255, blue: 97/255, alpha: 1)
        // 5
        return [shareAction,favAction]
    }

    //voy  ausar un enfoque más suavesongo... intentaré, pero dejo este código acá por si no puedo.
//    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
//        let favAction = self.contextualFavAction(forRowAtIndexPath: indexPath)
//        //let flagAction = self.contextualToggleFlagAction(forRowAtIndexPath: indexPath)
//        let swipeConfig = UISwipeActionsConfiguration(actions: [favAction])
//        return swipeConfig
//    }
    
    


}

