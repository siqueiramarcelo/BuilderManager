//
//  ModelController.swift
//  Builder Manager
//
//  Created by Marcelo Siqueira on 29/09/17.
//  Copyright © 2017 Marcelo Siqueira. All rights reserved.
//

import UIKit

/*
 A controller object that manages a simple model -- a collection of "builders".
 
 The controller serves as the data source for the page view controller; it therefore implements pageViewController:viewControllerBeforeViewController: and pageViewController:viewControllerAfterViewController:.
 It also implements a custom method, viewControllerAtIndex: which is useful in the implementation of the data source methods, and in the initial configuration of the application.
 
 There is no need to actually create view controllers for each page in advance -- indeed doing so incurs unnecessary overhead. Given the data model, these methods create, configure, and return a new view controller on demand.
 */


class ModelController: NSObject, UIPageViewControllerDataSource {

    var pageData: [String] = []

    override init() {
        super.init()
        // Create the data model.
        //let dateFormatter = DateFormatter()
        //pageData = dateFormatter.monthSymbols
        pageData = ["Pilgrim","Peregrino","Peregrine","MindPilgrim"]
        
        // update user defaults
        let appDomain = Bundle.main.bundleIdentifier!
        //UserDefaults.standard.removePersistentDomain(forName: appDomain)
        
        for i in (0..<pageData.count) {
            
            var deadlineNow = "deadline" + String(i) + "_0"
            
            if defaults.object(forKey: deadlineNow) == nil {
                
                for j in 0...4 {
                    
                    deadlineNow = deadlineNow + "_" + String(j)
                    defaults.set(0, forKey: deadlineNow)
                    
                }
                
                defaults.synchronize()
            }
            
        }
        
    }

    func viewControllerAtIndex(_ index: Int, storyboard: UIStoryboard) -> DataViewController? {
        // Return the data view controller for the given index.
        if (self.pageData.count == 0) || (index >= self.pageData.count) {
            return nil
        }

        // Create a new view controller and pass suitable data.
        let dataViewController = storyboard.instantiateViewController(withIdentifier: "DataViewController") as! DataViewController
        
        // pass data
        dataViewController.accountIndex = index
        dataViewController.dataObject = self.pageData[index]
        
        return dataViewController
    }

    func indexOfViewController(_ viewController: DataViewController) -> Int {
        // Return the index of the given data view controller.
        // For simplicity, this implementation uses a static array of model objects and the view controller stores the model object; you can therefore use the model object to identify the index.
        return pageData.index(of: viewController.dataObject) ?? NSNotFound
    }

    // MARK: - Page View Controller Data Source

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        var index = self.indexOfViewController(viewController as! DataViewController)
        if (index == 0) || (index == NSNotFound) {
            return nil
        }
        
        index -= 1
        return self.viewControllerAtIndex(index, storyboard: viewController.storyboard!)
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        var index = self.indexOfViewController(viewController as! DataViewController)
        if index == NSNotFound {
            return nil
        }
        
        index += 1
        if index == self.pageData.count {
            return nil
        }
        return self.viewControllerAtIndex(index, storyboard: viewController.storyboard!)
    }

}

