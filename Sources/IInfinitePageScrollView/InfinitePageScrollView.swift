//
//  InfinitePageScrollView.swift
//  GLCommonComponent
//
//  Created by Gyu on 2022/11/18.
//

import UIKit
//import Snapkit

class InfinitePageScrollView: UIScrollView, UIScrollViewDelegate {

    var bannerScrolledRecentDate: Date?
    var dataSourceViews: Array<UIView> = Array()
    var viewSize: CGSize = UIScreen.main.bounds.size
    private var allViews: Array<UIView> = Array()
    
    var fromForceIndexMove = false
    var revisionThreshouldValue: CGFloat = 80
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.isPagingEnabled = true
        self.showsHorizontalScrollIndicator = false
        
        self.delegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    /*
    func updateContents(views:Array<UIView>, viewSize: CGSize = UIScreen.main.bounds.size) {
        removeAllViews()
        dataSourceViews.removeAll()
        dataSourceViews = views
        self.viewSize = viewSize
        
        if dataSourceViews.count == 0 {
            
        } else if dataSourceViews.count == 1 {
            
            let firstView = views.first!
            allViews.append(firstView)
            makeBannerImageViewLayout(bannerImageView: bannerImageView, leftValue: 0)
            
            self.layoutIfNeeded()
            
            self.contentSize = CGSize(width: 0, height: 0)
            self.contentOffset = CGPoint(x: 0, y: 0)
            
            
        } else {
            
        }
        if serviceContentBannerArray.count > 1 {
            for index in 0...serviceContentBannerArray.count-1 {
                
                let serviceContentBanner = serviceContentBannerArray[index]
                
                let bannerImageView = BannerImageView(serviceContentBanner: serviceContentBanner)
                bannerImageView.contentSequence = index+1
                bannerImageViewArray.append(bannerImageView)
                
                let leftValue = Int(screenSize.width)*(index+2)
                makeBannerImageViewLayout(bannerImageView: bannerImageView, leftValue: leftValue)
            }
            
            
            if bannerImageViewArray.count > 1 {
                let firstBannerImageView = bannerImageViewArray[0]
                let lastBannerImageView = bannerImageViewArray[bannerImageViewArray.count-1]
                
                //앞에 두개 더미 데이터 붙임
                let first_firstIndexDummyImageView = BannerImageView(serviceContentBanner: lastBannerImageView.assignedServiceContentBanner)
                first_firstIndexDummyImageView.contentSequence = lastBannerImageView.contentSequence
                bannerImageViewArray.insert(first_firstIndexDummyImageView, at: 0)
                makeBannerImageViewLayout(bannerImageView: first_firstIndexDummyImageView, leftValue: Int(screenSize.width)*(1))
                
                let first_zeroIndexDummyImageView = BannerImageView(serviceContentBanner: firstBannerImageView.assignedServiceContentBanner)
                first_zeroIndexDummyImageView.contentSequence = firstBannerImageView.contentSequence
                bannerImageViewArray.insert(first_zeroIndexDummyImageView, at: 0)
                makeBannerImageViewLayout(bannerImageView: first_zeroIndexDummyImageView, leftValue: Int(screenSize.width)*(0))
                
                
                //뒤에 두개 더미 데이터 붙임
                let lastPlusOneIndexDummyImageView = BannerImageView(serviceContentBanner: firstBannerImageView.assignedServiceContentBanner)
                bannerImageViewArray.append(lastPlusOneIndexDummyImageView)
                makeBannerImageViewLayout(bannerImageView: lastPlusOneIndexDummyImageView, leftValue: Int(screenSize.width)*(serviceContentBannerArray.count+2))
                
                let lastPlusTwoIndexDummyImageView = BannerImageView(serviceContentBanner: lastBannerImageView.assignedServiceContentBanner)
                bannerImageViewArray.append(lastPlusTwoIndexDummyImageView)
                makeBannerImageViewLayout(bannerImageView: lastPlusTwoIndexDummyImageView, leftValue: Int(screenSize.width)*(serviceContentBannerArray.count+3))
            }
            
            self.layoutIfNeeded()
            
            self.contentSize = CGSize(width: CGFloat(bannerImageViewArray.count)*screenSize.width, height: 0)
            self.contentOffset = CGPoint(x: screenSize.width*2, y: 0)
            
        } else if serviceContentBannerArray.count == 1 {
            let serviceContentBanner = serviceContentBannerArray.first!
            let bannerImageView = BannerImageView(serviceContentBanner: serviceContentBanner)
            bannerImageView.contentSequence = 1
            bannerImageViewArray.append(bannerImageView)
            makeBannerImageViewLayout(bannerImageView: bannerImageView, leftValue: 0)
            
            self.layoutIfNeeded()
            
            self.contentSize = CGSize(width: 0, height: 0)
            self.contentOffset = CGPoint(x: 0, y: 0)
        }
    }
    
    func makeViewLayout(view: UIView, leftValue: Int) {
        self.addSubview(view)
        view.snp.makeConstraints { make in
            make.top.equalTo(0)
            make.left.equalTo(leftValue)
            make.width.equalTo(viewSize.width)
            make.height.equalTo(viewSize.height)
        }
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(touchImageViewTapped(event:)))
        tapGesture.numberOfTapsRequired = 1
        bannerImageView.addGestureRecognizer(tapGesture)
        
        bannerImageView.isUserInteractionEnabled = true
    }
    
    
    private func removeAllViews() {
        for view in allViews {
            view.removeFromSuperview()
        }
        allViews.removeAll()
    }
    
    
    func makeContent(_serviceContentBannerArray: [ServiceContentBanner]) {
        serviceContentBannerArray = _serviceContentBannerArray
        removeBanneerImageViews()
        
        if serviceContentBannerArray.count > 1 {
            for index in 0...serviceContentBannerArray.count-1 {
                
                let serviceContentBanner = serviceContentBannerArray[index]
                
                let bannerImageView = BannerImageView(serviceContentBanner: serviceContentBanner)
                bannerImageView.contentSequence = index+1
                bannerImageViewArray.append(bannerImageView)
                
                let leftValue = Int(screenSize.width)*(index+2)
                makeBannerImageViewLayout(bannerImageView: bannerImageView, leftValue: leftValue)
            }
            
            
            if bannerImageViewArray.count > 1 {
                let firstBannerImageView = bannerImageViewArray[0]
                let lastBannerImageView = bannerImageViewArray[bannerImageViewArray.count-1]
                
                //앞에 두개 더미 데이터 붙임
                let first_firstIndexDummyImageView = BannerImageView(serviceContentBanner: lastBannerImageView.assignedServiceContentBanner)
                first_firstIndexDummyImageView.contentSequence = lastBannerImageView.contentSequence
                bannerImageViewArray.insert(first_firstIndexDummyImageView, at: 0)
                makeBannerImageViewLayout(bannerImageView: first_firstIndexDummyImageView, leftValue: Int(screenSize.width)*(1))
                
                let first_zeroIndexDummyImageView = BannerImageView(serviceContentBanner: firstBannerImageView.assignedServiceContentBanner)
                first_zeroIndexDummyImageView.contentSequence = firstBannerImageView.contentSequence
                bannerImageViewArray.insert(first_zeroIndexDummyImageView, at: 0)
                makeBannerImageViewLayout(bannerImageView: first_zeroIndexDummyImageView, leftValue: Int(screenSize.width)*(0))
                
                
                //뒤에 두개 더미 데이터 붙임
                let lastPlusOneIndexDummyImageView = BannerImageView(serviceContentBanner: firstBannerImageView.assignedServiceContentBanner)
                bannerImageViewArray.append(lastPlusOneIndexDummyImageView)
                makeBannerImageViewLayout(bannerImageView: lastPlusOneIndexDummyImageView, leftValue: Int(screenSize.width)*(serviceContentBannerArray.count+2))
                
                let lastPlusTwoIndexDummyImageView = BannerImageView(serviceContentBanner: lastBannerImageView.assignedServiceContentBanner)
                bannerImageViewArray.append(lastPlusTwoIndexDummyImageView)
                makeBannerImageViewLayout(bannerImageView: lastPlusTwoIndexDummyImageView, leftValue: Int(screenSize.width)*(serviceContentBannerArray.count+3))
            }
            
            self.layoutIfNeeded()
            
            self.contentSize = CGSize(width: CGFloat(bannerImageViewArray.count)*screenSize.width, height: 0)
            self.contentOffset = CGPoint(x: screenSize.width*2, y: 0)
            
        } else if serviceContentBannerArray.count == 1 {
            let serviceContentBanner = serviceContentBannerArray.first!
            let bannerImageView = BannerImageView(serviceContentBanner: serviceContentBanner)
            bannerImageView.contentSequence = 1
            bannerImageViewArray.append(bannerImageView)
            makeBannerImageViewLayout(bannerImageView: bannerImageView, leftValue: 0)
            
            self.layoutIfNeeded()
            
            self.contentSize = CGSize(width: 0, height: 0)
            self.contentOffset = CGPoint(x: 0, y: 0)
        }
        
        
    }
    
    
    
    
    
    @objc func touchImageViewTapped(event: UITapGestureRecognizer) {
        if let bannerImageView = event.view as? BannerImageView {
            imageViewTappedSubject.onNext(bannerImageView)
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let currentPage = Int(self.contentOffset.x/screenSize.width)
        updatePageControl(currentPage: currentPage)
        
        let currentPageValue = screenSize.width*CGFloat(currentPage)
        
        if self.contentOffset.x >= currentPageValue &&
            self.contentOffset.x < currentPageValue+screenSize.width {
            var revisionValue = (self.contentOffset.x-currentPageValue)/4
            if revisionValue >= revisionThreshouldValue {
                revisionValue = revisionThreshouldValue
            }
            
            if currentPage >= 0 && currentPage < (bannerImageViewArray.count-1) {
                var prevBannerImageView: BannerImageView? = nil
                var nextBannerImageView: BannerImageView? = nil
                
                let currentBannerImageView = bannerImageViewArray[currentPage]
                
                if currentPage == 0 {
                    nextBannerImageView = bannerImageViewArray[currentPage+1]
                    prevBannerImageView = nil
                } else if currentPage == bannerImageViewArray.count-1 {
                    prevBannerImageView = bannerImageViewArray[currentPage-1]
                    nextBannerImageView = nil
                } else {
                    nextBannerImageView = bannerImageViewArray[currentPage+1]
                    prevBannerImageView = bannerImageViewArray[currentPage-1]
                }
                
                currentBannerImageView.dimImageView.alpha = revisionValue*(1/revisionThreshouldValue)*0.5
                currentBannerImageView.contentOffset = CGPoint(x: -revisionValue, y: 0)
                currentBannerImageView.largeTitleLabel.alpha = 1
                currentBannerImageView.subTitleLabel.alpha = 1
                
                if let nextBannerImageView = nextBannerImageView {
                    nextBannerImageView.contentOffset = CGPoint(x: 0, y: 0)
                    nextBannerImageView.largeTitleLabel.alpha = revisionValue*(1/revisionThreshouldValue)
                    nextBannerImageView.subTitleLabel.alpha = nextBannerImageView.largeTitleLabel.alpha
                    nextBannerImageView.dimImageView.alpha = 0
                    
                    nextBannerImageView.subTitleLabel.snp.updateConstraints { make in
                        make.left.equalTo(20+revisionThreshouldValue-revisionValue)
                    }
                }
                
                if let prevBannerImageView = prevBannerImageView {
                    prevBannerImageView.largeTitleLabel.alpha = 1
                    prevBannerImageView.subTitleLabel.alpha = 1
                    prevBannerImageView.dimImageView.alpha = 0.5
                    
                    prevBannerImageView.subTitleLabel.snp.updateConstraints { make in
                        make.left.equalTo(20)
                    }
                }
                
                if fromForceIndexMove {
                    let appearedBannerImageView = bannerImageViewArray[currentPage]
                    appearedBannerImageView.largeTitleLabel.alpha = 1
                    appearedBannerImageView.subTitleLabel.alpha = 1
                    appearedBannerImageView.dimImageView.alpha = 0
                    
                    appearedBannerImageView.subTitleLabel.snp.updateConstraints { make in
                        make.left.equalTo(20)
                    }
                }
                
            }
        }
        fromForceIndexMove = false
        
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        tryForceIndexMove()
    }
    
    func tryForceIndexMove() {
        
        if bannerImageViewArray.count >= 2{
            let currentPage = Int(self.contentOffset.x/screenSize.width)
            
            fromForceIndexMove = true
            
            if currentPage == 0 {
                self.contentOffset = CGPoint(x: screenSize.width * CGFloat(bannerImageViewArray.count-4), y: 0)
            } else if currentPage == 1 {
                self.contentOffset = CGPoint(x: screenSize.width * CGFloat(bannerImageViewArray.count-3), y: 0)
                
            } else if currentPage == (bannerImageViewArray.count-2) {
                self.contentOffset = CGPoint(x: screenSize.width*2, y: 0)
                
            } else if currentPage == (bannerImageViewArray.count-1) {
                self.contentOffset = CGPoint(x: screenSize.width*1, y: 0)
            } else {
                fromForceIndexMove = false
            }
            
            triggerForAutoBannerScroll()
        }
        
    }
    
    func moveToNextPage() {
        let currentPage = Int(self.contentOffset.x/screenSize.width)
        
        if currentPage+1 < bannerImageViewArray.count {
            let bannerImageView = bannerImageViewArray[currentPage]
            let nextBannerImageView = bannerImageViewArray[currentPage+1]
            
            nextBannerImageView.subTitleLabel.snp.updateConstraints { make in
                make.left.equalTo(100)
            }
            self.layoutIfNeeded()
            
            nextBannerImageView.subTitleLabel.snp.updateConstraints { make in
                make.left.equalTo(20)
            }
            
            UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut) {
                self.contentOffset = CGPoint(x: Int(screenSize.width)*(currentPage+1), y: 0)
                
                bannerImageView.contentOffset = CGPoint(x: -self.revisionThreshouldValue, y: 0)
                bannerImageView.dimImageView.alpha = 0.5
                
                nextBannerImageView.largeTitleLabel.alpha = 1
                nextBannerImageView.subTitleLabel.alpha = nextBannerImageView.largeTitleLabel.alpha
                
                self.layoutIfNeeded()
            } completion: { _ in
                self.tryForceIndexMove()
            }
        }
    }
    
    func triggerForAutoBannerScroll() {
        bannerScrolledRecentDate = Date()
        
        DispatchQueue.main.asyncAfter(deadline: .now()+5) {
            if Date().timeIntervalSince(self.bannerScrolledRecentDate!) > 5 {
                //print("self is DRagging = \(self.isDragging)")
                if self.isDragging == false {
                    self.moveToNextPage()
                }
            }
        }
    }
    
    func updatePageControl(currentPage: Int) {
        if let improvedMainViewController = self.findViewController() as? ImprovedMainViewController {
            if currentPage <= 1 || currentPage >= bannerImageViewArray.count-2 {
                
            } else {
                let parsedPage = currentPage - 2
                improvedMainViewController.contentRecommendTopContentView.pageControl.currentPage = parsedPage
            }
        }
    }
}
*/
