//
//  Home.swift
//  HOPE
//
//  Created by Asma on 08/12/2021.
//

import UIKit
import FirebaseAuth
import CoreData

class HomeVC: UIViewController {
    
    
    var arraySession = [Session]()
    var selectedSession: Session!
    var timer: Timer?
    var currentItemIndex = 0
    var yourSessionsList: [YourSessionsList] = []
    
    // MARK: Outlet for collection view and table view
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var sessionTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        if let uid = Auth.auth().currentUser?.uid {
//            UserApi.getUser(uid: uid) { user in
//            }
//        }
        collectionView.delegate = self
        collectionView.dataSource = self
        sessionTableView.delegate = self
        sessionTableView.dataSource = self
        
        startTimer()
        setSessions()
    }
    
    // MARK:  SAVE CORE DATA
    let persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "BeneficiarySessions")
        container.loadPersistentStores (completionHandler: { desc, error in
            if let readError = error {
                print(readError)
            }
        })
        return container
    }()
    
    // MARK:  Array of TableView
    fileprivate func setSessions() {
        arraySession.append(Session.init(image: UIImageResource.Session1.rawValue, titleSessions: "Self-Image and Cancer".localaized, Content: "- Physical changes.\n- Emotional changes.\n- Coping with self-image changes.".localaized))
        arraySession.append(Session.init(image: UIImageResource.Session2.rawValue, titleSessions: "Coping With Uncertainty".localaized, Content: "- Causes of uncertainty.\n- Dealing with the “what ifs” of cancer.".localaized))
        arraySession.append(Session.init(image: UIImageResource.Session3.rawValue, titleSessions: "Managing Stress".localaized, Content: "- Tips for reducing stress.\n- Stress management strategies.\n- Relaxation techniques.".localaized))
        arraySession.append(Session.init(image: UIImageResource.Session4.rawValue, titleSessions: "Coping with Anger".localaized, Content: "- Coping with anger.\n- Considering counseling".localaized))
        arraySession.append(Session.init(image: UIImageResource.Session5.rawValue, titleSessions: "Anxiety".localaized, Content: "- Anxiety and cancer.\n- Acute anxiety symptoms.\n- Chronic anxiety symptoms.\n- Treatment types.".localaized))
        arraySession.append(Session.init(image: UIImageResource.Session6.rawValue, titleSessions: "Depression".localaized, Content: "- Mood-related symptoms.\n- Behavioral symptoms.\n- Physical symptoms.\n- Treatment of depression.".localaized))
        arraySession.append(Session.init(image: UIImageResource.Session7.rawValue, titleSessions: "Managing the Fear".localaized, Content: "- How can I cope with my fears of side effects?\n- Talking about your fear of cancer side effects.\n- Questions to ask the health care team.".localaized))
        arraySession.append(Session.init(image: UIImageResource.Session8.rawValue, titleSessions: "Coping with Guilt".localaized, Content: "- Coping with guilt.\n- Letting go of guilt.".localaized))
        arraySession.append(Session.init(image: UIImageResource.Session9.rawValue, titleSessions: "Coping with Cancer".localaized, Content: "- Naming metastatic cancer.\n- Goals of treatment\n- The challenges of living with cancer".localaized))
    }
}



// MARK: - Extension for CollectionView

extension HomeVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    // MARK:  Timer for collectionView
    func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 2.5, target: self, selector: #selector(moveToNextIndex), userInfo: nil, repeats: true)
    }
    
    @objc func moveToNextIndex() {
        if currentItemIndex < arrayCollection.count - 1 {
            currentItemIndex += 1
        } else {
            currentItemIndex = 0
        }
        collectionView.scrollToItem(at: IndexPath(item: currentItemIndex, section: 0), at: .centeredHorizontally, animated: true)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrayCollection.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let item = collectionView.dequeueReusableCell(withReuseIdentifier: "homeItem", for: indexPath) as! HomeCollectionViewCell
        item.imageCell.image = arrayCollection[indexPath.row]
        return item
    }
    
    // MARK:  Size Item
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    // MARK:  Spaces between items
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}


// MARK: - Extension for TableView

extension HomeVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arraySession.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "sessionCell", for: indexPath) as! HomeTableViewCell
        let data = arraySession[indexPath.row]
        cell.setUpCell(imageSessi: UIImage(named: data.image)!, titleSessi: data.titleSessions) //
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        selectedSession = arraySession[indexPath.row]
        performSegue(withIdentifier: "toContent", sender: nil)

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let vc = segue.destination as? SessionContent {
            vc.selectedSession = selectedSession
        }
    }
    
    // MARK:  CORE-DATA | The function of saving data in the coredata
    
    func createNewList(titleSession: String, imageSession: String){
        let context = persistentContainer.viewContext
        context.performAndWait {
            let list = YourSessionsList(context: context)
            list.titleSession = titleSession
            list.imageSession = imageSession
            do {
                try context.save()
            } catch {
                print(error)
            }
        }
    }
}
