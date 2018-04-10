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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 80.0
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.tableFooterView = UIView()
        
        thoughtsColRef = Firestore.firestore().collection(THOUGHTS_REF)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        thoughtsColRef.getDocuments { (snapshot, error) in
            if let err = error {
                debugPrint("Error fetching docs : \(err)")
            } else {
                guard let snap = snapshot else { return }
                if snap.documents.count == self.thoughts.count { return }
                for document in snap.documents {
                    let data = document.data()
                    let username = data[USERNAME] as? String ?? "Anonymous"
                    let timestamp = data[TIMESTAMP] as? Date ?? Date()
                    let thoughtTxt = data[THOUGHT_TXT] as? String ?? ""
                    let numLikes = data[NUM_LIKES] as? Int ?? 0
                    let numComments = data[NUM_COMS] as? Int ?? 0
                    let docId = document.documentID
                    
                    let newThought = Thought(username: username, timestamp: timestamp, thoughtTxt: thoughtTxt, numLikes: numLikes, numComments: numComments, docId: docId)
                    self.thoughts.append(newThought)
                }
                self.tableView.reloadData()
            }
        }
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

