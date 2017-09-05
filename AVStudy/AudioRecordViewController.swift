//
//  AudioRecordViewController.swift
//  AVStudy
//
//  Created by zhz on 22/08/2017.
//  Copyright © 2017 zhz. All rights reserved.
//

import UIKit
import AVFoundation

class AudioRecordViewController: UIViewController {
    var recorder: AVAudioRecorder!
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
        
        // 1. 设置保存录音的路径
        print(filePath)
        
        // 2. 配置音频的参数: 键值对可用的key定义在<AVFoundation/AVAudioSetting.h>中
        /*  AVFormatIDKey 指定了录音会话生成的音频文件的格式.(全部的value定义在CoreAudio/CoreAudioTypes.h)
         kAudioFormatLinearPCM               = 'lpcm',
         kAudioFormatMPEG4AAC                = 'aac', 'm4a'
         kAudioFormatAppleIMA4               = 'ima4',
         kAudioFormatLinearPCM将会将未压缩的音频直接写入问,极大限度的保证了质量, 但是文件的体积也是最大的.
         kAudioFormatMPEG4AAC和kAudioFormatAppleIMA4的压缩格式将大大减少文文件大小,还能保证较高的音频质量.
         * URL参数定义的文件格式类型必须和AVFormatIDKey指定的文件类型格式类型相同.
         */
        /* AVSampleRateKey定义了录音会话的采样率,单位是Hz,采样率越高,音频质量更高,体积也会增大,虽然没有明确定义,但仍推荐使用标准的采样率.如下:
         8000Hz 电话所用采样率，对于人的说话已经足够
         22050Hz 无线电广播所用采样率，广播音质
         44100Hz 音频CD，也常用于MPEG-1音频（VCD，SVCD，MP3）所用采样率
         47250Hz NipponColumbia(Denon)开发的世界上第一个商用PCM录音机所用采样率
         48000Hz miniDV、数字电视、DVD、DAT、电影和专业音频所用的数字声音所用采样率
         */
        /* AVNumberOfChannelsKey顾名思义, 指的是录音回话的声道数,指定为1意味着单声道的录制,定义为2则代表立体声录制,
         除非我们使用外界设备录音,否则应该创建单声道录音.
         */
        let config:[String:Any] = [     AVFormatIDKey: kAudioFormatMPEG4AAC,
                                      AVSampleRateKey: 44100,
                                AVNumberOfChannelsKey: 1
                                        ]
        
        // 3. 初始化 录音对象 添加NSMicrophoneUsageDescription到应用info.plist文件
        do {
            recorder = try AVAudioRecorder(url: URL(fileURLWithPath: filePath), settings: config)
        } catch let error {
            print(error)
        }
        recorder.delegate = self
        let isSucesse = recorder.prepareToRecord()
        print("prepareToRecord: " + String(isSucesse))
        
        // 监控被打断的通知
        NotificationCenter.default.addObserver(self, selector: #selector(audioRecorderBeginInterruption(_:)), name: NSNotification.Name.AVAudioSessionInterruption, object: nil)
        
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
    
    func audioSessionInterruptionNotification(notify: Notification) {
        print(notify.userInfo!)
        /* Registered listeners will be notified when the system has interrupted the audio session and when
         the interruption has ended.  Check the notification's userInfo dictionary for the interruption type -- either begin or end.
         In the case of an end interruption notification, check the userInfo dictionary for AVAudioSessionInterruptionOptions that
         indicate whether audio playback should resume.
         In cases where the interruption is a consequence of the application being suspended, the info dictionary will contain
         AVAudioSessionInterruptionWasSuspendedKey, with the boolean value set to true.
         */
        // AVAudioSessionInterruptionNotification NS_AVAILABLE_IOS(6_0);
        
        /* keys for AVAudioSessionInterruptionNotification */
        /* Value is an NSNumber representing an AVAudioSessionInterruptionType */
        //AVAudioSessionInterruptionTypeKey NS_AVAILABLE_IOS(6_0);
        
        /* Only present for end interruption events.  Value is of type AVAudioSessionInterruptionOptions.*/
        //AVAudioSessionInterruptionOptionKey NS_AVAILABLE_IOS(6_0);
        
        /* Only present in begin interruption events, where the interruption is a direct result of the application being suspended
         by the operating sytem. Value is a boolean NSNumber, where a true value indicates that the interruption is the result
         of the application being suspended, rather than being interrupted by another audio session.
         
         Starting in iOS 10, the system will deactivate the audio session of most apps in response to the app process
         being suspended. When the app starts running again, it will receive the notification that its session has been deactivated
         by the system. Note that the notification is necessarily delayed in time, due to the fact that the application was suspended
         at the time the session was deactivated by the system and the notification can only be delivered once the app is running again. */
        //AVAudioSessionInterruptionWasSuspendedKey NS_AVAILABLE_IOS(10_3);
        
        /* AVAudioRecorder INTERRUPTION NOTIFICATIONS ARE DEPRECATED - Use AVAudioSession instead. */
    }
    
    func play() {
        let isSuccess = recorder.record()
        print("record play: " + String(isSuccess))
    }
    
    func pause() -> Void {
        if recorder.isRecording {
            recorder.pause()
            print("record pause")
        } else {
            self.play()
        }
        self.showFileInfo(path: filePath)
    }
    
    func stop() -> Void {
        recorder.stop()
        print("record stop")
        self.showFileInfo(path: filePath)
    }
    
    func showFileInfo(path: String) {
        let duration: CGFloat = getAudioDuration(path: filePath)
        let size: CGFloat = getFileSize(path: filePath)
        
        self.titleLabel.text = "音频总长: " + String(describing: duration) + "      音频文件大小: " + String(describing: size)
    }
}

extension AudioRecordViewController: AVAudioRecorderDelegate {
    // 录音完成时的回调 (stop)
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        print("录音成功")
    }
    
    func audioRecorderEncodeErrorDidOccur(_ recorder: AVAudioRecorder, error: Error?) {
        print(error?.localizedDescription as Any)
    }
    
    // 下面这个两个代理已被废弃, 改为通知:AVAudioSessionInterruptionNotification
    func audioRecorderBeginInterruption(_ recorder: AVAudioRecorder) {}
    func audioRecorderEndInterruption(_ recorder: AVAudioRecorder, withOptions flags: Int) {}
}
