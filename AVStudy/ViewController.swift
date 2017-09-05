//
//  ViewController.swift
//  AVStudy
//
//  Created by zhz on 22/08/2017.
//  Copyright © 2017 zhz. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let dataSource: [String] = ["audio record", "audio play", "video record", "video play"]
    var tableView: UITableView!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "AVFoundation"
        
        tableView = UITableView(frame: ScreenBounds, style: .plain)
        tableView.backgroundColor = UIColor.lightGray
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "myCell")
        tableView.tableFooterView = UIView()
        self.view.addSubview(tableView)
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath)
        let title = self.dataSource[indexPath.row]
        cell.textLabel?.text = title
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let title = self.dataSource[indexPath.row]
        switch indexPath.row {
        case 0:
            self.navigationController?.pushViewController(AudioRecordViewController(name: title), animated: true)
            break
        case 1:
            self.navigationController?.pushViewController(AudioPlayViewController(name: title), animated: true)
            break
        case 2:
            
            break
        default:
            break
            
        }
    }
    
}
