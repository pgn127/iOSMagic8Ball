//
//  HistoryViewController.swift
//  Magic 8 Ball
//
//  Created by Pamela Needle on 8/25/15.
//  Copyright (c) 2015 Pamela Needle. All rights reserved.
//

import UIKit

class HistoryViewController: UITableViewController {
    
    var historyArray: [QuestionResponseModel] = []

    @IBOutlet weak var doneButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.questionresponses = ViewController.questionresponses
        //or qacell in
        //loadQuesResp()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    //helper testing
    func loadQuesResp(){
        let q1 = "Will I get full marks for this lab?"
        let resp1 = "No"
        historyArray += [QuestionResponseModel(question: q1, response: resp1)]
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
        
        return historyArray.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("qrCell", forIndexPath: indexPath) as! UITableViewCell
        //cell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "qrCell")
        let qrModel = historyArray[indexPath.row]
        cell.textLabel!.text = qrModel.question
        cell.detailTextLabel!.text = qrModel.response
        

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

    
    // MARK: - Navigation

    @IBAction func donePressed(sender: AnyObject) {
        self.dismissViewControllerAnimated(false, completion: nil)
        println("done")
    }
    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?, historyArray: [QuestionResponseModel]) {
//        // Get the new view controller using [segue destinationViewController].
//        // Pass the selected object to the new view controller.
//        if (segue.identifier == "DoneViewing") {
//            //if let target = segue.destinationViewController as? ViewController
//            //target.name = self.nameText.text
//        }
    }    
    


