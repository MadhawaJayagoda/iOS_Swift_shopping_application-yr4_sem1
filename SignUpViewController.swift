
//
//  SignUpViewController.swift
//  Assignment 03
//
//  Created by Madhawa Jayagoda on 2021-05-12.
//


import UIKit
import CoreData

class SignUpViewController: UIViewController {
    
    // TextFields
    @IBOutlet weak var fullNameTxtField: UITextField!
    @IBOutlet weak var emailTxtField: UITextField!
    @IBOutlet weak var passwordTxtField: UITextField!
    @IBOutlet weak var verifyPasswordTxtField: UITextField!
    
    // Buttons
    @IBOutlet weak var signupBtn: UIButton!
    
    // Toggle icon for password
    var pwdShowIconClick = false
    var vryPwdShowIconClicked = false
    
    // Reference to the ManageObjectContext
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    



    // MARK: UILifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        signupBtn.layer.cornerRadius = 5
        
        fullNameTxtField.layer.cornerRadius = 5
        fullNameTxtField.layer.masksToBounds = true
        fullNameTxtField.layer.borderWidth = 1.5
        fullNameTxtField.layer.borderColor = UIColor(red: 0.51, green: 0.51, blue: 0.52, alpha: 1.00).cgColor
        fullNameTxtField.layer.sublayerTransform = CATransform3DMakeTranslation(10, 0, 0)
        
        emailTxtField.layer.cornerRadius = 5
        emailTxtField.layer.masksToBounds = true
        emailTxtField.layer.borderWidth = 1.5
        emailTxtField.layer.borderColor = UIColor(red: 0.51, green: 0.51, blue: 0.52, alpha: 1.00).cgColor
        emailTxtField.layer.sublayerTransform = CATransform3DMakeTranslation(10, 0, 0)
        
        passwordTxtField.layer.cornerRadius = 5
        passwordTxtField.layer.masksToBounds = true
        passwordTxtField.layer.borderWidth = 1.5
        passwordTxtField.layer.borderColor = UIColor(red: 0.51, green: 0.51, blue: 0.52, alpha: 1.00).cgColor
        passwordTxtField.layer.sublayerTransform = CATransform3DMakeTranslation(10, 0, 0)
        
        verifyPasswordTxtField.layer.cornerRadius = 5
        verifyPasswordTxtField.layer.masksToBounds = true
        verifyPasswordTxtField.layer.borderWidth = 1.5
        verifyPasswordTxtField.layer.borderColor = UIColor(red: 0.51, green: 0.51, blue: 0.52, alpha: 1.00).cgColor
        verifyPasswordTxtField.layer.sublayerTransform = CATransform3DMakeTranslation(10, 0, 0)
    
        let uiImage = UIImage(named: "password_view" )
        let uiImageViewPwd = passwordTxtField.rightImage( uiImage, imageWidth: 20, padding: 20)
        let uiImageViewVryPwd = verifyPasswordTxtField.rightImage( uiImage, imageWidth: 20, padding: 20)
        
        // create tap gesture recognizer for Password and Verify Password
        let tapGesturePwd = UITapGestureRecognizer(target: self, action: #selector(self.imageTappedPwd(tapGestureRecognizer:)))
        let tapGestureVryPwd = UITapGestureRecognizer(target: self, action: #selector(self.imageTappedVryPwd(tapGestureRecognizer:)))


        // add it to the imageView - password;
        uiImageViewPwd.addGestureRecognizer(tapGesturePwd)
        // make sure imageView can be interacted with by user
        uiImageViewPwd.isUserInteractionEnabled = true
        
        // add it to the imageView - Verify Password;
        uiImageViewVryPwd.addGestureRecognizer(tapGestureVryPwd)
        // make sure imageView can be interacted with by user
        uiImageViewVryPwd.isUserInteractionEnabled = true
        
    }
}


// MARK: IBAction methods
extension SignUpViewController {
    @IBAction func signUpBtnClicked(_ sender: UIButton) {
        if ( !(fullNameTxtField.text?.isEmpty ?? true) && !(emailTxtField.text?.isEmpty ?? true) && !(passwordTxtField.text?.isEmpty ?? true) && ( !verifyPasswordTxtField.text!.isEmpty ) ) {
            if( self.isValidEmail( emailTxtField.text! )){
                // Email format is Valid
                


                if ( passwordTxtField.text! == verifyPasswordTxtField.text!) {
                    
                    // All the validations are successful
                    // Save the User in the Database using ManageObjectContext
                    let _fullName = fullNameTxtField.text
                    let _email = emailTxtField.text
                    let _password = passwordTxtField.text
                    
                    let newUser = User(context: context)
                    newUser.fullName = _fullName
                    newUser.email = _email
                    newUser.password = _password
                    
                    do {
                        try context.save()
                        
                        print("Successfully saved the New User")
                        
                        // Show alert that User save successsfully
                        let alert = UIAlertController(title: "? Successfully Registered", message: "\n Thank you for registering with Vergo", preferredStyle: UIAlertController.Style.alert)
                        alert.setValue(NSAttributedString(string: alert.title!, attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 17, weight: UIFont.Weight.medium), NSAttributedString.Key.foregroundColor : UIColor(red: 0.16, green: 0.71, blue: 0.39, alpha: 1.00)]), forKey: "attributedTitle")
                        // add an action (button)
                        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: {(action:UIAlertAction!) in
                           
                            // Navigate back to the Previous viewController
                            self.navigationController?.popViewController(animated: true)
                        }))


                        // show the alert
                        self.present(alert, animated: true, completion: nil)
                    
                        
                    } catch {
                        print("Error occured while saving the User in the Database !")
                    }
                    
    
                } else {
                    // create the alert - password and verify password does not match
                    let alert = UIAlertController(title: "Error", message: "Password and Confirm Password fields does not match! \n Please check again", preferredStyle: UIAlertController.Style.alert)
                    alert.setValue(NSAttributedString(string: alert.title!, attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 17, weight: UIFont.Weight.medium), NSAttributedString.Key.foregroundColor : UIColor.red]), forKey: "attributedTitle")
                    // add an action (button)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))


                    // show the alert
                    self.present(alert, animated: true, completion: nil)
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
                
            }
            
        } else {
            // create the alert - one or more fields are empty
            let alert = UIAlertController(title: "Error", message: "One or more fileds are empty! \n Please fill all the fields to Sign Up", preferredStyle: UIAlertController.Style.alert)
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




// MARK:Custom Methods
extension SignUpViewController {
    @objc private func imageTappedPwd(tapGestureRecognizer: UITapGestureRecognizer) {
        // if the tapped view is a UIImageView then set it to imageview
        if let _ = tapGestureRecognizer.view as? UIImageView {
            //print("Image Tapped on the Password")
            
            // Toggle the Boolean value
            self.pwdShowIconClick = !(self.pwdShowIconClick)
            
            if pwdShowIconClick {
                // Show the Password
                passwordTxtField.isSecureTextEntry = false
            } else {
                // Hide the Password
                passwordTxtField.isSecureTextEntry = true
            }


        }
        
        func signUpUser() {
            
        }
        
    }
    
    @objc private func imageTappedVryPwd(tapGestureRecognizer: UITapGestureRecognizer) {
        // if the tapped view is a UIImageView then set it to imageview
        if let _ = tapGestureRecognizer.view as? UIImageView {
            //print("Image Tapped on the Verify Password")
            

            // Toggle the Boolean value
            self.vryPwdShowIconClicked = !(self.vryPwdShowIconClicked)
            
            if vryPwdShowIconClicked {
                // Show the Password
                verifyPasswordTxtField.isSecureTextEntry = false
            } else {
                // Hide the Password
                verifyPasswordTxtField.isSecureTextEntry = true
            }
        }
    }
}


// Add ImageView to the TextField - rightEnd
extension UITextField {
    func rightImage(_ image: UIImage?, imageWidth: CGFloat, padding: CGFloat) -> UIImageView {
        let imageView = UIImageView(image: image)
        imageView.frame = CGRect(x: padding, y: 0, width: imageWidth, height: frame.height)
        imageView.contentMode = .center
        
        let containerView = UIView(frame: CGRect(x: 0, y: 0, width: imageWidth + 2 * padding, height: frame.height))
        containerView.addSubview(imageView)
        rightView = containerView
        rightViewMode = .always
        
        return imageView
    }
}
