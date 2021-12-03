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
    func initTitle() {
         // 내비게이션 타이틀 레이블
         let nTitle = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 40))
         
         // 타이틀 속성
         nTitle.numberOfLines = 2
         nTitle.textAlignment = .center
         nTitle.font = UIFont.systemFont(ofSize: 25)
         nTitle.text = "YES EYES"
        nTitle.textColor = UIColor.white;
         
         self.navigationItem.titleView = nTitle // titleView속성은 뷰 기반으로 타이틀을 사용할 수 있음
     }
    override func viewDidLoad(){
        super.viewDidLoad()
     
        settingTableView.delegate = self
        settingTableView.dataSource = self
        view.backgroundColor = UIColor(red: 101/255, green: 115/255, blue: 177/255, alpha: 1)
        //ViewController -> add Cell
        settingTableView.register(UINib(nibName: "MenuCell", bundle: nil), forCellReuseIdentifier: "MenuCell")
        
        settingTableView.backgroundColor = UIColor(red: 101/255, green: 115/255, blue: 177/255, alpha: 1)
        settingTableView.tintColor = UIColor(red: 101/255, green: 115/255, blue: 177/255, alpha: 1)
       
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
        cell.backgroundColor=UIColor(red: 220/255, green: 212/255, blue: 233/255, alpha: 1)
        cell.menuTitle.text = settingModel[indexPath.section][indexPath.row].mainTitle
        cell.menuTitle.textColor = UIColor(red: 101/255, green: 115/255, blue: 177/255, alpha: 1)
//        cell.rightImageView.image = UIImage(systemName: settingModel[indexPath.section][indexPath.row].rightImageName ?? "")
       
        return cell
    }
    
    //cell height
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}
