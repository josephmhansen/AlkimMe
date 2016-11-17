//
//  RoutineTemplateViewController.swift
//  AlkimMe
//
//  Created by Joseph Hansen on 11/17/16.
//  Copyright © 2016 Joseph Hansen. All rights reserved.
//
/*
import UIKit

class RoutineTemplateViewController: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {

    var pageViewController: UIPageViewController!
    var stepProductTitles: NSArray!
    var stepProductLogos: NSArray!
    
    var products: [Product] = ShelfCollectionViewController.products
    //passing valur from the product segue
    var productName: String?
    

    
    override func viewDidLoad() {
        super.viewDidLoad()

        //self.stepProductTitles = NSArray(objects: [Product]())
        //self.stepProductLogos = NSArray(objects: [Product]())
        self.pageViewController = self.storyboard?.instantiateViewController(withIdentifier: "PageViewController") as! UIPageViewController
        self.pageViewController.dataSource = self
        
        var startVC = self.viewControllerAtIndex(index: 0) as ContentViewController
        var viewControllers = NSArray(object: startVC)
        
        self.pageViewController.setViewControllers(viewControllers as! [UIViewController], direction: .forward, animated: true, completion: nil)
        self.pageViewController.view.frame = CGRect(x: 0, y: 30, width: self.view.frame.width, height: self.view.frame.size.height - 60)
        
        self.addChildViewController(self.pageViewController)
        self.view.addSubview(self.pageViewController.view)
        self.pageViewController.didMove(toParentViewController: self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func viewControllerAtIndex(index: Int) -> ContentViewController {
        if ((self.stepProductTitles.count == 0) || (index >= self.stepProductTitles.count)) {
            return ContentViewController()
        }
        var vc: ContentViewController = self.storyboard?.instantiateViewController(withIdentifier: "ContentViewController") as! ContentViewController
        vc.productLogoFile = self.stepProductLogos[index] as! String
        vc.productName.text = self.stepProductTitles[index] as! String
        vc.pageIndex = index
        
        return vc
    }
    
    //MARK: - Page View Controller Data Source
    
    
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        var vc = viewController as! ContentViewController
        var index = vc.pageIndex as! Int
        
        if (index == 0 || index == NSNotFound)
        {
            return nil
        }
        index -= 1
        return self.viewControllerAtIndex(index: index)
        
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        var vc = viewController as! ContentViewController
        var index = vc.pageIndex as Int
        
        if (index == NSNotFound) {
            return nil
        }
        
        index += 1
        
        if (index == self.stepProductTitles.count) {
            return nil
        }
        return self.viewControllerAtIndex(index: index)
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return self.stepProductTitles.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return 0
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        guard let productName = productName else { return }
        let viewController = pageViewController.viewControllers?[0]
        self.navigationItem.title = viewController?.navigationItem.title
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

*/
