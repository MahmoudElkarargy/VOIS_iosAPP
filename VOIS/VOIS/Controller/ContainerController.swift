//
//  ContainerController.swift
//  VOIS
//
//  Created by Mahmoud Elkarargy on 3/25/21.
//

import UIKit

class ContainerController: UIViewController{
    // MARK: - Properties
    var menuController: UIViewController!
    var centerController: UIViewController!
    var isExpanded = false
    
    // MARK: - Init
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configrueHomeController()
    }
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
    
    // MARK: - Handlers
    
    func configrueHomeController(){
        let homeController = HomeController()
        homeController.delegate = self
        centerController = UINavigationController(rootViewController: homeController)
        view.addSubview(centerController.view)
        addChild(centerController)
        centerController.didMove(toParent: self)
    }
    
    func configrueMenuController(){
        if menuController == nil{
            // Add our menu controller here
            menuController = MenuController()
            view.insertSubview(menuController.view, at: 0)
            addChild(menuController)
            menuController.didMove(toParent: self)
        }
    }
    
    func showMenuController(shouldExpand: Bool){
        if shouldExpand{
            //Show Menu
            UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
                
                self.centerController.view.frame.origin.x = self.centerController.view.frame.width - 80
            }, completion: nil)
        }
        else{
            //hide Menu
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
                
                self.centerController.view.frame.origin.x = 0
            }, completion: nil)
        }
    }
}

extension ContainerController: HomeControlDelegate{
    
    func handleMenuToggle() {
        
        if !isExpanded{
            configrueMenuController()
        }
        isExpanded = !isExpanded
        showMenuController(shouldExpand: isExpanded)
    }
}
