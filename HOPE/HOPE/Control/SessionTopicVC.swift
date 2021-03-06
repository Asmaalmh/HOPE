//
//  SessionTopicVC.swift
//  HOPE
//
//  Created by Asma on 27/12/2021.
//

import UIKit

class SessionTopicVC: UIViewController {
    
    var selectedListSession: SetDetile!
    
    
    //MARK: Outlet for title and content
    @IBOutlet weak var firstSubTitleSession: UILabel!
    @IBOutlet weak var firstSessionContent: UILabel!
    @IBOutlet weak var secondSubTitleSession: UILabel!
    @IBOutlet weak var secondSessionContent: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        firstSubTitleSession.text = selectedListSession.setFirstSubHead
        firstSessionContent.text = selectedListSession.setFirstContent
        secondSubTitleSession.text = selectedListSession.setSecondSubhead
        secondSessionContent.text = selectedListSession.setSecondContent
        
        firstSubTitleSession.alpha = 0
        firstSessionContent.alpha = 0
        secondSubTitleSession.alpha = 0
        secondSessionContent.alpha = 0
        
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        UIView.animate(withDuration: 1, animations: { self.firstSubTitleSession.alpha = 1
        }) { (true) in
            self.animationContent()
        }
    }
    
    
    //MARK: Button to go to the next page
    
    @IBAction func continueSession(_ sender: UIButton) {
        performSegue(withIdentifier: "toEndOfSession", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let vc = segue.destination as? EndOfSessionVC {
            vc.selectedListSession = selectedListSession
        }
    }
    
    //MARK: Functions for animations the displayed data
    
    func animationContent() {
        UIView.animate(withDuration: 1, animations: {
            self.firstSessionContent.alpha = 1
        }, completion: { (true) in
            self.animationTitle()
            
        })
    }
    
    func animationTitle() {
        UIView.animate(withDuration: 1, animations: {
            self.secondSubTitleSession.alpha = 1
        }, completion: { (true) in
            self.animationSecondContent()
            
        })
    }
    
    func animationSecondContent() {
        UIView.animate(withDuration: 1, animations: {
            self.secondSessionContent.alpha = 1
        })
    }
    
    
    
    
}
