//
//  UIButtonExtension.swift
//  Inception
//
//  Created by Gyu on 2022/08/05.
//

import UIKit

extension UIButton {
    /**
     UIButton안의 Content들 Inset값 조정, 좌측에 이미지, 우측에 타이틀
    */
    public func setInsets(forContentPadding contentPadding: UIEdgeInsets, imageTitlePadding: CGFloat) {
        self.contentEdgeInsets = UIEdgeInsets(
            top: contentPadding.top,
            left: contentPadding.left,
            bottom: contentPadding.bottom,
            right: contentPadding.right + imageTitlePadding
        )
        
        self.titleEdgeInsets = UIEdgeInsets(
            top: 0,
            left: imageTitlePadding,
            bottom: 0,
            right: -imageTitlePadding
        )
    }
    
    /**
     UIButton안의 Title 영역의 값을 return
    */
    public func buttonTitleLabelRect() -> CGRect {
        let screenSize = UIScreen.main.bounds.size
        let size = self.sizeThatFits(CGSize(width: screenSize.width, height: screenSize.height))
        return CGRect(x: 0, y: 0, width: size.width, height: size.height)
    }
}
