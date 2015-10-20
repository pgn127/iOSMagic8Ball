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
    var baseURL: String = "http://li859-75.members.linode.com/retrieveAllEntries.php"
    var dataRetrieved = false

    @IBOutlet weak var doneButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        retrieveData()
        
        //self.questionresponses = ViewController.questionresponses
     

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    func retrieveData(){
        let urlComponents = NSURLComponents(string: baseURL)!
        let url = urlComponents.URL!
        //print("url is: \(url)")
        
        let session = NSURLSession.sharedSession()
        let request = NSMutableURLRequest(URL: url)
        request.HTTPMethod = "GET"
        let task = session.dataTaskWithRequest(request) {
            (data, response, error) -> Void in
            
                if let e = error {
                    print("Error trying to GET \(e.localizedDescription)")
                    return
                } else if let d = data, let r = response as? NSHTTPURLResponse {
                    
                    if (r.statusCode == 200){
                        
                        let result = NSString(data: d, encoding:NSUTF8StringEncoding)! as String
                        print("result is \(result)")
                        //do {
                        //let json = JSON(data: d)
                        if let data = result.dataUsingEncoding(NSUTF8StringEncoding) {
                            let json = JSON(data: data)
                            
                            for item in json.arrayValue {
                                print("looping through json keys and values")
                                if let ques = item["question"].string, answ = item["answer"].string, user = item["username"].string, img = item["imageURL"].string {
                                    self.historyArray.append(QuestionResponseModel(question: ques, response: answ, user: user, imageURL: img))
                                    print("history array count \(self.historyArray.count)")
                                    print("question\(ques)")
                                }

                            }
                        }
                        
//                            for (key,subJson):(String,JSON) in json {
//                                print("looping through json keys and values")
//                                if let ques = subJson["question"].string, answ = subJson["answer"].string, user = subJson["username"].string, img = subJson["imageURL"].string {
//                                    self.historyArray.append(QuestionResponseModel(question: ques, response: answ, user: user, imageURL: img))
//                                    print("history array count \(self.historyArray.count)")
//                                    print("question\(ques)")
//                                }
//                            //}
//                        } //catch let error as NSError {
                           // print("json parsing error \(error.localizedDescription)")
                        //}
                        self.dataRetrieved = true
                        print("about to reload data")
                        dispatch_async(dispatch_get_main_queue(), { () -> Void in
                            self.tableView.reloadData()
                        })
                        
                    }
            }
        }
        task.resume()
    }
    
    
//                    //print("query result \(result)")
//                    do{
//                        //print("current order \(order)")
//                        let json = try NSJSONSerialization.JSONObjectWithData(d, options:NSJSONReadingOptions.AllowFragments )
//                        //print("current order \(order)")
//                        guard let dict : NSDictionary = json as? NSDictionary else {
//                            print("not a dictionary")
//                            return
//                        }
//                        if let date = dict["date"] as? String, img = dict["url"] as? String{
//                            //print("date and image found for date \(date)")
//                            //print("datestring after calling request: \(self.datestring)")
//                            //print("current order \(order)")
//                            self.fetchImage(img, withDate: date, currentCount: order)
//                            //print("imageurl: \(self.imageurl)")
//                            
//                        }  else{
//                            print("date and image not found in json string")
//                        }
//                    } catch {
//                        print("json error")
//                    }
//                }
//                
//        })
//        //print("perform function reached")
//        task.resume()

    
    


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
        print("num of cells \(historyArray.count)")
        return historyArray.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        print("loading tableview")
        let cell = tableView.dequeueReusableCellWithIdentifier("qrCell", forIndexPath: indexPath) 
        //cell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "qrCell")
        let userpic = cell.contentView.viewWithTag(1) as! UIImageView
        let ques = cell.contentView.viewWithTag(2) as! UILabel
        let resp = cell.contentView.viewWithTag(3)as! UILabel
        if dataRetrieved {
            print("data avaialble and about to be loaded")
        let qrModel = historyArray[indexPath.row]
        //userpic.image = UIImage(qrModel.imageURL)
        ques.text = qrModel.question
        resp.text = qrModel.response
        if let url = NSURL(string: qrModel.imageURL){
            let session = NSURLSession.sharedSession()
            let task = session.dataTaskWithURL(url, completionHandler: {(data,response,error) in
                if let e = error {
                    print("error with image url \(e.localizedDescription)")
                } else if let d = data, img = UIImage(data: d) {
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        userpic.image = img
                    })
                    
                    
                }
            })
            task.resume()
        }
        }

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
        print("done")
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
    


