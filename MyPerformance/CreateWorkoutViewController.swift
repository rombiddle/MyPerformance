//
//  CreateWorkoutViewController.swift
//  
//
//  Created by Romain BRUNIE on 7/20/15.
//
//

import UIKit

class CreateWorkoutViewController: UIViewController, UITextViewDelegate {

    
    
    
   /* @IBAction func CancelButton(sender: UIBarButtonItem) {
        navigationController!.presentingViewController!.dismissViewControllerAnimated(true, completion: nil);
    }*/
    
    @IBOutlet weak var nameLabelWorkout: UITextField!
    @IBOutlet weak var desciptionLabelWorkout: UITextView!
    
    var name: String = ""
    
    func textViewDidBeginEditing(desciptionLabelWorkout: UITextView) {
        if desciptionLabelWorkout.text == "Add desciption here..." {
            desciptionLabelWorkout.text = nil
            desciptionLabelWorkout.textColor = UIColor.blackColor()
        }
    }
    
    func textViewDidEndEditing(textView: UITextView) {
        if textView.text == "" {
            textView.text = "Add desciption here..."
            textView.textColor = UIColor.blackColor()
        }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        desciptionLabelWorkout.text = "Add desciption here..."
        desciptionLabelWorkout.textColor = UIColor.blackColor()
        desciptionLabelWorkout.layer.borderWidth = 1
        desciptionLabelWorkout.layer.borderColor = UIColor.blackColor().CGColor
        desciptionLabelWorkout.delegate = self;
        // Do any additional setup after loading the view.
    }

    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if segue.identifier == "saveSegue" {
            name = nameLabelWorkout.text!
        }
    }

}
