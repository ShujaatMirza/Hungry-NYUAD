//
//  SelectRestaurant.swift
//  Hungry-NYUAD
//
//  Created by Mawutor Ama Abalo on 11/24/17.
//  Copyright © 2017 Software Engineering Group. All rights reserved.
//

import UIKit
import Firebase

class SelectRestaurant: UITableViewController {
    @IBOutlet var theTableView: UITableView!
    
    var ref: DatabaseReference!
    let reuseIdentifier = "reuseIdentifier"
    var rowCount: Int = 0
    var restaurantInfo: [Restaurant] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.tableView.contentInset = UIEdgeInsetsMake(0, -15, 0, -15)
        ref = Database.database().reference()
        ref.child("restaurants").observeSingleEvent(of: .value, with: { snapshot in
            print("The count is\(Int(snapshot.childrenCount))") // I got the expected number of items
            self.rowCount = Int(snapshot.childrenCount)
            self.restaurantInfo.removeAll()
            for rest in snapshot.children.allObjects as! [DataSnapshot] {
                let inf = rest.value as? NSDictionary
                let r = Restaurant(name: inf!["name"] as! String, hours: inf!["hours"] as! String, phone: inf!["phone"] as! String, website: inf!["website"] as! String)
                self.restaurantInfo.append(r)
            }
            
            self.tableView.reloadData()
        })
        setTableViewBackgroundGradient(sender: self, cgColor(red: 10, green: 143, blue: 173), cgColor(red: 66, green: 134, blue: 244))
        //self.tableView.register(RestaurantTableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        print("Here")
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
    }
    
    func cgColor(red: CGFloat, green: CGFloat, blue: CGFloat) -> CGColor {
        return UIColor(red: red/255.0, green: green/255.0, blue: blue/255.0, alpha: 1.0).cgColor
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // method to run when table view cell is tapped
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // note that indexPath.section is used rather than indexPath.row
        print("You tapped cell number \(indexPath.section).")
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return self.rowCount
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }

    // Set the spacing between sections
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    
    // Make the background color show through
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        return headerView
    }
    
    func setTableViewBackgroundGradient(sender: UITableViewController, _ topColor:CGColor, _ bottomColor:CGColor) {
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = sender.tableView.bounds
        gradientLayer.colors = [cgColor(red: 10, green: 143, blue: 173),
                                cgColor(red: 66, green: 134, blue: 244)]
        
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0, y: 1)
        let backgroundView = UIView(frame: sender.tableView.bounds)
        backgroundView.layer.addSublayer(gradientLayer)
        sender.tableView.backgroundView = backgroundView
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let cell: RestaurantTableViewCell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! RestaurantTableViewCell
        guard let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as? RestaurantTableViewCell  else {
            fatalError("The dequeued cell is not an instance of RestaurantTableViewCell.")
        }
        cell.hours.text = restaurantInfo[indexPath.section].hours
        cell.nameLabel.text = restaurantInfo[indexPath.section].name
        cell.backgroundColor = UIColor.clear
        // Configure the cell...
        // add border and color
        cell.backgroundColor = UIColor.clear
        
        cell.contentView.backgroundColor = UIColor.clear
        cell.board.layer.masksToBounds = false
        cell.board.layer.cornerRadius = 3
        cell.board.layer.shadowColor = UIColor.black.cgColor
        cell.board.layer.shadowOpacity = 0.5
        cell.board.layer.shadowPath = UIBezierPath(rect: cell.board.bounds).cgPath
        cell.board.layer.shadowOffset = CGSize(width: -1, height: 3)
        cell.board.layer.shouldRasterize = true
        //cell.contentView.layer.borderWidth = 1
        //cell.contentView.layer.borderColor = UIColor.red.cgColor
        //cell.layer.borderColor = UIColor.black.cgColor
        //cell.layer.borderWidth = 1
        
        cell.clipsToBounds = true

        return cell
    }


    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
