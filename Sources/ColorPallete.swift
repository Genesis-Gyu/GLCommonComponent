//
//  ColorPallete.swift
//  ViewInterHR
//
//  Created by 봉규 on 05/09/2019.
//  Copyright © 2019 GenesisLab. All rights reserved.
//

import UIKit

public class ColorPallete: NSObject {
    
    class func RGBA(r:CGFloat, g:CGFloat, b:CGFloat, a:CGFloat) -> UIColor {
        return UIColor.init(displayP3Red: r/255.0, green: g/255.0, blue: b/255.0, alpha: a)
    }
    
    class func imageWithColor(color:UIColor, frame: CGRect = CGRect(x: 0, y: 0, width: 50, height: 50)) -> UIImage {
        
        UIGraphicsBeginImageContext(frame.size);
        let context = UIGraphicsGetCurrentContext();
        
        context?.setFillColor(color.cgColor)
        context?.fill(frame)
        
        let image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        return image!
    }
    
    class func gradientColor(bounds: CGRect, gradientLayer :CAGradientLayer) -> UIColor? {
        
        gradientLayer.frame = bounds
        
        UIGraphicsBeginImageContext(gradientLayer.bounds.size)
          //create UIImage by rendering gradient layer.
        
        if let context = UIGraphicsGetCurrentContext() {
            gradientLayer.render(in: context)
            let image = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
              //get gradient UIcolor from gradient UIImage
            return UIColor(patternImage: image!)
        } else {
            return nil
        }
    }
    
    
}
