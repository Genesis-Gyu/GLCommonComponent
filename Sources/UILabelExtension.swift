//
//  UILabelExtension.swift
//  Inception
//
//  Created by Gyu on 2022/08/05.
//

import UIKit

extension UILabel {

    /**
     UILabel안의 Text line 값을 계산하여 Int로 반환
    */
    public func lineCount() -> Int {
        guard let text = self.text as NSString? else { return 0 }
        guard let font = self.font              else { return 0 }
        
        var attributes = [NSAttributedString.Key: Any]()
        
        // kern을 설정하면 자간 간격이 조정되기 때문에, 크기에 영향을 미칠 수 있습니다.
        if let kernAttribute = self.attributedText?.attributes(at: 0, effectiveRange: nil).first(where: { key, _ in
            return key == .kern
        }) {
            attributes[.kern] = kernAttribute.value
        }
        attributes[.font] = font
        
        // width을 제한한 상태에서 해당 Text의 Height를 구하기 위해 boundingRect 사용
        let labelTextSize = text.boundingRect(
            with: CGSize(width: self.bounds.width, height: .greatestFiniteMagnitude),
            options: .usesLineFragmentOrigin,
            attributes: attributes,
            context: nil
        )
        
        // 총 Height에서 한 줄의 Line Height를 나누면 현재 총 Line 수
        return Int(ceil(labelTextSize.height / font.lineHeight))
    }
 
    func setGradationTextColor(gradientLayer: CAGradientLayer) {
        let screenSize = UIScreen.main.bounds.size
        let textSize = self.sizeThatFits(CGSize(width: screenSize.width, height: screenSize.height))
        let textRect = CGRect(x: 0, y: 0, width: textSize.width, height: textSize.height)
        
        let gradientColor = ColorPallete.gradientColor(bounds: textRect,
                                                       gradientLayer: gradientLayer)
        
        self.textColor = gradientColor
        
    }
}
