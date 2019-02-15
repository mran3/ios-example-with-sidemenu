//
//  DetailViewController.swift
//  Z-test
//
//  Created by troquer on 28/01/2018.
//  Copyright © 2018 acvc. All rights reserved.
//

import UIKit
import SideMenu

class DetailViewController: UIViewController {

    @IBOutlet weak var detailLabel: UILabel!
    var receivedBody: String = "" //This is set from the previous View Controller
    var selectedIndex: Int?

    
    @IBAction func addFav(_ sender: UIButton) {
        print("adding to Favs")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        if (!receivedBody.isEmpty) {
            self.title = "Post"
            detailLabel.text = receivedBody
            detailLabel.sizeToFit() //This makes text in the label to align top left
        }
        
        SideMenuManager.default.menuFadeStatusBar = false
        let menuRightNavigationController = storyboard!.instantiateViewController(withIdentifier: "SideMenuNavC") as! UISideMenuNavigationController
        
        SideMenuManager.default.menuRightNavigationController = menuRightNavigationController
        
        SideMenuManager.default.menuAddPanGestureToPresent(toView: self.navigationController!.navigationBar)
        
        SideMenuManager.default.menuAddScreenEdgePanGesturesToPresent(toView: self.navigationController!.view, forMenu:UIRectEdge.right)
        
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
