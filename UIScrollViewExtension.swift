//
//  UIScrollViewExtension.swift
//  Inception
//
//  Created by Gyu on 2022/08/05.
//

import UIKit

extension UIScrollView {
    
    public func scrollToTop() {
        setContentOffset(CGPoint(x: 0, y: 0), animated: true)
    }
    
    
    public func scrollToBottom() {
        let bottomOffset = CGPoint(x: 0, y: contentSize.height - bounds.size.height + contentInset.bottom)
        if(bottomOffset.y > 0) {
            setContentOffset(bottomOffset, animated: true)
        }
    }
}
