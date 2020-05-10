//
//  LoginViewController.swift
//  DayTrip
//
//  Created by Ryan Luu on 4/27/19.
//  Copyright © 2019 rnluu. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn

class LoginViewController: UIViewController, GIDSignInUIDelegate {
    @IBOutlet weak var signInButton: GIDSignInButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        GIDSignIn.sharedInstance().uiDelegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if let token = UserDefaults.standard.string(forKey: "authToken") {
            print(token)
            performSegue(withIdentifier: "loginSegue", sender: nil)
        }
    }
}
