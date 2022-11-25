//
//  ViewController.swift
//  GLCommonComponent
//
//  Created by gyu@genesislab.ai on 08/09/2022.
//  Copyright (c) 2022 gyu@genesislab.ai. All rights reserved.
//

import UIKit
import GLCommonComponent
import SnapKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    let screenSize = UIScreen.main.bounds.size
    let listTableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        makeListTableView()
        
    }
    
    func makeListTableView() {
        self.view.addSubview(listTableView)
        listTableView.register(UITableViewCell.self, forCellReuseIdentifier: "reuseIdentifier")
        listTableView.dataSource = self
        listTableView.delegate = self
        listTableView.snp.makeConstraints { make in
            make.left.top.equalTo(0)
            make.width.equalTo(screenSize.width)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide)
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 2
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        if indexPath.row == 0 {
            cell.textLabel?.text = "Infinite Page Scroll View"
        } else if indexPath.row == 1 {
            cell.textLabel?.text = "Particle Play View"
        }
        
        return cell
    }
     
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            print("didSelect")
            let infinitePageViewController = InfinitePageTestViewController()
            self.navigationController?.pushViewController(infinitePageViewController, animated: true)
        } else if indexPath.row == 1 {
            let particlePlayViewController = PartilcePlayViewTestViewController()
            self.navigationController?.pushViewController(particlePlayViewController, animated: true)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

