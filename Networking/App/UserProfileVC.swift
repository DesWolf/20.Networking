//
//  UserProfileVC.swift
//  test
//
//  Created by Максим Окунеев on 4/7/20.
//  Copyright © 2020 Максим Окунеев. All rights reserved.
//

import UIKit
import FBSDKLoginKit

class UserProfileVC: UIViewController{
    
    lazy var fbLoginButton: UIButton = {
        let loginButton = FBLoginButton()
        loginButton.frame = CGRect(x: 32, y: view.frame.height - 228, width: view.frame.width - 64, height: 50)
        loginButton.delegate = self
        return loginButton
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addVerticalGradientLayer(topColor: primaryColor, bottomColor: secondaryColor)
        setupViews()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        get {
            return .lightContent
        }
    }
    
    private func setupViews(){
        view.addSubview(fbLoginButton)
    }

//MARK: FACEBOOK SDK
}
extension UserProfileVC: LoginButtonDelegate {
   func loginButton(_ loginButton: FBLoginButton!, didCompleteWith result: LoginManagerLoginResult!, error: Error!) {
        
        if error != nil {
            print(error)
            return
        }
        print("Successfully logged in with facebook...")
    }
    
    func loginButtonDidLogOut(_ loginButton: FBLoginButton!) {
        print("Did log out of facebook")
        openLoginViewController()
    }
    private func openLoginViewController() {
        
        if !(AccessToken.isCurrentAccessTokenActive) {
            DispatchQueue.main.async {
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let loginVC = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
                loginVC.modalPresentationStyle = .fullScreen
                self.present(loginVC, animated: true)
                return
            }
        }
    }
}
