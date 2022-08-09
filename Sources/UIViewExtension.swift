//
//  UIViewExtension.swift
//  Inception
//
//  Created by Gyu on 2022/08/05.
//

import UIKit

extension UIView {
    /**
     해당 컴포넌트가 종속되어있는 ViewController를 Return
    */
    
    open func findViewController() -> UIViewController? {
        if let nextResponder = self.next as? UIViewController {
            return nextResponder
        } else if let nextResponder = self.next as? UIView {
            return nextResponder.findViewController()
        } else {
            return nil
        }
    }
    
}
