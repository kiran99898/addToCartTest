//
//  SqlManager.swift
//  addToCartTest
//
//  Created by kiran on 1/20/19.
//  Copyright © 2019 kiran. All rights reserved.
//

import Foundation
import SQLite3

class SqlManager {
    var  db: OpaquePointer?
    //MARK: - CREATE DATABASE
    func createDatabase() {
        let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent("AddToCart.sqlite")
        
        if sqlite3_open(fileURL.path, &db) != SQLITE_OK {
            print("error opening database")
            return
        }
        
        //Create table for Users
        
        if sqlite3_exec(db, "CREATE TABLE  IF NOT EXISTS Cart (Id INTEGER PRIMARY KEY AUTOINCREMENT, Name TEXT, Title TEXT)", nil, nil, nil) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error creating table: \(errmsg)")
            return
        }else{
            print("success creating CartTable")
        }
        
        
}
    
    
    
    
    func putCartData(name: String, title: String) {
        createDatabase()
        let updateStatementString = "INSERT INTO Cart (Name, Title) VALUES (\"\(name)\",\"\(title)\");"
        print(updateStatementString)
        var updateStatement: OpaquePointer? = nil
        
        if sqlite3_prepare_v2(db, updateStatementString, -1, &updateStatement, nil) == SQLITE_OK {
            if sqlite3_step(updateStatement) == SQLITE_DONE {
                print("Successfully insert Cart data.")
            } else {
                print("Could not insert cart data.")
            }
        } else {
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error preparing insert: \(errmsg)")
            print("UPDATE statement could not be prepared")
        }
    }
    
    
    
    func getCartData() -> [DataModel]{
        createDatabase()
        var cartData = [DataModel]()
        var stmt:OpaquePointer?
        let queryString = "SELECT * FROM Cart;"
        
        if sqlite3_prepare(db, queryString, -1, &stmt, nil) != SQLITE_OK{
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error preparing insert: \(errmsg)")
            return cartData
        }
        while(sqlite3_step(stmt) == SQLITE_ROW){
            let userDict:[String: String] = [
                "id" : String(cString: sqlite3_column_text(stmt, 0)),
                "name" : String(cString: sqlite3_column_text(stmt, 1)),
                "title" : String(cString: sqlite3_column_text(stmt, 2))
                ]
            cartData.append(DataModel(name: userDict["name"]! , title: userDict["title"]!))
        }
        return cartData
    }




}
