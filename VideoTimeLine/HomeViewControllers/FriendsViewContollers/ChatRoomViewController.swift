//
//  ChatRoomViewController.swift
//  VideoTimeLine
//
//  Created by 中村泰輔 on 2019/08/25.
//  Copyright © 2019 icannot.t.n. All rights reserved.
//

import UIKit
import FirebaseFirestore


class ChatRoomViewController: UIViewController {

  let db = Firestore.firestore()
    
    @IBOutlet weak var txtChatText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var ref: DocumentReference? = nil
        // Add a second document with a generated ID.
        ref = db.collection("users").addDocument(data: [
            "first": "Alan",
            "middle": "Mathison",
            "last": "Turing",
            "born": 1912
        ]) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Document added with ID: \(ref!.documentID)")
            }
        }
       
        }
        // Do any additional setup after loading the view.
    


    @IBAction func sendToMessage(_ sender: Any) {
    }
    
}


