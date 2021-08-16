//
//  CUSearchViewController.swift
//  YES_EYES
//
//  Created by mgpark on 2021/07/29.
//

import UIKit
import FirebaseDatabase

//class CUSearchCell : UITableViewCell{
//    @IBOutlet weak var SearchLabel: UILabel!
//
//}

class CUTableViewController: UITableViewController {
}

class CUSearchViewController: UIViewController {

    @IBOutlet weak var searchBarContainerView: UIView!

    private var cuTableViewController: CUTableViewController?
    private var searchController: UISearchController = {
        return UISearchController(searchResultsController: nil)
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchBar()
        setupNavigationBarTitle()
    }

    private func setupNavigationBarTitle() {
        title = "상품 검색"
    }
}

extension CUSearchViewController {
    private func setupSearchBar() {
        searchController.delegate = self
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.placeholder = "검색 창"
        searchController.searchBar.translatesAutoresizingMaskIntoConstraints = true
        searchController.searchBar.frame = searchBarContainerView.bounds
        searchController.searchBar.autoresizingMask = [.flexibleWidth]
        searchBarContainerView.addSubview(searchController.searchBar)
        definesPresentationContext = true
    }
}

extension CUSearchViewController: UISearchControllerDelegate {
    func willPresentSearchController(_ searchController: UISearchController) {
        print(#function, "updateQueriesSuggestions")
    }

    func willDismissSearchController(_ searchController: UISearchController) {
        print(#function, "updateQueriesSuggestions")
    }

    func didDismissSearchController(_ searchController: UISearchController) {
        print(#function, "updateQueriesSuggestions")
    }
}

extension CUSearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text, !searchText.isEmpty else { return }
        searchController.isActive = false
        print(searchText)
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        print("cancel")
    }
}

//
//struct CUSearchModel{
//    var CUtitle = ""
//    var price = ""
//    var info = ""
//}
//
//class CUSearchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
//
//    @IBOutlet weak var CUSearchBarContainerView: UIView!
////    @IBOutlet weak var CUSearchBar: UISearchBar!
//
//    private var cuTableViewController: CUTableViewController?
//    private var searchController: UISearchController = {
//        return UISearchController(searchResultsController: nil)
//
//    var model = [[CUSearchModel]]()
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // section 별 개수 출력
//        return model[section].count
//    }
//
//    func numberOfSections(in tableView: UITableView) -> Int {
//        // 상품 데이터 개수만큼 라벨 출력
//        return model.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath)
//        as! ItemCell
//
//        // 상품명과 가격 값을 라벨에 표시
//        cell.Title.text = model[indexPath.section][indexPath.row].CUtitle
//        cell.Price.text = model[indexPath.section][indexPath.row].price
////        tableView.deselectRow(at: indexPath, animated: true)
//        return cell
//    }
//
//    @IBOutlet weak var CUSearchTableView: UITableView!
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        CUSearchBar.delegate = self;
//
//        CUSearchTableView.delegate = self
//        CUSearchTableView.dataSource = self
//        CUSearchTableView.register(UINib(nibName: "ItemCell", bundle: nil), forCellReuseIdentifier: "ItemCell") // ItemCell xib 등록
//
//        self.title = "CU"
//        self.navigationController?.navigationBar.prefersLargeTitles = false
//
//        let ref: DatabaseReference! = Database.database().reference()
//        // var handle: DatabaseHandle!
//
//        ref.child("cu").child("instant").observeSingleEvent(of: .value) { (snapshot) in
//            for child in snapshot.children {
//                let snap = child as! DataSnapshot
//
//                let item = snap.value as! [String: Any]
//
//                let CUtitle = item["title"] ?? ""
//                let price = item["price"] ?? ""
//                let info = item["info"] ?? ""
//
//                self.model.append([CUSearchModel(CUtitle: CUtitle as! String, price: price as! String, info: info as! String)])
//            }
//            self.CUSearchTableView.reloadData()
//        }
//    }
//}

//extension CUSearchViewController: UISearchBarDelegate{
//    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
//        guard let searchText = searchBar.text, !searchText.isEmpty else { return }
//        searchController.isActive = false
//        print(searchText)
//    }
//
//    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
//        print("cancel")
//    }
//}

//
////
////  CUSearchViewController.swift
////  YES_EYES
////
////  Created by mgpark on 2021/08/05.
////
//// CU_Search
//
//import UIKit
//import FirebaseDatabase
//
//class CUSearchCell : UITableViewCell{
//    @IBOutlet weak var topLabel: UILabel!
//}
//
//struct CUModel{
//    var title = ""
//    var price = ""
//    var info = ""
//}
//
//class CUSearchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
//
//    var model = [[CUModel]]()
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return model[section].count
//    }
//
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return model.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath)
//        as! ItemCell
//
//        cell.Title.text = model[indexPath.section][indexPath.row].title
//        cell.Price.text = model[indexPath.section][indexPath.row].price
//
//        return cell
//    }
//
//    @IBOutlet weak var CUSearchTableView: UITableView!
//
//    var text: String = ""
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        CUSearchTableView.delegate = self
//        CUSearchTableView.dataSource = self
//
//        self.title = "[CU] 상품 검색"
//        self.navigationController?.navigationBar.prefersLargeTitles = false
//
//        CUSearchTableView.register(UINib(nibName: "ItemCell", bundle: nil), forCellReuseIdentifier: "ItemCell") // ItemCell xib 등록
//
//        var route: String = ""
//
//        if text == "0" { route = "drink" }
//        else if text == "1" { route = "snack" }
//        else if text == "2" { route = "icecream" }
//        else if text == "3" { route = "food" }
//
//        let ref: DatabaseReference! = Database.database().reference()
//        // var handle: DatabaseHandle!
//
//        ref.child("cu").child(route).observeSingleEvent(of: .value) { (snapshot) in
//            for child in snapshot.children {
//                let snap = child as! DataSnapshot
//
//                let item = snap.value as! [String: Any]
//
//                let title = item["title"] ?? ""
//                let price = item["price"] ?? ""
//                let info = item["info"] ?? ""
//
//                self.model.append([CUModel(title: title as! String, price: price as! String, info: info as! String)])
//            }
//            self.CUSearchTableView.reloadData()
//        }
//    }
//}
