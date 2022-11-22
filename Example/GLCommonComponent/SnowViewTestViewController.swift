//
//  SnowViewTestViewController.swift
//  GLCommonComponent_Example
//
//  Created by Gyu on 2022/11/22.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import UIKit
import GLCommonComponent

class SnowViewTestViewController: UIViewController {

    let snowView = SnowView()
    
    let startButton = UIButton()
    let stopButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .black

        makeSnowView()
        
        makeStartButton()
        makeStopButton()
    }
    
    func makeSnowView() {
        self.view.addSubview(snowView)
        snowView.snp.makeConstraints { make in
            make.top.left.equalTo(0)
            make.width.bottom.equalTo(self.view)
        }
        
    }
    
    func makeStartButton() {
        self.view.addSubview(startButton)
        startButton.setTitle("Start", for: .normal)
        startButton.setTitleColor(.black
                                  , for: .normal)
        startButton.backgroundColor = .white
        startButton.layer.cornerRadius = 16
        startButton.clipsToBounds = true
        
        startButton.snp.makeConstraints { make in
            make.width.equalTo(150)
            make.height.equalTo(50)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide).offset(-30)
            make.centerX.equalTo(self.view).multipliedBy(0.5)
        }
        
        startButton.addTarget(self, action: #selector(touchStartButton), for: .touchUpInside)
    }
    
    @objc func touchStartButton() {
        //You can change sks file, In this project imported "snow", "rain", "fire"
        snowView.startSnow(sksFileName: "snow")
    }
    
    func makeStopButton() {
        self.view.addSubview(stopButton)
        stopButton.setTitle("Stop", for: .normal)
        stopButton.setTitleColor(.black, for: .normal)
        stopButton.backgroundColor = .white
        stopButton.layer.cornerRadius = 16
        stopButton.clipsToBounds = true
        
        stopButton.snp.makeConstraints { make in
            make.width.height.bottom.equalTo(startButton)
            make.centerX.equalTo(self.view).multipliedBy(1.5)
        }
        
        stopButton.addTarget(self, action: #selector(touchStopButton), for: .touchUpInside)
    }
    
    @objc func touchStopButton() {
        snowView.stopSnow()
    }

}
