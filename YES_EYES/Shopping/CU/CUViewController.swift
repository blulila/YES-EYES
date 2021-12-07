//
//  CUViewController.swift
//  YES_EYES
//
//  Created by mgpark on 2021/07/29.
//
// CU_discount_category

import UIKit
class CUCell : UITableViewCell{
    @IBOutlet weak var topLabel: UILabel!
}

struct CuModel{
    var mainTitle = ""
    var bottomlabel = ""
}

class CUViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var model = [[CuModel]]()
    var storeText: String = ""
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model[section].count
    }
    
    //4. numberofsections
    func numberOfSections(in tableView: UITableView) -> Int {
        return model.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CUCell", for: indexPath)
        as! CUCell
        
        cell.topLabel.text = model[indexPath.section][indexPath.row].mainTitle
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.section == 0 {
            if let CU1VC = UIStoryboard(name: "CU1ViewController", bundle: nil).instantiateViewController(identifier: "CU1ViewController") as? CU1ViewController{
                CU1VC.text = storeText + String(indexPath.row)
                self.navigationController?.pushViewController(CU1VC, animated: true)
            }
        }
    }

    @IBOutlet weak var CUTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        CUTableView.delegate = self
        CUTableView.dataSource = self
        self.title = "할인 상품"
        self.navigationController?.navigationBar.prefersLargeTitles = false
        
        model.append([
                CuModel(mainTitle: "음료"),
                CuModel(mainTitle: "과자"),
                CuModel(mainTitle: "아이스크림"),
                CuModel(mainTitle: "식품"),
                CuModel(mainTitle: "생활용품")
        ])
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }
}
