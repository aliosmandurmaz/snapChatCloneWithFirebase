//
//  SettingsVC.swift
//  SnapChatCloneWithFirebase
//
//  Created by Ali Osman DURMAZ on 7.04.2022.
//

import UIKit
import Firebase

class SettingsVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    
    @IBAction func logoutClicked(_ sender: Any) {
    
        do {
            try Auth.auth().signOut()
            self.performSegue(withIdentifier: "toSignInVC", sender: nil)
        } catch  {
            print("Error")
        }
        
    }
    

}
