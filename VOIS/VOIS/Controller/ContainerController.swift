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
        let controller = UINavigationController(rootViewController: homeController)
        view.addSubview(controller.view)
        addChild(controller)
        controller.didMove(toParent: self)
    }
    
    func configrueMenuController(){
        if menuController == nil{
            // Add our menu controller here
            menuController = MenuController()
            view.insertSubview(menuController.view, at: 0)
            addChild(menuController)
            menuController.didMove(toParent: self)
            print("added??")
        }
    }
}

extension ContainerController: HomeControlDelegate{
    func handleMenuToggle() {
        configrueMenuController()
    }
}
