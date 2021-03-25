//
//  LoginController.swift
//  VOIS
//
//  Created by Mahmoud Elkarargy on 3/25/21.
//

import UIKit

class LoginController: UIViewController{
    // MARK: - Properties
   
    @IBOutlet weak var loginButton: UIButton!
    // MARK: - Init
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.titleView = UIImageView(image: UIImage(named: "WhiteLogo"))
        navigationItem.hidesBackButton = true
    }
    @IBAction func LoginPressed(_ sender: Any) {
        let homeViewController = storyboard?.instantiateViewController(identifier: "home")
        view.window?.rootViewController = homeViewController
        view.window?.makeKeyAndVisible()
    }
    // MARK: - Handlers
}
