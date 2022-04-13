//
//  FeedVC.swift
//  SnapChatCloneWithFirebase
//
//  Created by Ali Osman DURMAZ on 7.04.2022.
//

import UIKit
import Firebase
import SDWebImage

class FeedVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    let fireStoreDatabase = Firestore.firestore()
    var snapArray = [Snap]()
    var choosenSnap: Snap?
    var timeLeft: Int?
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        getUserInfo()
        getSnapsFromFirebase()
    }
    
    func getUserInfo() {
        
        fireStoreDatabase.collection("UserInfo").whereField("email", isEqualTo: Auth.auth().currentUser!.email!).getDocuments { snapshot, error in
            if error != nil {
                self.makeAlert(titleInput: "Error", messageInput: "\(error?.localizedDescription)")
            } else {
                if snapshot?.isEmpty == false && snapshot != nil {
                    for document in snapshot!.documents {
                        if let username = document.get("username") as? String {
                            UserSingleton.sharedUserInfo.email = Auth.auth().currentUser!.email!
                            UserSingleton.sharedUserInfo.username = username
                        }
                    }
                }
            }
        }
        
    }
    
    func getSnapsFromFirebase() {
        fireStoreDatabase.collection("Snaps").order(by: "date", descending: true).addSnapshotListener { snapshot, error in
            if error != nil {
                self.makeAlert(titleInput: "Error", messageInput: "\(error?.localizedDescription)")
            } else {
                if snapshot?.isEmpty == false && snapshot != nil {
                    self.snapArray.removeAll(keepingCapacity: false)
                    
                    for document in snapshot!.documents {
                        let documentId = document.documentID
                        
                        if let username = document.get("snapOwner") as? String {
                            if let imageUrlArray = document.get("imageUrlArray") as? [String] {
                                if let date = document.get("date") as? Timestamp {
                                    
                                    // Snap atıldıkta sonra , atıldığı zaman ile güncel zaman arasındaki farkı hesaplayıp snapin kalma süresinini ne kadar olduğunu gösterir
                                    if let diffrence = Calendar.current.dateComponents([.hour], from: date.dateValue(), to: Date()).hour {
                                        if diffrence >= 24 {
                                            self.fireStoreDatabase.collection("Snaps").document(documentId).delete { error in
                                                
                                            }
                                        }
                                        //timeleft -> SnapVc
                                        self.timeLeft = 24 - diffrence
                                        
                                    }
                                    
                                    
                                    let snap = Snap(username: username, imageUrlArray: imageUrlArray, date: date.dateValue())
                                    self.snapArray.append(snap)
                                }
                            }
                        }
                    }
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    func makeAlert(titleInput: String, messageInput: String) {
        
        let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toSnapVC" {
            let destination = segue.destination as! SnapVC
            destination.selectedSnap = choosenSnap
            destination.selectedTime = self.timeLeft!
        }
    }

}

extension FeedVC: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return snapArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! FeedCellTableViewCell
        cell.usernameLabel.text = snapArray[indexPath.row].username
        cell.cellImageView.sd_setImage(with: URL(string: snapArray[indexPath.row].imageUrlArray[0]))
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        choosenSnap = self.snapArray[indexPath.row]
        self.performSegue(withIdentifier: "toSnapVC", sender: nil)
    }
    
}
