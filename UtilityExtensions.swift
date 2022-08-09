//
//  UtilityExtensions.swift
//  Inception
//
//  Created by 봉규 on 2021/11/30.
//

import UIKit
/*
extension UILabel {
    func setGradationTextColor(gradientLayer: CAGradientLayer = GradientMaker.makeSecondaryOrangeGradientLayer()) {
        let textSize = self.sizeThatFits(CGSize(width: screenSize.width, height: screenSize.height))
        let textRect = CGRect(x: 0, y: 0, width: textSize.width, height: textSize.height)
        
        let gradientColor = ColorPallete.gradientColor(bounds: textRect,
                                                       gradientLayer: gradientLayer)
        
        self.textColor = gradientColor
    }
}*/


extension UIViewController {
    func showNetworkFailAlert() {
        let alertController = UIAlertController(title: "네트워크 연결 확인",
                                                message: "네트워크가 연결되어 있지 않습니다.\n데이터 네트워크 또는 Wi-Fi 설정을\n확인해 주세요.",
                                                preferredStyle: .alert)
        let okAction = UIAlertAction(title: "확인", style: .default)
        
        alertController.addAction(okAction)
        
        self.present(alertController, animated: true)
    }
    
    
    func showUnkwnonAlert() {
        let alertController = UIAlertController(title: "알림", message: "에러가 발생하였습니다. 에러가 지속되면 고객센터에 문의해 주세요", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "확인", style: .default)
        
        alertController.addAction(okAction)
        
        self.present(alertController, animated: true)
    }
}


extension Sequence where Element: Hashable {
    func uniqued() -> [Element] {
        var set = Set<Element>()
        return filter { set.insert($0).inserted }
    }
}

extension Array {
    func anyFlatten() -> [Any] {
        var res = [Any]()
        for val in self {
            if let arr = val as? [Any] {
                res.append(contentsOf: arr.anyFlatten())
            } else {
                res.append(val)
            }
        }

        return res
    }
}
