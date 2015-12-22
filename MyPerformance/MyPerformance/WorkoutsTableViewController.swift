//
//  WorkoutsTableViewController.swift
//  MyPerformance
//
//  Created by Romain BRUNIE on 04/08/15.
//  Copyright (c) 2015 Romain BRUNIE. All rights reserved.
//

import UIKit
import CoreData

class WorkoutsTableViewController: UITableViewController {
    let managedContext = DataController().managedObjectContext

    var workout = [NSManagedObject]()
    var newCar: String = ""
    
    @IBAction func editActionButton(sender: UIBarButtonItem) {
        self.editing = !self.editing
        if sender.title == "Edit"{
            sender.title = "Done"
        }else{
            sender.title = "Edit"
        }
        
        
    }
    @IBAction func SaveButton(segue: UIStoryboardSegue) {
        let carDetailVC = segue.sourceViewController as! CreateWorkoutViewController
        newCar = carDetailVC.name
        
        saveWorkout(newCar)
        
        //cars.append(newCar)
        self.tableView.reloadData()
    }
    
    func saveWorkout(name: String) {
        
        let entity =  NSEntityDescription.entityForName("Workouts", inManagedObjectContext:managedContext)
        
        let nameW = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: managedContext)

        nameW.setValue(name, forKey: "nameWorkout")
        
        do {
            try managedContext.save()
            workout.append(nameW)
        } catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
        }
    }
    
    @IBAction func Cancel(segue: UIStoryboardSegue) {
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        let fetchRequest = NSFetchRequest(entityName: "Workouts")

        do {
            let results = try managedContext.executeFetchRequest(fetchRequest)
            workout = results as! [NSManagedObject]
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return workout.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("carCell", forIndexPath: indexPath)
        cell.textLabel!.text = workout[indexPath.row].valueForKey("nameWorkout") as? String
        return cell
    }
    
    override func tableView(tableView: UITableView, accessoryButtonTappedForRowWithIndexPath indexPath: NSIndexPath) {
        print("information yes")
    }
    
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    

    
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // remove from list
            workout.removeAtIndex(indexPath.row)
            // remove from core data
            //print(workout[indexPath.row].valueForKey("nameWorkout") as? String)
            managedContext.deleteObject(workout[indexPath.row] as NSManagedObject)
            do {
                try managedContext.save()
            } catch let error as NSError  {
                print("Could not save \(error), \(error.userInfo)")
            }
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    

    
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {
        let item = workout[fromIndexPath.row];
        // remove and insert from table
        workout.removeAtIndex(fromIndexPath.row);
        workout.insert(item, atIndex: toIndexPath.row)
        // remove and insert from code data
        
    }
    

    
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
