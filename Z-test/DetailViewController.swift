//
//  DetailViewController.swift
//  Z-test
//
//  Created by troquer on 28/01/2018.
//  Copyright © 2018 acvc. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var detailLabel: UILabel!
    var receivedBody: String = "" //This is set from the previous View Controller
    
    override func viewDidLoad() {
        super.viewDidLoad()
        detailLabel.text = receivedBody
        detailLabel.sizeToFit() //This makes text in the label to align top left
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
