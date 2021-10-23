//
//  HelpViewController.swift
//  YES_EYES
//
//  Created by 반예원 on 2021/07/27.
//

import UIKit
class HelpCell: UITableViewCell{
    
    @IBOutlet weak var topLabel: UILabel!
    
    @IBOutlet weak var centerImageView: UIImageView!
      
    @IBOutlet weak var bottomLabel: UILabel!
}
struct HelpModel{
    var mainTitle = ""
    var bottomlabel = ""
    
}
class HelpViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var model = [HelpModel]()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HelpCell", for: indexPath)
        as! HelpCell
        cell.topLabel.text = model[indexPath.section].mainTitle
        
        cell.bottomLabel.text = model[indexPath.section].bottomlabel
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0{
            if let HelpVC2 = UIStoryboard(name: "HelpViewController2", bundle: nil).instantiateViewController(identifier: "HelpViewController2") as? HelpViewController2{
                self.navigationController?.pushViewController(HelpVC2, animated: true)
            }
        }
    }
    
    @IBOutlet weak var helpTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        helpTableView.delegate = self
        helpTableView.dataSource = self
    
        title = "도움말"
        model.append(HelpModel(mainTitle: "메인화면 전환 안내",bottomlabel: "손가락을 이용하여 화면을 넘겨주세요"))
    }
}
