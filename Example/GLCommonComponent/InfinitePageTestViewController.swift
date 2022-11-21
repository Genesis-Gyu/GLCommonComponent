//
//  InfinitePageTestViewController.swift
//  GLCommonComponent_Example
//
//  Created by Gyu on 2022/11/18.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import UIKit
import GLCommonComponent

class InfinitePageTestViewController: UIViewController {
    
    let screenSize = UIScreen.main.bounds.size
    let infinitePageScrollView1 = InfinitePageScrollView(pageSize: CGSize(width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.width))
    let infinitePageScrollView2 = InfinitePageScrollView(pageSize: CGSize(width: UIScreen.main.bounds.size.width-100, height: 200))
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        makeInfinitePageScrollView()
    }
    
    func makeInfinitePageScrollView() {
        self.view.addSubview(infinitePageScrollView1)
        infinitePageScrollView1.snp.makeConstraints { make in
            make.left.equalTo(0)
            make.top.equalTo(100)
            //make.width.height.equalTo(infinitePageScrollView1.pageSize)
        }
        
        let labelViews = [makeTestLabel(text: "1", backgroundColor: .green), makeTestLabel(text: "2", backgroundColor: .blue),
                          makeTestLabel(text: "3", backgroundColor: .brown), makeTestLabel(text: "4", backgroundColor: .lightGray)]
        
        infinitePageScrollView1.updateViews(viewDataSource: labelViews)
        
        
        self.view.addSubview(infinitePageScrollView2)
        infinitePageScrollView2.snp.makeConstraints { make in
            make.top.equalTo(infinitePageScrollView1.snp.bottom).offset(10)
            make.centerX.equalTo(self.view)
            //make.width.height.equalTo(infinitePageScrollView2.pageSize)
        }
        let labelViews2 = [makeTestLabel(text: "1", backgroundColor: .green), makeTestLabel(text: "2", backgroundColor: .blue),
                          makeTestLabel(text: "3", backgroundColor: .brown), makeTestLabel(text: "4", backgroundColor: .lightGray)]
        infinitePageScrollView2.updateViews(viewDataSource: labelViews2)
        
        infinitePageScrollView2.startAutoScroll(timeInterval: 3)
    }
    
    func makeTestLabel(text: String, backgroundColor: UIColor = .white) -> UILabel {
        let testLabel = UILabel()
        testLabel.backgroundColor = backgroundColor
        testLabel.text = text
        testLabel.font = UIFont.systemFont(ofSize: 30)
        testLabel.textAlignment = .center
        testLabel.textColor = .white
        
        return testLabel
    }
    
    
}
