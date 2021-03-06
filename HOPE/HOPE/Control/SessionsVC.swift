//
//  SessionsVC.swift
//  HOPE
//
//  Created by Asma on 16/12/2021.
//

import UIKit

class SessionsVC: UIViewController {
    
    
    var selectedListSession: SetDetile!
    
    //MARK: Outlet for title, image, definition and button
    @IBOutlet weak var sessionTitle: UILabel!
    @IBOutlet weak var sessionImage: UIImageView!
    @IBOutlet weak var theDefinition: UILabel!
    @IBOutlet weak var continueButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sessionTitle.text = selectedListSession.setTitle
        sessionImage.image = selectedListSession.setImageSession
        theDefinition.text = selectedListSession.setDefinition
        
        sessionImage.layer.cornerRadius = 12
        sessionImage.layer.borderColor = UIColor.lightGray.cgColor
        sessionImage.layer.borderWidth = 1.0
        
        animationTitle()
        animationImage()
        animationDefinition()
        animationButtone()
        
    }
    
    
    //MARK: Button to go to the next page
    
    @IBAction func continueSession(_ sender: UIButton) {
        performSegue(withIdentifier: "toSessionDetile", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let vc = segue.destination as? SessionTopicVC {
            vc.selectedListSession = selectedListSession
        }
    }
    
    //MARK: Functions for animations the displayed data
    
    func animationTitle(){
        sessionTitle.transform = CGAffineTransform.init(translationX: 0, y: 100)
        UIView.animate(withDuration: 1, delay: 0.1, options: [.curveEaseOut]) {
            self.sessionTitle.transform = CGAffineTransform.init(translationX: 0, y: 0)
        }
    }
    func animationImage() {
        sessionImage.transform = CGAffineTransform.init(translationX: 0, y: 100)
        UIView.animate(withDuration: 2, delay: 0.1, options: [.curveEaseOut]) {
            self.sessionImage.transform = CGAffineTransform.init(translationX: 0, y: 0)
        }
    }
    func animationDefinition() {
        theDefinition.transform = CGAffineTransform.init(translationX: 0, y: 100)
        UIView.animate(withDuration: 3, delay: 0.1, options: [.curveEaseOut]) {
            self.theDefinition.transform = CGAffineTransform.init(translationX: 0, y: 0)
        }
    }
    func animationButtone() {
        continueButton.transform = CGAffineTransform.init(translationX: 0, y: 50)
        UIView.animate(withDuration: 4, delay: 0.1, options: [.curveEaseOut]) {
            self.continueButton.transform = CGAffineTransform.init(translationX: 0, y: 0)
        }
    }
}

