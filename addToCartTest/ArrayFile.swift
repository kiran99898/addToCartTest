//
//  ArrayFile.swift
//  addToCartTest
//
//  Created by kiran on 1/19/19.
//  Copyright © 2019 kiran. All rights reserved.
//

import Foundation
struct DataArray {
    func dataArray()-> [DataModel]{
        var DataArray = [DataModel]()
        DataArray.append(DataModel(name: "John", title: "CEO"))
        DataArray.append(DataModel(name: "JackyBoy", title: "NiceMan"))
         DataArray.append(DataModel(name: "JackyBoy", title: "DiceMan"))
         DataArray.append(DataModel(name: "MackyBoy", title: "RiceMan"))
         DataArray.append(DataModel(name: "YackyBoy", title: "LiceMan"))
         DataArray.append(DataModel(name: "NackyBoy", title: "TiceMan"))
         DataArray.append(DataModel(name: "MackyBoy", title: "MiceMan"))
      
        
        
        return DataArray
    }
  
}


