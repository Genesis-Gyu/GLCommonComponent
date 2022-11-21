//
//  FontPallete.swift
//  ViewInter
//
//  Created by 봉규 on 2018. 7. 4..
//  Copyright © 2018년 GenesisLab. All rights reserved.
//

import UIKit

public class FontPallete: NSObject {
    
    class func showFontList() {
        for family in UIFont.familyNames {
            print("family:", family)
            for font in UIFont.fontNames(forFamilyName: family) {
                print("font:", font)
            }
        }
    }
    
}
