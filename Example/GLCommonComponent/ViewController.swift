//
//  ViewController.swift
//  GLCommonComponent
//
//  Created by gyu@genesislab.ai on 08/09/2022.
//  Copyright (c) 2022 gyu@genesislab.ai. All rights reserved.
//

import UIKit
import GLCommonComponent

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let viewController = self.view.findViewController() as? ViewController {
            print("viewcontoller \(viewController)")
        }
        print("self.view.findViewController() : \(self.view.findViewController())")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

