//
//  AudioPlayViewController.swift
//  AVStudy
//
//  Created by zhz on 22/08/2017.
//  Copyright © 2017 zhz. All rights reserved.
//

import UIKit

class AudioPlayViewController: UIViewController {
   
    init(name: String) {
        super.init(nibName: nil, bundle: nil)
        self.title = name
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.view.backgroundColor = UIColor.white

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
