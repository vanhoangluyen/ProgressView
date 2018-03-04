
//
//  PageViewController.swift
//  ProgressView
//
//  Created by Hoang Luyen on 3/4/18.
//  Copyright © 2018 Hoang Luyen. All rights reserved.
//

import UIKit

class PageViewController: UIPageViewController {

    static let shared: PageViewController = PageViewController()
    var pageviewcontrollerDataSource = PageViewControllerDataSource()
    var startViewControllerIndex = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.dataSource = pageviewcontrollerDataSource
        jum(toIndex: startViewControllerIndex)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func jum(toIndex: Int, animated: Bool = true) {
        guard toIndex != NSNotFound && toIndex >= 0 else {return}
        let direction: UIPageViewControllerNavigationDirection = toIndex > 0 ? .forward : .reverse
        if let viewController = pageviewcontrollerDataSource.viewcontrollerAtIndex(toIndex) {
            self.setViewControllers([viewController], direction: direction, animated: true, completion: {done in})
        }
    }
}
//MARK: - PageViewController Datasource
class PageViewControllerDataSource: NSObject, UIPageViewControllerDataSource {
    
    lazy var pageViewcontrollers: [UIViewController] = {
        return [
            self.getViewController(withIdentifier: "YellowViewController"),
            self.getViewController(withIdentifier: "BlueViewController"),
            self.getViewController(withIdentifier: "RedViewController"),
            self.getViewController(withIdentifier: "GreenViewController")
        ]
    }()
    
    func getViewController(withIdentifier identifier: String) -> UIViewController
    {
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: identifier)
    }
    func viewcontrollerAtIndex(_ index: Int) -> UIViewController? {
        // Return the data view controller for the given index.
        if (pageViewcontrollers.count == 0 || index >= pageViewcontrollers.count || index < 0 || index == NSNotFound) {
            return nil
        }
        NotificationCenter.default.post(name: Notification.Name.init("key"), object: (index + 1))
        return pageViewcontrollers[index]
    }
    func indexOfViewController(_ viewcontroller: UIViewController) -> Int {
        return pageViewcontrollers.index(of: viewcontroller) ?? NSNotFound
    }
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        let index = indexOfViewController(viewController)
        return viewcontrollerAtIndex(index - 1)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        let index = indexOfViewController(viewController)
        return viewcontrollerAtIndex(index + 1)
    }
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return pageViewcontrollers.count
    }
    //    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
    //
    //    }
    
}
