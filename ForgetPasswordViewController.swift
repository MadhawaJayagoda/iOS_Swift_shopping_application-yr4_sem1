
//
//  ForgetPasswordViewController.swift
//
//  Created by Madhawa Jayagoda on 2021-05-18.
//


import UIKit

class ForgetPasswordViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var pwdResetBtn: UIButton!
    
    // MARK: UIViewController Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()  
    }
    
    // Reference to the ManageObjectContext
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        emailTextField.layer.cornerRadius = 5
        emailTextField.layer.masksToBounds = true
        emailTextField.layer.borderWidth = 1.5
        emailTextField.layer.borderColor = UIColor(red: 0.51, green: 0.51, blue: 0.52, alpha: 1.00).cgColor
        emailTextField.layer.sublayerTransform = CATransform3DMakeTranslation(10, 0, 0)
        
        pwdResetBtn.layer.cornerRadius = 5
    }
}


// MARK: Button Actions
extension ForgetPasswordViewController {
    @IBAction func sendPwdResetBtnClicked(_ sender: UIButton) {
        if ( !(emailTextField.text?.isEmpty ?? true)) {
            // User entered some value
            
            if isValidEmail(emailTextField.text!) {
               // Email address is valid
                var userArray = [User]()
                do {
                    userArray = try context.fetch(User.fetchSpecificUser(email: emailTextField.text!))
                    //print(userArray.count)
                    
                    // If userArray is greater than 0 - the user exists in the database
                    // Otherwise if userArray is 0 - then no such user exists or invalid useremail and password
                    
                    if userArray.count > 0 {
                        
                        // UserDefaults Instance
                        let defaults = UserDefaults.standard
                        
                        // Set the email address to pass through in UserDefaults temporary
                        defaults.setValue( emailTextField.text!, forKey: "UserEmailTemp")
                        
                        // Show alert to Reset Password
                        // Invalid email address
                        let alert = UIAlertController(title: "Password reset link sent to your inbox", message: "Please login to your email and click on the reset link to password reset", preferredStyle: UIAlertController.Style.alert)
                        alert.setValue(NSAttributedString(string: alert.title!, attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 17, weight: UIFont.Weight.medium), NSAttributedString.Key.foregroundColor : UIColor.red]), forKey: "attributedTitle")
                        // add an action (button)
                        alert.addAction(UIAlertAction(title: "close", style: UIAlertAction.Style.default, handler: {(action: UIAlertAction!) in
                            let resetPwdViewController = self.storyboard?.instantiateViewController(identifier: "ResetPasswordViewController") as! ResetPasswordViewController
                            self.navigationController?.pushViewController(resetPwdViewController, animated: true)
                        }))


                        // show the alert
                        self.present(alert, animated: true, completion: nil)
                        
                    } else {
                        // User has entered an email not existing in the database
                        
                        // Invalid email address
                        let alert = UIAlertController(title: "Error", message: "Invalid Email address! \n This email address is not currently registered with Vergo", preferredStyle: UIAlertController.Style.alert)
                        alert.setValue(NSAttributedString(string: alert.title!, attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 17, weight: UIFont.Weight.medium), NSAttributedString.Key.foregroundColor : UIColor.red]), forKey: "attributedTitle")
                        // add an action (button)
                        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))


                        // show the alert
                        self.present(alert, animated: true, completion: nil)
                    }
                    
                    
                } catch {
                    print("ForgetPwdViewController: Error fetching data from the Database")
                }
                    
            } else {
                // Invalid email address
                let alert = UIAlertController(title: "Error", message: "Invalid Email address! \n Please check again", preferredStyle: UIAlertController.Style.alert)
                alert.setValue(NSAttributedString(string: alert.title!, attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 17, weight: UIFont.Weight.medium), NSAttributedString.Key.foregroundColor : UIColor.red]), forKey: "attributedTitle")
                // add an action (button)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))

                // show the alert
                self.present(alert, animated: true, completion: nil)
                
            }  
        } else {
            // email field is Empty
            
            // create the alert - one or more fields are empty
            let alert = UIAlertController(title: "Error", message: "Email field is empty! \n Please fill the Email field to reset your password", preferredStyle: UIAlertController.Style.alert)
            alert.setValue(NSAttributedString(string: alert.title!, attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 17, weight: UIFont.Weight.medium), NSAttributedString.Key.foregroundColor : UIColor.red]), forKey: "attributedTitle")
            // add an action (button)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))


            // show the alert
            self.present(alert, animated: true, completion: nil)
            
        }
    }
    
    @IBAction func backBtnClicked(_ sender: UIButton) {
        let loginViewController = self.storyboard?.instantiateViewController(identifier: "LoginViewController") as! LogInViewController
        self.navigationController?.pushViewController(loginViewController, animated: true)
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

