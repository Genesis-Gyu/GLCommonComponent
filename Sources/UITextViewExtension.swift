//
//  UITextViewExtension.swift
//  Inception
//
//  Created by Gyu on 2022/08/05.
//

import UIKit

extension UITextView {
    
    /**
     UITextView안의 Text line 값을 계산하여 Int로 반환
    */
    
    public func lineCount() -> Int {
        
        let numberOfGlyphs = self.layoutManager.numberOfGlyphs
        var index = 0, numberOfLines = 0
        var lineRange = NSRange(location: NSNotFound, length: 0)

        while index < numberOfGlyphs {
            self.layoutManager.lineFragmentRect(forGlyphAt: index, effectiveRange: &lineRange)
            index = NSMaxRange(lineRange)
            numberOfLines += 1
        }
        
        return numberOfLines
    }
    
}
