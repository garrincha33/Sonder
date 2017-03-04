//: Playground - noun: a place where people can play

import UIKit

var step1: String!
var step2: String!
var step3: String!
var step4: String!
var step5: String!
var step6: String!
var step7: String!
var step8: String!
var step9: String!
var step10: String!
var step11: String!
var step12: String!
var step13: String!
var step14: String!
var step15: String!
var step16: String!
var step17: String!
var step18: String!
var step19: String!
var step20: String!
var step21: String!
var step22: String!

step1 = "not much to start off with other than get your gitHub in order and add a viewController with the relevant VC's one for signUP and one for signIn, add 3 fields and a button, username , email and passwword for sign up and email and password for login also add a profile pic on signup. User will need to choose a pic on signup"

step2 = "create SignInVC and SignUPVC swift file to control your views in code"

step3 = "add a tab bar controller, this will give you 2 VCs. add a further 3 VCs and drag from tab bar controller to your view on choose ViewControllers. Update the default tab bar pictures with imported pictures and selected state. Add Cocoa touch classes for all your VCs and add view.backgroundColor = color to make sure VCs are connected properly"

step4 = "change tint color of tab bar items in app delegate UITabBar.appearance().tintColor = UIColor.darkGray and add a navigation controller to all views with Embed in, update title. Nav controllers are great because you can manage a stack of many UIViewControllers. Delete titles as icons are informative enough. Once you do this you will need to adjust the image bar inset to 5 for the top -5 for the bottom. This compensates for the hidden space "

step5 = "storyBoard references, split up your storyboards into smaller groups and link them with references. Choose navigation controller and choose refactor to storyboard. You can also split this up further and choose each tab bar item into its own storyboard. refactor to storyboard, remove inital view arrow, set storyboard id and go back to main and reference that as initial vieww in reerence ID"

step6 = "customise signin/up - customise in viewDidLoad, IBOutlet to your text fields, use backgroundcolor, tinitColor, textColor and also textField.placeholder!, attributes: [NSForgRoundColorAttributeName: UIColor(white:1.0, alpha:0.6)])) create a let bottomLayerEmail = CALayer() to add a thin line design ontop of your textfield then .layer.addSubLayer(thelayerYouCreate)  "

step7 = "install Firebase, use vim dont forget to write save with :x!"

step7 = "firebase auth: install firebase auth in your pod, create a ibaction from your signup btn and use FIRAuth.createUser, remember to enable email auth within firebase"

step8 = "create an acutal user with emailtext field and password textField, install Firebase Database Pod, create a reference to the database and a reference to child(users) also let uid = user?uid you will need this to reference a unioque user , create this newwUserReference.setValue, store in dictionary format [username: self.usernametextfield.text! and email:self.emailtextfield.text!]"

step9 = "install firebase storage, we need to create and exension of signupviewwcontroller with uinavigationcontrollerdelegate and uiimagepickercontrollerdelegate, we are going to enable tap gesture to store image profile pic so create a func handleselectedprofileimageview and add this to your selector of the tap gesture once created, implement function didFinishing picking media in extension , and a test print() to know when pic is tapped and dismiss the photolibray, enable user interaction, create tap gesture and add to profileImage.addTapGesture "
