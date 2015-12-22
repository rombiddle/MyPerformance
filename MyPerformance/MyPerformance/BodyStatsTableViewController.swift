//
//  BodyStatsTableViewController.swift
//  MyPerformance
//
//  Created by Romain BRUNIE on 11/08/15.
//  Copyright (c) 2015 Romain BRUNIE. All rights reserved.
//

import UIKit
import CoreData

class BodyStatsTableViewController: UITableViewController {
    
    var sectionTitle = ["GENERAL INFORMATION", "  ", "BICEPS", "THIGHS", "CALVES"]
    
    var cellTitle = [["Name", "Height", "Body Fat", "Weight"],
    ["Neck", "Chest", "Waist", "Hips"],
    ["Left", "Right"],
    ["Left", "Right"],
    ["Left", "Right"]]
    
    
    
    
//    var cellDetail = [["  ", "- in", "- %", "- lbs"],
//        ["- in", "- in", "- in", "- in"],
//        ["- in", "- in"],
//        ["- in", "- in"],
//        ["- in", "- in"]]
    
    
    
    var rows: [Int] = [4, 4, 2, 2, 2]
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // here I modify the cellDetail array with the value of the code data, so if the user quit the application, all the data entered by the user are not lost
        // here I add new data in the core data
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 5
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return rows[section]
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitle[section]
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        
        var titleAlert = ""
        if (indexPath.section == 0 && indexPath.row == 0) || (indexPath.section == 0 && indexPath.row == 1){
            shouldPerformSegueWithIdentifier("addSegue", sender: nil)
            titleAlert = cellTitle[0][indexPath.row]
            // creation alert controller with title of the line with no placeholder
            let alerController = UIAlertController(title: titleAlert, message: "" ,preferredStyle: .Alert)
            alerController.addTextFieldWithConfigurationHandler { (textField) in
                textField.placeholder = ""
            }
            // I add a cancel action to the alert
            let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel) { (action) in
                // ...
            }
            alerController.addAction(cancelAction)
            // I add an ok button to the alert action, so I can save what the user typed
            let OKAction = UIAlertAction(title: "OK", style: .Default) { (action) in
                let t = (alerController.textFields?[0])! as UITextField
                if indexPath.row == 1{
                    t.text = t.text! + " in"
                }
                
                //self.cellDetail[0].removeAtIndex(indexPath.row)
                //self.cellDetail[0].insert(t.text!, atIndex: indexPath.row)
                
                // I save the new data entered by the user in the NSUSERDEFAULT
                let defaults = NSUserDefaults.standardUserDefaults()
                if indexPath.section == 0 && indexPath.row == 0{
                    defaults.setObject(t.text, forKey: "Name")
                }
                if indexPath.section == 0 && indexPath.row == 1{
                    defaults.setObject(t.text, forKey: "Height")
                }
                if indexPath.section == 0 && indexPath.row == 2{
                    defaults.setObject(t.text, forKey: "BodyFat")
                }
                if indexPath.section == 0 && indexPath.row == 3{
                    defaults.setObject(t.text, forKey: "Weight")
                }
                if indexPath.section == 1 && indexPath.row == 0{
                    defaults.setObject(t.text, forKey: "Neck")
                }
                if indexPath.section == 1 && indexPath.row == 1{
                    defaults.setObject(t.text, forKey: "Chest")
                }
                if indexPath.section == 1 && indexPath.row == 2{
                    defaults.setObject(t.text, forKey: "Waist")
                }
                if indexPath.section == 1 && indexPath.row == 3{
                    defaults.setObject(t.text, forKey: "Hips")
                }
                
                if indexPath.section == 2 && indexPath.row == 0{
                    defaults.setObject(t.text, forKey: "BicepsLeft")
                }
                if indexPath.section == 2 && indexPath.row == 1{
                    defaults.setObject(t.text, forKey: "BicepsRight")
                }

                if indexPath.section == 3 && indexPath.row == 0{
                    defaults.setObject(t.text, forKey: "ThighsLeft")
                }
                if indexPath.section == 3 && indexPath.row == 1{
                    defaults.setObject(t.text, forKey: "ThighsRight")
                }

                if indexPath.section == 4 && indexPath.row == 0{
                    defaults.setObject(t.text, forKey: "CalvesLeft")
                }
                if indexPath.section == 4 && indexPath.row == 1{
                    defaults.setObject(t.text, forKey: "CalvesRight")
                }

                // reload data in the table view
                self.tableView.reloadData()
            }
            alerController.addAction(OKAction)
            self.presentViewController(alerController, animated: true, completion: nil)
        }else{
            performSegueWithIdentifier("addSegue", sender: cellTitle[indexPath.section][indexPath.row])
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if (segue.identifier == "addSegue") {
            let secondViewController = segue.destinationViewController as! AddDetailTableViewController
            let duration = sender as! String
            secondViewController.titleHeader = duration
        }
    }
    
    override func shouldPerformSegueWithIdentifier(identifier: String, sender: AnyObject?) -> Bool {
       return false
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cellID", forIndexPath: indexPath) 
        cell.textLabel!.text = cellTitle[indexPath.section][indexPath.row]
        // i create string variables from NSUserDefault in order to display during the reload of data
        let defaults = NSUserDefaults.standardUserDefaults()
        let name = defaults.objectForKey("Name") as! String
        let height = defaults.objectForKey("Height") as! String
        let bodyDat = defaults.objectForKey("BodyFat") as! String
        let weight = defaults.objectForKey("Weight") as! String
        let neck = defaults.objectForKey("Neck") as! String
        let chest = defaults.objectForKey("Chest") as! String
        let waist = defaults.objectForKey("Waist") as! String
        let hips = defaults.objectForKey("Hips") as! String
        let bicepsLeft = defaults.objectForKey("BicepsLeft") as! String
        let bicepsRight = defaults.objectForKey("BicepsRight") as! String
        let thighsLeft = defaults.objectForKey("ThighsLeft") as! String
        let thighsRight = defaults.objectForKey("ThighsRight") as! String
        let calvesLeft = defaults.objectForKey("CalvesLeft") as! String
        let calvesRight = defaults.objectForKey("CalvesRight") as! String
        var cellDetailU = [[name, height, bodyDat, weight],
            [neck, chest, waist, hips],
            [bicepsLeft, bicepsRight],
            [thighsLeft, thighsRight],
            [calvesLeft, calvesRight]]
        cell.detailTextLabel!.text = cellDetailU[indexPath.section][indexPath.row]
        
        // Configure the cell...

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
