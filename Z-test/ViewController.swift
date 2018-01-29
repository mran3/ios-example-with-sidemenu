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
                print(textoRespuesta)
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
        destination?.receivedTitle = arBodies[(tableView.indexPathForSelectedRow?.row)!]
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arTitles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {        
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath)
        cell.textLabel?.text = arTitles[indexPath.row]
        
        return cell
    }


}

