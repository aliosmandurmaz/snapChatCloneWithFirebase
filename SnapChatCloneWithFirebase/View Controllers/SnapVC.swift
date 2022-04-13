//
//  SnapVC.swift
//  SnapChatCloneWithFirebase
//
//  Created by Ali Osman DURMAZ on 7.04.2022.
//

import UIKit
import ImageSlideshow


class SnapVC: UIViewController {

    @IBOutlet weak var timeLabel: UILabel!
    
    var selectedSnap: Snap?
    var selectedTime: Int?
    var inputArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        timeLabel.text = "Time Left: \(selectedTime)"
        
        if let snap = selectedSnap {
            for imageUrl in snap.imageUrlArray {
                inputArray.append(imageUrl)
            }
            
            let imageSlideShow = ImageSlideshow(frame: CGRect(x: 10, y: 10, width: self.view.frame.width * 0.95, height: self.view.frame.height * 0.9))
            imageSlideShow.backgroundColor = UIColor.white
            
            imageSlideShow.contentScaleMode = UIViewContentMode.scaleAspectFit
            imageSlideShow.setImageInputs(inputArray) 
            self.view.addSubview(imageSlideShow)
        }

    }
    

    

}
