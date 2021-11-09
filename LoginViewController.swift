
//
//  LogInViewController.swift
//  Assignment 03
//
//  Created by Madhawa Jayagoda on 2021-05-12.
//


import UIKit
import CoreData

class LogInViewController: UIViewController {
    
    @IBOutlet weak var usernameTxtField: UITextField!
    @IBOutlet weak var passwordTxtField: UITextField!
    
    @IBOutlet weak var loginBtn: UIButton!
    
    // Toggle icon for password
    var pwdShowIconClick = false
    
    // Referance to the ManageObjectContext
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext


    // MARK: UIViewController LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        usernameTxtField.layer.cornerRadius = 5
        usernameTxtField.layer.masksToBounds = true
        usernameTxtField.layer.borderWidth = 1.5
        usernameTxtField.layer.borderColor = UIColor(red: 0.51, green: 0.51, blue: 0.52, alpha: 1.00).cgColor
        usernameTxtField.layer.sublayerTransform = CATransform3DMakeTranslation(10, 0, 0)
        
        passwordTxtField.layer.cornerRadius = 5
        passwordTxtField.layer.masksToBounds = true
        passwordTxtField.layer.borderWidth = 1.5
        passwordTxtField.layer.borderColor = UIColor(red: 0.51, green: 0.51, blue: 0.52, alpha: 1.00).cgColor
        passwordTxtField.layer.sublayerTransform = CATransform3DMakeTranslation(10, 0, 0)
        
        loginBtn.layer.cornerRadius = 5
        
        let uiImage = UIImage(named: "password_view" )
        let uiImageViewPwd = passwordTxtField.rightImage( uiImage, imageWidth: 20, padding: 20)
        
        // create tap gesture recognizer
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.imageTapped(tapGestureRecognizer:)))


        // add it to the image view;
        uiImageViewPwd.addGestureRecognizer(tapGesture)
        // make sure imageView can be interacted with by user
        uiImageViewPwd.isUserInteractionEnabled = true
    }
}




// MARK: Button Actions
extension LogInViewController{
    @IBAction func loginBtnClicked() {
        if( !(usernameTxtField.text?.isEmpty ?? true ) &&  !(passwordTxtField.text?.isEmpty ?? true) ) {
            if( self.isValidEmail( usernameTxtField.text! )){
                // Email format is Valid
                // FETCH the users from Core Data
                var userArray = [User]()
                do {
                    userArray = try context.fetch(User.fetchSpecificUser(email: usernameTxtField.text!))
                    //print(userArray.count)
                    
                    // If userArray is greater than 0 - the user exists in the database
                    // Otherwise if userArray is 0 - then no such user exists or invalid useremail and password
                    
                    if userArray.count > 0 {
                        // User entered a correct Email
                        if userArray.first!.password! == passwordTxtField.text! {
                            // Login to the application successful
                            let navTabBarVController = self.storyboard?.instantiateViewController(identifier: "NavTabBarViewController") as! NavTapBarViewController
                            self.navigationController?.pushViewController(navTabBarVController, animated: true)
                        
                        } else {
                            // Invalid password
                            
                            // create the alert - password and verify password does not match
                            let alert = UIAlertController(title: "Error", message: "Incorrect Password! \n Please check again", preferredStyle: UIAlertController.Style.alert)
                            alert.setValue(NSAttributedString(string: alert.title!, attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 17, weight: UIFont.Weight.medium), NSAttributedString.Key.foregroundColor : UIColor.red]), forKey: "attributedTitle")
                            // add an action (button)
                            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))


                            // show the alert
                            self.present(alert, animated: true, completion: nil)
                            
                        }
                        
                    } else {
                        // Useremail is invalid / incorrect
                        // Invalid Email
                        
                        // create the alert - password and verify password does not match
                        let alert = UIAlertController(title: "Error", message: "Invalid Email address! \n Please check again", preferredStyle: UIAlertController.Style.alert)
                        alert.setValue(NSAttributedString(string: alert.title!, attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 17, weight: UIFont.Weight.medium), NSAttributedString.Key.foregroundColor : UIColor.red]), forKey: "attributedTitle")
                        // add an action (button)
                        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))


                        // show the alert
                        self.present(alert, animated: true, completion: nil)
                        
                    }
                    
                } catch {
                    print("LoginVC: Error occured fetching the Users")
                }
            
            } else {
                // Invalid Email
                
                // create the alert - password and verify password does not match
                let alert = UIAlertController(title: "Error", message: "Invalid Email address! \n Please check again", preferredStyle: UIAlertController.Style.alert)
                alert.setValue(NSAttributedString(string: alert.title!, attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 17, weight: UIFont.Weight.medium), NSAttributedString.Key.foregroundColor : UIColor.red]), forKey: "attributedTitle")
                // add an action (button)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))


                // show the alert
                self.present(alert, animated: true, completion: nil)
                
            } // End-IF Email verify
            
        } else {
            // create the alert - one or more fields are empty
            let alert = UIAlertController(title: "Error", message: "Username or Password filed is empty! \n Please fill all the fields to Login", preferredStyle: UIAlertController.Style.alert)
            alert.setValue(NSAttributedString(string: alert.title!, attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 17, weight: UIFont.Weight.medium), NSAttributedString.Key.foregroundColor : UIColor.red]), forKey: "attributedTitle")
            // add an action (button)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))


            // show the alert
            self.present(alert, animated: true, completion: nil)
        }        
    }
    
    @IBAction func aboutUsBtnClicked(_ sender: UIButton) {
        let aboutUsViewController = self.storyboard?.instantiateViewController(identifier: "AboutUsViewController") as! AboutUsViewController
        self.present(aboutUsViewController, animated: true, completion: nil)
    }
    




    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
}




// MARK: Custom Methods
extension LogInViewController {
    @objc private func imageTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        // if the tapped view is a UIImageView then set it to imageview
        if let _ = tapGestureRecognizer.view as? UIImageView {
            //print("Image Tapped")
            self.pwdShowIconClick = !(self.pwdShowIconClick)
            
            if pwdShowIconClick {
                // Show the Password
                passwordTxtField.isSecureTextEntry = false
            } else {
                // Hide the Password
                passwordTxtField.isSecureTextEntry = true
            }
    
        }
    }
}
