//
//  ViewController.swift
//  AVStudy
//
//  Created by zhz on 22/08/2017.
//  Copyright © 2017 zhz. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let dataSource: NSArray = []
    let tableView: UITableView!
   
    init() {
        tableView = UITableView(frame: ScreenBounds, style: .plain)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
    }
    
    

}

