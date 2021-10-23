//
//  ViewController.swift
//  YES_EYES
//
//  Created by mgpark on 2021/07/24.
//

import UIKit

class ViewController: UIViewController {
    
    var settingModel = [[SettingModel]]()
    
    @IBOutlet weak var settingTableView: UITableView!
    
    var cart = Cart()
    
    func makeData(){
        settingModel.append([
            SettingModel(mainTitle: "QR 및 위시리스트")])
        settingModel.append([
            SettingModel(mainTitle: "상품 쇼핑"),
            SettingModel(mainTitle: "상품 인식"),
            SettingModel(mainTitle: "도움말")])
        }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    override func viewDidLoad(){
        super.viewDidLoad()
        
        settingTableView.delegate = self
        settingTableView.dataSource = self
        settingTableView.backgroundColor = UIColor(displayP3Red: 228/255, green: 231/255, blue: 246/255, alpha:0)
        //ViewController -> add Cell
        settingTableView.register(UINib(nibName: "MenuCell", bundle: nil), forCellReuseIdentifier: "MenuCell")
        title = "YES EYES"
        navigationController?.navigationBar.prefersLargeTitles = true
//        self.view.backgroundColor
        makeData()
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingModel[section].count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return settingModel.count
    }
    
    //5. didselectrowat
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.section == 0 && indexPath.row == 0{
            if let QRVC = UIStoryboard(name: "QRViewController", bundle: nil).instantiateViewController(identifier: "QRViewController") as? QRViewController{
                QRVC.cart = self.cart
                self.navigationController?.pushViewController(QRVC, animated: true)
            }
        }
        
        else if indexPath.section == 1 && indexPath.row == 0{
            if let StoreVC = UIStoryboard(name: "StoreViewController", bundle: nil).instantiateViewController(identifier: "StoreViewController") as? StoreViewController{
                self.navigationController?.pushViewController(StoreVC, animated: true)
            }
        }
        
        else if indexPath.section == 1 && indexPath.row == 1{
            if let AIVC = UIStoryboard(name: "AIViewController", bundle: nil).instantiateViewController(identifier: "AIViewController") as? AIViewController{
                self.navigationController?.pushViewController(AIVC, animated: true)
            }
        }
        
        if indexPath.section == 1 && indexPath.row == 2{
            if let HelpVC = UIStoryboard(name: "HelpViewController", bundle: nil).instantiateViewController(identifier: "HelpViewController") as? HelpViewController{
                self.navigationController?.pushViewController(HelpVC, animated: true)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuCell", for: indexPath) as! MenuCell
        
        cell.menuTitle.text = settingModel[indexPath.section][indexPath.row].mainTitle
//        cell.rightImageView.image = UIImage(systemName: settingModel[indexPath.section][indexPath.row].rightImageName ?? "")
        
        return cell
    }
    
    //cell height
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}
