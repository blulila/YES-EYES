//
//  StoreViewController.swift
//  YES_EYES
//
//  Created by mgpark on 2021/07/27.
//

import UIKit

//2. storecell - class, identifier
class StoreCell: UITableViewCell{
    @IBOutlet weak var storeLabel: UILabel!
}

//3. model
struct StoreModel{
    var storeTitle = ""
}

class StoreViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var model = [[StoreModel]]()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model[section].count
    }
    
    //4. numberofsections
    func numberOfSections(in tableView: UITableView) -> Int {
        return model.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StoreCell", for: indexPath) as! StoreCell
        
        cell.storeLabel.text = model[indexPath.section][indexPath.row].storeTitle
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.section == 0 {
            if let CUSVC = UIStoryboard(name: "CUViewController", bundle: nil).instantiateViewController(identifier: "CUViewController") as? CUViewController{
                CUSVC.storeText = String(indexPath.row)
                self.navigationController?.pushViewController(CUSVC, animated: true)
            }
        }
    }
    
    //1. view class connection
    @IBOutlet weak var storeTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "상품 쇼핑"
        self.navigationController?.navigationBar.prefersLargeTitles = false
        
        storeTableView.delegate = self
        storeTableView.dataSource = self
        storeTableView.backgroundColor = UIColor(displayP3Red: 228/255, green: 231/255, blue: 246/255, alpha:0)
        
        model.append([
        StoreModel(storeTitle: "CU"),
        StoreModel(storeTitle: "GS25"),
        StoreModel(storeTitle: "이마트24"),
        StoreModel(storeTitle: "세븐일레븐"),
        StoreModel(storeTitle: "미니스톱")])
    }
}

/*
 1. view class connection
 2. storecell - class, identifier
 3. model
 4. numberofsections
 5. (ViewController) - didselectrowat
 */
