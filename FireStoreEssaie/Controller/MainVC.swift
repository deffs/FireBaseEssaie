//
//  ViewController.swift
//  FireStoreEssaie
//
//  Created by Alex de France on 4/8/18.
//  Copyright © 2018 Def Labs. All rights reserved.
//

import UIKit
import Firebase

enum ThoughtCategory: Swift.String {
    case serious, funny, crazy, popular
}

class MainVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet private weak var segControl: UISegmentedControl!
    @IBOutlet private weak var tableView: UITableView!
    
    private var thoughts = [Thought]()
    private var thoughtsColRef: CollectionReference!
    private var thoughtsListener: ListenerRegistration!
    private var selectedCat = ThoughtCategory.funny.rawValue
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let font = UIFont(name: "AvenirNext-Medium", size: 17.0)
        segControl.setTitleTextAttributes([NSAttributedStringKey.font: font!], for: .normal)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 80.0
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.tableFooterView = UIView()
        thoughtsColRef = Firestore.firestore().collection(THOUGHTS_REF)
    }
    
    @IBAction func catChanged(_ sender: Any) {
        switch segControl.selectedSegmentIndex {
        case 0:
            selectedCat = ThoughtCategory.funny.rawValue
        case 1:
            selectedCat = ThoughtCategory.serious.rawValue
        case 2:
            selectedCat = ThoughtCategory.crazy.rawValue
        default:
            selectedCat = ThoughtCategory.popular.rawValue
        }
        thoughtsListener.remove()
        setListener()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        setListener()
    }
    
    func setListener() {
        if selectedCat == ThoughtCategory.popular.rawValue {
            thoughtsListener = thoughtsColRef
                .order(by: NUM_LIKES, descending: true)
                .addSnapshotListener { (snapshot, error) in
                    if let err = error {
                        debugPrint("Error fetching docs : \(err)")
                    } else {
                        self.thoughts.removeAll()
                        self.thoughts = Thought.parseData(snapshot: snapshot)
                        self.tableView.reloadData()
                    }
            }
        } else {
            thoughtsListener = thoughtsColRef
                .whereField(CAT, isEqualTo: selectedCat)
                .order(by: TIMESTAMP, descending: true)
                .addSnapshotListener { (snapshot, error) in
                    if let err = error {
                        debugPrint("Error fetching docs : \(err)")
                    } else {
                        self.thoughts.removeAll()
                        self.thoughts = Thought.parseData(snapshot: snapshot)
                        self.tableView.reloadData()
                    }
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        thoughtsListener.remove()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return thoughts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "ThoughtCell") as? ThoughtCell {
            cell.configureCell(thought: thoughts[indexPath.row])
            return cell
        } else {
            return UITableViewCell()
        }
        
    }
    
    
}

