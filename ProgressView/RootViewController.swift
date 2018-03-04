//
//  RootViewController.swift
//  ProgressView
//
//  Created by Hoang Luyen on 3/4/18.
//  Copyright © 2018 Hoang Luyen. All rights reserved.
//

import UIKit

class RootViewController: UIViewController {

    @IBOutlet weak var progressView: UIProgressView!
    var pageView = PageViewController.shared.pageviewcontrollerDataSource.pageViewcontrollers
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        progressView.progress = 1/Float(pageView.count)
        recieveNotification()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func recieveNotification(){
        NotificationCenter.default.addObserver(self, selector: #selector(changeprogress), name: Notification.Name.init("key"), object: nil)
    }
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    @objc func changeprogress(_ notification: Notification) {
        let index = notification.object as! Int
        let fractionalProgress = Float(index) / Float(pageView.count)
        progressView.setProgress(fractionalProgress, animated: true)
    }

}
