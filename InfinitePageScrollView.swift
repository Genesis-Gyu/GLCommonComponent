//
//  InfinitePageScrollView.swift
//  GLCommonComponent
//
//  Created by Gyu on 2022/11/18.
//

import UIKit
import SnapKit

public class InfinitePageScrollView: UIScrollView,UIScrollViewDelegate {

    public var pageSize = CGSize.zero
    var viewDataSource: Array<UIView> = Array()
    var allViews: Array<UIView> = Array()
    
    var fromForceIndexMove = false
    var revisionThreshouldValue: CGFloat = 80
    
    var scrolledRecentDate: Date?
    var isUseAutoScroll: Bool = false
    var autoScrollTimeInterval: TimeInterval = 5
    
    private override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    /**pageSize 페이지 넓이, 높이 입력, 무한스크롤뷰의 넓이 높이와 동일해야함*/
    public convenience init(pageSize: CGSize) {
        self.init()
        self.pageSize = pageSize
        self.isPagingEnabled = true
        self.showsHorizontalScrollIndicator = false
        
        self.delegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    public func updateViews(viewDataSource: Array<UIView>) {
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
            
            //let lastViewData = try! NSKeyedArchiver.archivedData(withRootObject: lastView, requiringSecureCoding: true)
            let lastViewData = NSKeyedArchiver.archivedData(withRootObject: lastView)
            let dummyLastViewFirstIndex = NSKeyedUnarchiver.unarchiveObject(with: lastViewData) as! UIView
            allViews.insert(dummyLastViewFirstIndex, at: 0)
            makeViewLayout(view: dummyLastViewFirstIndex, leftValue: Int(pageSize.width)*(1))
            
            let dummyLastViewZeroIndex = NSKeyedUnarchiver.unarchiveObject(with: lastViewData) as! UIView
            allViews.insert(dummyLastViewZeroIndex, at: 0)
            makeViewLayout(view: dummyLastViewZeroIndex, leftValue: Int(pageSize.width)*(0))
            
            
            
            let firstViewData = NSKeyedArchiver.archivedData(withRootObject: firstView)
            //뒤에 두개 더미 데이터 붙임
            let dummyFirstViewLastPlusOneIndex = NSKeyedUnarchiver.unarchiveObject(with: firstViewData) as! UIView
            allViews.append(dummyFirstViewLastPlusOneIndex)
            makeViewLayout(view: dummyFirstViewLastPlusOneIndex, leftValue: Int(pageSize.width)*(viewDataSource.count+2))
            
            let dummyFirstViewLastPluseTwoIndex = NSKeyedUnarchiver.unarchiveObject(with: firstViewData) as! UIView
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
    
    
    
    public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        tryForceIndexMove()
    }
    
    func tryForceIndexMove() {
        
        if allViews.count >= 2 {
            let currentPage = Int(self.contentOffset.x/pageSize.width)
            fromForceIndexMove = true
            
            if currentPage == 0 {
                self.contentOffset = CGPoint(x: pageSize.width * CGFloat(allViews.count-4), y: 0)
            } else if currentPage == 1 {
                self.contentOffset = CGPoint(x: pageSize.width * CGFloat(allViews.count-3), y: 0)
                
            } else if currentPage == (allViews.count-2) {
                self.contentOffset = CGPoint(x: pageSize.width*2, y: 0)
                
            } else if currentPage == (allViews.count-1) {
                self.contentOffset = CGPoint(x: pageSize.width*1, y: 0)
            } else {
                fromForceIndexMove = false
            }
            
            triggerForAutoBannerScroll()
        }
        
    }
    
    func triggerForAutoBannerScroll() {
        if isUseAutoScroll {
            scrolledRecentDate = Date()
            
            DispatchQueue.main.asyncAfter(deadline: .now()+autoScrollTimeInterval) {
                if Date().timeIntervalSince(self.scrolledRecentDate!) >= self.autoScrollTimeInterval {
                    if self.isDragging == false {
                        self.moveToNextPage()
                    }
                }
            }
        }
    }
    /**자동 스크롤 기능 사용, 시간 주기*/
    public func startAutoScroll(timeInterval: TimeInterval = 5) {
        isUseAutoScroll = true
        autoScrollTimeInterval = timeInterval
        triggerForAutoBannerScroll()
    }
    /**자동 스크롤 중지**/
    public func stopAutoScroll() {
        isUseAutoScroll = false
    }
    
    func moveToNextPage() {
        let currentPage = Int(self.contentOffset.x/pageSize.width)
        
        if currentPage+1 < allViews.count {
            UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut) {
                self.contentOffset = CGPoint(x: Int(self.pageSize.width)*(currentPage+1), y: 0)
                self.layoutIfNeeded()
            } completion: { _ in
                self.tryForceIndexMove()
            }
        }
    }
    
}


