//
//  ChatRoomViewController.swift
//  VideoTimeLine
//
//  Created by 中村泰輔 on 2019/08/27.
//  Copyright © 2019 icannot.t.n. All rights reserved.
//

import UIKit

struct ChatMessage {
    let text: String
    let isIncoming: Bool
    let date: Date
}

extension Date {
    static func dateFromCustomString(customString: String) -> Date {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        return dateFormatter.date(from: customString) ?? Date()
        
    }
}

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    private var cellId = "id"
    
    let messagesFromServer = [
        ChatMessage(text: "aaaaaaaaaaaa", isIncoming: true, date: Date()),
        ChatMessage(text: "aaaaaaaaaaaa", isIncoming: true, date: Date()),
        ChatMessage(text: "aaaaaaaaaaaa", isIncoming: false, date: Date()),
        ChatMessage(text: "aaaaaaaaaaaa", isIncoming: false, date: Date()),
        ChatMessage(text: "aaaaaaaaaaaa", isIncoming: true, date: Date()),
        ChatMessage(text: "Third Section Message", isIncoming: true, date: Date())
    ]
    
    private func attemptToAssembleGroupedMessages() {
        print("Attempt to group our messages together based on Data property")
        
        let groupedMessages = Dictionary(grouping: messagesFromServer) { (element) -> Date in
            return element.date
        }
        // provide a sorting for your keys somehow
        let sortedKeys = groupedMessages.keys.sorted()
        sortedKeys.forEach{(key) in
            let values = groupedMessages[key]
            chatMessages.append(values ?? [])
        }
        
        print("groupedMessages")
    }
    
    var chatMessages = [[ChatMessage]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        attemptToAssembleGroupedMessages()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(ChatMessageTableViewCell.self, forCellReuseIdentifier: cellId)
        tableView.separatorStyle = .none
        tableView.backgroundColor =  #colorLiteral(red: 0, green: 0.6712353826, blue: 1, alpha: 0.9997324486) // UIColor(white: 0.95, alpha: 1)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return chatMessages.count
    }
    // ================================================================================
    class DateHeaderLabel: UILabel {
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            
            backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
            textColor = .white
            textAlignment = .center
            // autolayout
            translatesAutoresizingMaskIntoConstraints = false
            font = UIFont.boldSystemFont(ofSize: 14)
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        override var intrinsicContentSize: CGSize {
            let oiginalContentSize = super.intrinsicContentSize
            let height = oiginalContentSize.height + 12
            layer.cornerRadius = height / 2
            layer.masksToBounds = true
            return CGSize(width: oiginalContentSize.width + 20, height: height)
        }
    }
    // =====================================================================================
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if let firstMessageInSection = chatMessages[section].first {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MM/dd/yyyy"
            let dateString = dateFormatter.string(from: firstMessageInSection.date)
            
            let label = DateHeaderLabel()
            label.text = dateString
            
            let containerView = UIView()
            
            containerView.addSubview(label)
            label.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
            label.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
            return containerView
        }
        
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    //    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    //
    //        return "Section: \(Date())"
    //    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chatMessages[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! ChatMessageTableViewCell
        
        let chatMessage = chatMessages[indexPath.section][indexPath.row]
        // cell.messageLabel.text = chatMessage.text
        cell.chatMessage = chatMessage
        // cell.isIncoming = chatMessage.isIncoming
        
        // cell.isIncoming = true
        
        return cell
    }
    
    
    
}
