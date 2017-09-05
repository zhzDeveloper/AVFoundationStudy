//
//  AudioPlayViewController.swift
//  AVStudy
//
//  Created by zhz on 22/08/2017.
//  Copyright © 2017 zhz. All rights reserved.
//

import UIKit
import AVFoundation

class AudioPlayViewController: UIViewController {
    let titleLabel: UILabel = UILabel(frame: CGRect(x: 50, y: 50 + 64, width: ScreenW - 100, height: 50))

    init(name: String) {
        super.init(nibName: nil, bundle: nil)
        self.title = name
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        
        self.setupUI()
        self.showFileInfo(path: filePath)
        
//        let avPlayer:  = value
        
        
        
        // 监控被打断的通知
        NotificationCenter.default.addObserver(self, selector: #selector(audioRecorderInterruption(notify:)), name: NSNotification.Name.AVAudioSessionInterruption, object: nil)
    }
    
    func setupUI() {
        titleLabel.backgroundColor = UIColor.lightGray
        titleLabel.textAlignment = .center
        titleLabel.adjustsFontSizeToFitWidth = true
        self.view.addSubview(titleLabel)
        
        let btnMinY: CGFloat = titleLabel.frame.maxY + 20
        
        let playBtn = UIButton(type: .custom)
        playBtn.frame = CGRect(x: 50, y: btnMinY, width: 80, height: 80)
        playBtn.backgroundColor = UIColor.cyan
        playBtn.addTarget(self, action: #selector(play), for: .touchUpInside)
        playBtn.setTitle("play", for: .normal)
        self.view.addSubview(playBtn)
        
        let pauseBtn = UIButton(type: .custom)
        pauseBtn.frame = CGRect(x: (ScreenW - 80) / 2.0, y: btnMinY, width: 80, height: 80)
        pauseBtn.backgroundColor = UIColor.cyan
        pauseBtn.addTarget(self, action: #selector(pause), for: .touchUpInside)
        pauseBtn.setTitle("pause", for: .normal)
        self.view.addSubview(pauseBtn)
        
        let stopBtn = UIButton(type: .custom)
        stopBtn.frame = CGRect(x: ScreenW - 80 - 50, y: btnMinY, width: 80, height: 80)
        stopBtn.backgroundColor = UIColor.cyan
        stopBtn.addTarget(self, action: #selector(stop), for: .touchUpInside)
        stopBtn.setTitle("stop", for: .normal)
        self.view.addSubview(stopBtn)
    }
    
    func showFileInfo(path: String) {
        let duration: CGFloat = getAudioDuration(path: filePath)
        let size: CGFloat = getFileSize(path: filePath)
        self.titleLabel.text = "音频总长: " + String(describing: duration) + "      音频文件大小: " + String(describing: size)
    }
    
    func play() {
        
    }
    
    func pause() -> Void {
        
    }
    
    func stop() -> Void {

    }

    func audioRecorderInterruption(notify: Notification) {
        print(notify.userInfo!)
    }

    
}
