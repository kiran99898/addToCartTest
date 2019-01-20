//
//  cart.swift
//  addToCartTest
//
//  Created by kiran on 1/19/19.
//  Copyright © 2019 kiran. All rights reserved.
//

import UIKit

class Cart: UITableViewController {
    
    let newSqlManager = SqlManager()
    
    var updatedArray = [DataModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        updatedArray = newSqlManager.getCartData()
        tableView.reloadData()
        
       
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
return 1
        
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return updatedArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
       // cell.textLabel?.text = DataA[indexPath.row].name
        cell.textLabel?.text = updatedArray[indexPath.row].name
        return cell
    }
    
    
 

 
}
