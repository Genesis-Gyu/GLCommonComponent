//
//  StringExtension.swift
//  Inception
//
//  Created by Gyu on 2022/08/05.
//

import UIKit

extension String {
    
    /**
     String을 NSMutableAttributedString으로 변환 textColor, UIFont, linespacing, NSTextAlignment 적용 가능
     - Returns: NSMutableAttributedString
    */
    public func makeAttributedString(textColor: UIColor = .black,
                              font: UIFont, lineSpacing: CGFloat = 0,
                              textAlignment: NSTextAlignment = .left) -> NSMutableAttributedString {
        
        let attributedString = NSMutableAttributedString(string: self)
        
        attributedString.addAttribute(.font, value: font, range: attributedString.fullRange())
        attributedString.addAttribute(.foregroundColor, value: textColor, range: attributedString.fullRange())
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = lineSpacing
        paragraphStyle.alignment = textAlignment
        paragraphStyle.lineBreakMode = .byTruncatingTail
        
        attributedString.addAttribute(.paragraphStyle, value: paragraphStyle, range: attributedString.fullRange())
        
        return attributedString
    }
    
    func ranges(of substring: String, options: CompareOptions = [], locale: Locale? = nil) -> [Range<Index>] {
        var ranges: [Range<Index>] = []
        while let range = range(of: substring, options: options, range: (ranges.last?.upperBound ?? self.startIndex)..<self.endIndex, locale: locale) {
            ranges.append(range)
        }
        return ranges
    }
    
    
    /**
     String안의 특정키워드의 Index를 Array로 반환
     - Returns: Array<NSRange>
    */
    public func subStringNSRanges(keyword: String) -> Array<NSRange> {
        
        var array: Array<NSRange> = Array()
        
        let stringToNSString = self as NSString
        
        var searchRange = NSMakeRange(0, 0)
        var foundRange: NSRange
        while (searchRange.location < stringToNSString.length) {
            
            searchRange.length = stringToNSString.length-searchRange.location;
            foundRange = stringToNSString.range(of: keyword, options: .caseInsensitive, range: searchRange)
            
            if foundRange.location != NSNotFound {
                array.append(foundRange)
                searchRange.location = foundRange.location+foundRange.length
                
            } else {
                break;
            }
        }
        
        return array
        
    }
    
    
    /**
     Dictionary 형태의 string을 Dictionary로 변환
     - Warning: String이 Dictionary 형태여야만 nil값이 아닌 Dictionary가 반환.
    */
    public func convertToDictionary() -> [String: Any]? {
        if self.count > 0, let data = data(using: .utf8) {
            //print("self string \(self)")
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            } catch {
                print("error!! \(error)")
            }
            //return try! JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
        }
        return nil
    }
    
    /**
     String 안의 whitespace와 Newlines 제거
    */
    public func trimmedText() -> String {
        return self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    /**
     String 안에 한글이 있는지 체크
    */
    public func isExistHangul(filter:String = "[가-힣]") -> Bool {
        let regex = try! NSRegularExpression(pattern: filter, options: [])
        let list = regex.matches(in:self, options: [], range:NSRange.init(location: 0, length:self.count))

        if(list.count != self.count){
            return false
        }

        return true
    }
    
    /**
     String 안에 알파벳이 있는지 체크
    */
    public func isExistAlphabet() -> Bool {
        let expression = ".*[A-Za-z]+.*"
        let expressionValid = NSPredicate(format: "SELF MATCHES %@", expression)
        
        return expressionValid.evaluate(with:self)
    }
    /**
     String 안에 숫자가 있는지 체크
    */
    public func isExistNumber() -> Bool {
        let expression = ".*[0-9]+.*"
        let expressionValid = NSPredicate(format: "SELF MATCHES %@", expression)
        
        return expressionValid.evaluate(with:self)
    }
    /**
     String 안에 특수문자가 있는지 체크
    */
    public func isExistSpecialCharacter() -> Bool {
        
        let expression = ".*[\\W_]+.*"
        let expressionValid = NSPredicate(format: "SELF MATCHES %@", expression)
        
        return expressionValid.evaluate(with:self)
    }
    
    
    /**
     String이 email형태가 맞는지 체크
    */
    public func isValidEmail() -> Bool {
        let expression = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let expressionValid = NSPredicate(format: "SELF MATCHES %@", expression)
        
        return expressionValid.evaluate(with:self)
    }
    
    /**
     String 안에 알파벳 대문자가 있는지 체크
    */
    public func isExistUppercaseAlphabet() -> Bool {
        let expression = ".*[A-Z]+.*"
        let expressionValid = NSPredicate(format: "SELF MATCHES %@", expression)
        
        return expressionValid.evaluate(with:self)
    }
    
    /**
     String 안에 알파벳 소문자가 있는지 체크
    */
    public func isExistLowercaseAlphabet() -> Bool {
        let expression = ".*[a-z]+.*"
        let expressionValid = NSPredicate(format: "SELF MATCHES %@", expression)
        
        return expressionValid.evaluate(with:self)
    }
    
    
    /**
     String이 알파벳,숫자,한글로 구성되어있는지 체크
    */
    public func isValidNickname() -> Bool {
        let expression = "[A-Za-z0-9가-힣]+"
        let expressionValid = NSPredicate(format: "SELF MATCHES %@", expression)
        
        return expressionValid.evaluate(with:self)
    }
    
    
    
}



extension NSMutableAttributedString {
    /// NSMutableAttributedString의 총 길이를 NSRange로 변환
    /// - Returns: NSRange
    ///
    func fullRange() -> NSRange {
        return NSMakeRange(0, self.length)
    }
    
    
    /**
     NSMutableAttributedString 안에 특정 키워드가 있다면 그 키워드의 Font와, Color 값 변경
    */

    public func modifyAttribute(keywordArray: Array<String>,
                         font: UIFont, textColor: UIColor) {
        
        for keyword in keywordArray {
            let subRanges = string.subStringNSRanges(keyword: keyword)
            for subRange in subRanges {
                if subRange.location != NSNotFound {
                    self.addAttribute(.font, value: font, range: subRange)
                    self.addAttribute(.foregroundColor, value: textColor, range: subRange)
                }
            }
        }
    }
    
}
