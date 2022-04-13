//
//  ViewController.swift
//  SnapChatCloneWithFirebase
//
//  Created by Ali Osman DURMAZ on 6.04.2022.
//

import UIKit
import Firebase

class SıgnInVC: UIViewController {

    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var usernameText: UITextField!
    @IBOutlet weak var emailText: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    @IBAction func signUpClicked(_ sender: Any) {
        if emailText.text != "" && usernameText.text != "" && passwordText.text != "" {

            Auth.auth().createUser(withEmail: emailText.text!, password: passwordText.text!) { auth, error in
               // Kullanıcı bilgileri kayıt edilir ve DB de saklanır !!
                if error != nil {
                    self.makeAlert(titleInput: "Error", messageInput: "\(error?.localizedDescription)")
                } else {
                    let fireStore = Firestore.firestore()
                    let userDictionary = ["email" : self.emailText.text!, "username" : self.usernameText.text!] as! [String:Any]
                    fireStore.collection("UserInfo").addDocument(data: userDictionary) { error in
                        if error != nil {
                            print("Error")
                        }
                    }
                     // Kayıt işlemi tamamlandıktan sonra geçiş sağlanır
                    self.performSegue(withIdentifier: "toFeedVC", sender: nil)
                }
            }
            
        } else {
            self.makeAlert(titleInput: "Error", messageInput: "E-mail/Username/Password??")
        }
    }
    
    @IBAction func signInClicked(_ sender: Any) {
        if emailText.text != "" && passwordText.text != "" {
            
            Auth.auth().signIn(withEmail: emailText.text!, password: passwordText.text!) { result, error in
                if error != nil {
                    self.makeAlert(titleInput: "Error", messageInput: "\(error?.localizedDescription)")
                } else {
                    self.performSegue(withIdentifier: "toFeedVC", sender: nil)
                }
            }
            
        } else {
            self.makeAlert(titleInput: "Error", messageInput: "E-mail/Username/Password??")
        }
       
    }
    
    func makeAlert(titleInput: String, messageInput: String) {
        
        let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
        
    }
}

