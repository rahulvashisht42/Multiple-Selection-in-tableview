//
//  ViewController.swift
//  MultipleSelectionTableView
//
//  Created by Rahul Sharma on 15/09/17.
//  Copyright © 2017 Rahul Sharma. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    var item = items
    var itemsToDelete = [Int]()

    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.allowsMultipleSelectionDuringEditing = true
        tableView.tableFooterView = UIView()
        
        
        //Mark: Setting button on left on navigation bar
        let edit = UIBarButtonItem(title: "Edit", style: UIBarButtonItemStyle.plain, target: self, action: #selector(btnEdit))
        
        self.navigationItem.leftBarButtonItem = edit
        
        //Mark: Setting button on left on navigation bar
        let del = UIBarButtonItem(title: "Delete", style: UIBarButtonItemStyle.plain, target: self, action: #selector(btnDelete))
        del.isEnabled = false
        self.navigationItem.rightBarButtonItem = del
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - Table view data source
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return item.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = item[indexPath.row].title
        
        return cell
    }
    
    // Override to support editing the table view.
     func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }

    
    //Mark:
    func btnEdit(){
        
        if tableView.isEditing == true{
            
            self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(btnEdit))
            tableView.setEditing(false, animated: true)
            self.navigationItem.rightBarButtonItem?.isEnabled = false

        }else{
            
            self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(btnEdit))
            tableView.setEditing(true, animated: true)
            self.navigationItem.rightBarButtonItem?.isEnabled = true
            
        }
        
    }

    //Mark:
    func btnDelete(){
        for i in (tableView.indexPathsForSelectedRows as NSArray?)!{
            let x = i as! IndexPath
            itemsToDelete.append(x.row)
            
        }
        
        // sorted to delete items
        
        itemsToDelete = itemsToDelete.sorted {$0 < $1}
        
        
        for i in (0...itemsToDelete.count - 1 ).reversed(){
            self.item.remove(at: itemsToDelete[i])
        }
        
        itemsToDelete.removeAll()
        
        tableView.deleteRows(at: tableView.indexPathsForSelectedRows!, with: .automatic)
    }
    
    
    

}

