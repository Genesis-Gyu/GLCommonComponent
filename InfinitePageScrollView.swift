//
//  InfinitePageScrollView.swift
//  GLCommonComponent
//
//  Created by Gyu on 2022/11/18.
//

import UIKit
import SnapKit

class InfinitePageScrollView: UIScrollView,UIScrollViewDelegate {

    var pageSize = CGSize.zero
    var viewDataSource: Array<UIView> = Array()
    var allViews: Array<UIView> = Array()
    
    var fromForceIndexMove = false
    var revisionThreshouldValue: CGFloat = 80
    
    init(pageSize: CGSize) {
        super.init(frame: CGRect.zero)
        self.pageSize = pageSize
        self.isPagingEnabled = true
        self.showsHorizontalScrollIndicator = false
        
        self.delegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    func updateViews(viewDataSource: Array<UIView>) {
        removeAllViews()
        self.viewDataSource = viewDataSource
        
        if viewDataSource.count == 0 {
            
        } else if viewDataSource.count == 1 {
            let view = viewDataSource.first!
            allViews.append(view)
            makeViewLayout(view: view, leftValue: 0)
            
            self.layoutIfNeeded()
            
            self.contentSize = CGSize(width: 0, height: 0)
            self.contentOffset = CGPoint(x: 0, y: 0)
            
        } else {
            for index in 0...viewDataSource.count-1 {
                let view = viewDataSource[index]
                allViews.append(view)
                
                let leftValue = Int(pageSize.width)*(index+2)
                makeViewLayout(view: view, leftValue: leftValue)
            }
            
            let firstView = viewDataSource[0]
            let lastView = viewDataSource.last!
            
            //앞에 두개 더미 데이터 붙임
            let lastViewData = try! NSKeyedArchiver.archivedData(withRootObject: lastView, requiringSecureCoding: false)
            
            let dummyLastViewFirstIndex = try! NSKeyedUnarchiver.unarchivedObject(ofClass: UIView.self, from: lastViewData)!
            allViews.insert(dummyLastViewFirstIndex, at: 0)
            makeViewLayout(view: dummyLastViewFirstIndex, leftValue: Int(pageSize.width)*(1))
            
            let dummyLastViewZeroIndex = try! NSKeyedUnarchiver.unarchivedObject(ofClass: UIView.self, from: lastViewData)!
            allViews.insert(dummyLastViewZeroIndex, at: 0)
            makeViewLayout(view: dummyLastViewZeroIndex, leftValue: Int(pageSize.width)*(0))
            
            
            
            let firstViewData = try! NSKeyedArchiver.archivedData(withRootObject: firstView, requiringSecureCoding: false)
            //뒤에 두개 더미 데이터 붙임
            let dummyFirstViewLastPlusOneIndex = try! NSKeyedUnarchiver.unarchivedObject(ofClass: UIView.self, from: firstViewData)!
            allViews.append(dummyFirstViewLastPlusOneIndex)
            makeViewLayout(view: dummyFirstViewLastPlusOneIndex, leftValue: Int(pageSize.width)*(viewDataSource.count+2))
            
            let dummyFirstViewLastPluseTwoIndex = try! NSKeyedUnarchiver.unarchivedObject(ofClass: UIView.self, from: firstViewData)!
            allViews.append(dummyFirstViewLastPluseTwoIndex)
            makeViewLayout(view: dummyFirstViewLastPluseTwoIndex, leftValue: Int(pageSize.width)*(viewDataSource.count+3))
            
            self.layoutIfNeeded()
            
            self.contentSize = CGSize(width: CGFloat(allViews.count)*pageSize.width, height: 0)
            self.contentOffset = CGPoint(x: pageSize.width*2, y: 0)
        }
    }
    
    func makeViewLayout(view: UIView, leftValue: Int) {
        self.addSubview(view)
        view.snp.makeConstraints { make in
            make.top.equalTo(0)
            make.width.equalTo(pageSize.width)
            make.height.equalTo(pageSize.height)
            make.left.equalTo(leftValue)
        }
    }
    
    private func removeAllViews() {
        for view in allViews {
            view.removeFromSuperview()
        }
        allViews.removeAll()
    }
    
    
}
