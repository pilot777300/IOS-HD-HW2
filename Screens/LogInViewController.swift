//
//  LogInViewController.swift
//  NavigTest
//
//  Created by Mac on 15.08.2022.
//

import UIKit

class LogInViewController: UIViewController {
    
    var coordinator: StartFlow?
    
     private lazy var loginButton: CustomButton = {
         let button = CustomButton(buttonTitle: "Войти" , buttonColor: .blue) { [self] in
            loginButtonPressed()
        }
       return button
    }()
    

    private lazy var logo = UIImageView()
  lazy var email = UITextField()
  lazy var password = UITextField()
 
    
    var loginDelegate: LoginViewControllerDelegate = LoginInspector()
  

    override func viewDidLoad() {
        super.viewDidLoad()
     
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(sender:)), name: UIResponder.keyboardWillShowNotification, object: nil);

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(sender:)), name: UIResponder.keyboardWillHideNotification, object: nil);
       
        
        navigationController?.isNavigationBarHidden = true
        view.backgroundColor = .white
        
        logo.backgroundColor = .white
        logo.image = UIImage(named: "logo")
        logo.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(logo)
        
        email.layer.borderWidth = 0.5
        email.layer.borderColor = UIColor.lightGray.cgColor
        email.placeholder = "e-mail"
        email.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        email.backgroundColor = .systemGray6
        email.font = UIFont.systemFont(ofSize: 15)
        email.translatesAutoresizingMaskIntoConstraints = false
        email.clipsToBounds = true
        email.layer.cornerRadius = 10
        email.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        email.keyboardType = UIKeyboardType.default
        email.clearButtonMode = UITextField.ViewMode.whileEditing
        email.returnKeyType = UIReturnKeyType.done
        email.resignFirstResponder()
        self.view.addSubview(email)
        
        password.layer.borderWidth = 0.5
        password.layer.borderColor = UIColor.lightGray.cgColor
        password.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        password.placeholder = "Password"
        password.font = UIFont.systemFont(ofSize: 15)
        password.backgroundColor = .systemGray6
        password.keyboardType = UIKeyboardType.default
        password.translatesAutoresizingMaskIntoConstraints = false
        password.clipsToBounds = true
        password.layer.cornerRadius = 10
        password.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        password.isSecureTextEntry = true
        self.view.addSubview(password)
        self.view.addSubview(loginButton)
        constraints()

    }
   
    @objc func keyboardWillShow(sender: NSNotification) {
         self.view.frame.origin.y = -90 
    }

    @objc func keyboardWillHide(sender: NSNotification) {
         self.view.frame.origin.y = 0
    }
   
   @objc func dismissKeyboard() {
        self.view.endEditing(true)
    }
   
     func loginButtonPressed() {
       
   
        if  loginDelegate.check(login: email.text!, password: password.text!) == true
                              {
            coordinator?.openProfileViewController()
            coordinator?.coordinateToTabBar()
            
        } else {

            let alert = UIAlertController(title: "Ошибка",
                                        message: "Неправильный логин или пароль",
                                        preferredStyle: .alert)
                                alert.addAction(UIAlertAction(title: "Попробую снова", style: .cancel, handler: nil))
                                    self.present(alert, animated: true)
                                    }


    }
    private func constraints() {
        let safeArea = view.safeAreaLayoutGuide
     NSLayoutConstraint.activate([
        logo.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
       logo.widthAnchor.constraint(equalToConstant: 100),
       logo.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 120.0),
       logo.heightAnchor.constraint(equalToConstant: 100),
        
        email.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
        email.topAnchor.constraint(equalTo: logo.bottomAnchor, constant: 120),
        email.heightAnchor.constraint(equalToConstant: 50),
        email.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 16),
        email.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -16),
      
        password.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
        password.topAnchor.constraint(equalTo: email.bottomAnchor),
        password.heightAnchor.constraint(equalToConstant: 50),
        password.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 16),
        password.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -16),
      
        loginButton.topAnchor.constraint(equalTo: password.bottomAnchor, constant: 16),
        loginButton.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 16),
        loginButton.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -16),
        loginButton.heightAnchor.constraint(equalToConstant: 50),

     ])
    
    }
  
}




