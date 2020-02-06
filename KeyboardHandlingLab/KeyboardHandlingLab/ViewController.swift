//
//  ViewController.swift
//  KeyboardHandlingLab
//
//  Created by Gregory Keeley on 2/4/20.
//  Copyright © 2020 Gregory Keeley. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    override func viewDidAppear(_ animated: Bool) {
        pulsateLogo()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
        loginButton.addTarget(self, action: #selector(loginButtonPressed(_:)), for: .touchUpInside)
    }
    
    private func pulsateLogo() {
        UIView.animate(withDuration: 2.0, delay: 0.0, options: [.repeat, .curveEaseInOut], animations: {
            self.loginButton.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
             self.loginButton.alpha = 0.0
        })
    }
    @IBAction func loginButtonPressed(_ sender: UIButton) {
        guard let loginViewController = storyboard?.instantiateViewController(identifier: "LoginViewController") as? LoginViewController else {
            fatalError("Could not segue to loginVC")
        }
        show(loginViewController, sender: self)
    }
}


