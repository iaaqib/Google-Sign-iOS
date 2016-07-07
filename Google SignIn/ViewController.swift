//
//  ViewController.swift
//  Google SignIn
//
//  Created by Muhammad Raza on 20/06/2016.
//  Copyright © 2016 Kode Snippets. All rights reserved.
//

import UIKit
import GoogleSignIn

class ViewController: UIViewController, GIDSignInDelegate, GIDSignInUIDelegate  {
   
    @IBOutlet weak var customButton: UIButton!

    @IBOutlet weak var defaultButton: GIDSignInButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        GIDSignIn.sharedInstance().uiDelegate = self
    
        GIDSignIn.sharedInstance().delegate = self
    }
    @IBOutlet weak var logout: UIButton!

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func signInToGoogle(sender: AnyObject) {
        
        GIDSignIn.sharedInstance().signIn()
        
    }
    
    
    @IBAction func logout(sender: AnyObject) {
        if GIDSignIn.sharedInstance().hasAuthInKeychain() == true {
        GIDSignIn.sharedInstance().signOut()
            logout.hidden = true
            customButton.hidden = false
            defaultButton.hidden = false
            alert("Logged Out", message: "")
        
        }
        
    }
    func signIn(signIn: GIDSignIn!, didSignInForUser user: GIDGoogleUser!,
                withError error: NSError!) {
        if (error == nil) {
           
            let userId = user.userID
            let idToken = user.authentication.idToken
            let fullName = user.profile.name
            let profilePicture = String(GIDSignIn.sharedInstance().currentUser.profile.imageURLWithDimension(400))
            let email = user.profile.email
            logout.hidden = false
            customButton.hidden = true
            defaultButton.hidden = true
            print("Auth:\(idToken)\nUserId:\(userId)\nFullname:\(fullName)\nEmail:\(email)\nProfile Picture:\(profilePicture)")
            alert("Logged In", message: "Fullname:\(fullName)\nEmail:\(email)\nProfile Picture:\(profilePicture)")
        } else {
            print("\(error.localizedDescription)")
        }
    }
    
    func alert(title: String, message: String){
    let alert = UIAlertController(title: title, message: message, preferredStyle: .Alert)
    let okAction = UIAlertAction(title: "OK",style: .Default, handler: nil)
        alert.addAction(okAction)
        
        self.presentViewController(alert, animated: true, completion: nil)
    
    }

}

