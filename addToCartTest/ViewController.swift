//
//  ViewController.swift
//  addToCartTest
//
//  Created by kiran on 1/19/19.
//  Copyright © 2019 kiran. All rights reserved.
//

import UIKit



class ViewController: UIViewController {
    
    var cartA = [DataModel]()
    
    
    
    var runningDataArray = [DataModel]()
    let helloDataArray = DataArray()
    
    let newSqlManager = SqlManager()
   
    @IBOutlet weak var CV: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
         newSqlManager.createDatabase()
        cartA = newSqlManager.getCartData()
        badG(cartArr: cartA)
//        let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
//        print(documentsPath)
        runningDataArray =  helloDataArray.dataArray()
        if runningDataArray.count != 0 {
            CV.reloadData()
        }
        
        CV.delegate = self
        CV.dataSource = self
       // badG()
        
    }
    
    func badG(cartArr: [DataModel]){
        let label = UILabel(frame: CGRect(x: 25, y: -10, width: 30, height: 30))
        label.layer.borderColor = UIColor.clear.cgColor
        label.layer.borderWidth = 2
        label.layer.cornerRadius = label.bounds.size.height / 2
        label.textAlignment = .center
        label.layer.masksToBounds = true
        label.font = UIFont(name: "SanFranciscoText-Light", size: 13)
        label.textColor = .white
        label.backgroundColor = .red
        label.text = "\(cartArr.count)"
        
        
        let lbl = UIView()
        
        // button
        let rightButton = UIButton(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        rightButton.setBackgroundImage(UIImage(named: "inbox"), for: .normal)
        rightButton.addTarget(self, action: #selector(cartButtonTapped), for: .touchUpInside)
        if cartArr.count != 0 {
            rightButton.addSubview(label)
        } else{
            rightButton.addSubview(lbl)
        }
        
        // Bar button item
        let rightBarButtomItem = UIBarButtonItem(customView: rightButton)
        
        navigationItem.rightBarButtonItem = rightBarButtomItem
        
    }
    
    
    
    
    func rightButtonTouched() {
        print("right button touched")
    }

        
        
      @objc
    func cartButtonTapped(){
        let vc = storyboard?.instantiateViewController(withIdentifier: "Cart"  ) as? Cart
        navigationController?.pushViewController(vc!, animated: true)
    }
        
        
       
    }





extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return runningDataArray.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = CV.dequeueReusableCell(withReuseIdentifier: "NewCollCell", for: indexPath) as? NewCollCell
        cell?.label1.text = runningDataArray[indexPath.row].name
        cell?.label2.text = runningDataArray[indexPath.row].title
        cell?.btnPressed.tag = indexPath.row
        cell?.btnPressed.addTarget(self, action: #selector(addButtonPressed), for: .touchUpInside)
        return cell!
    }
    
    @objc
    func addButtonPressed(sender: UIButton){
        let productDetail = runningDataArray[sender.tag]
        guard let name = productDetail.name else { return }
        print("buttonpresed")
        guard let title = productDetail.title else { return }
        newSqlManager.putCartData(name: name, title: title)
        cartA =  newSqlManager.getCartData()
        badG(cartArr: cartA)
        
        
        
    }
    

    
    
}
