//
//  LoginViewController.swift
//  test
//
//  Created by Максим Окунеев on 4/6/20.
//  Copyright © 2020 Максим Окунеев. All rights reserved.
//

import UIKit
import FBSDKLoginKit

class LoginViewController: UIViewController {
    
    lazy var fbLoginButton: UIButton = {
        let loginButton = FBLoginButton()
        loginButton.frame = CGRect(x: 32, y: 360, width: view.frame.width - 64, height: 50)
        loginButton.delegate = self
        return loginButton
    }()
    
    lazy var customFBLoginButton: UIButton = {
        let loginButton = UIButton()
        loginButton.backgroundColor = UIColor(hexValue: "#3B5999", alpha: 1)
        loginButton.setTitle("Login with FaceBook", for: .normal)
        loginButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        loginButton.setTitleColor(.white, for: .normal)
        loginButton.frame = CGRect(x: 32, y: 360 + 80, width: view.frame.width - 64, height: 50)
        loginButton.layer.cornerRadius = 4
        loginButton.addTarget(self, action: #selector(handleCustomFBLogin), for: .touchUpInside)
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
    
    private func setupViews() {
        view.addSubview(fbLoginButton)
        view.addSubview(customFBLoginButton)
    }

}
// MARK: FACEBOOK SDK
extension LoginViewController: LoginButtonDelegate {
    
    func loginButton(_ loginButton: FBLoginButton!, didCompleteWith result: LoginManagerLoginResult!, error: Error!) {
        
        if error != nil {
            print(error)
            return
        }
        
        guard AccessToken.isCurrentAccessTokenActive else { return }
        openMainViewController()
        
        print("Successfully logged in with facebook...")
    }
    
    func loginButtonDidLogOut(_ loginButton: FBLoginButton!) {
        print("Did log out of facebook")
    }
    private func openMainViewController() {
        dismiss(animated: true)
    }
    
    @objc private func handleCustomFBLogin() {
        LoginManager().logIn(permissions: ["email", "public_profile"], from: self) { (result, error) in
            if let error = error {
                print(error.localizedDescription)
            }
            guard let result = result else { return }
            if result.isCancelled { return }
            else {
                self.openMainViewController()
            }
        }
    }
}
