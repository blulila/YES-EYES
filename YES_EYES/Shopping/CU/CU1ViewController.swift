//
//  CUViewController.swift
//  YES_EYES
//
//  Created by mgpark on 2021/07/29.
//
// CU_category_item

import UIKit
import FirebaseDatabase

class CU1Cell : UITableViewCell{
    @IBOutlet weak var CU1Label: UILabel!
    
}

struct CU1Model: Codable, Equatable {
    var title = ""
    var price = ""
    var info = ""
    var sale = ""
}

class CU1ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var cart = Cart()
    @IBOutlet weak var cartButton: UIButton!
    var text: String = ""
    var product:Dictionary<String, String> = [String: String]()
    
//    var term = ""
    //Popup
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        let vc = segue.destination as! CU1ViewController
//        let cell = sender as! UITableViewCell
//        let indexPath = tableView.indexPath(for: cell)
//        vc.kindTitle = infoList[(indexPath?.row)!]//내가누른 cell의 text
//        vc.kindRow = (indexPath?.row)!//내가누른 cell의 row값
//    }
//
//    @IBAction func pop(_ sender: Any, for segue: UIStoryboardSegue) {
//
//        let storyboard = UIStoryboard.init(name: "Popup", bundle: nil)
//        let popUp = storyboard.instantiateViewController(identifier: "Popup")
//
//        popUp.modalPresentationStyle = .overCurrentContext
//        popUp.modalTransitionStyle = .crossDissolve
//
//        var index: Int = 0
//        self.delegate?.pop(index: index)
//
//        let temp = popUp as? PopupViewController
//
//        let vc = segue.destination as! CU1ViewController
//        let cell = sender as! ItemCell
//        let indexPath = tableView.indexPath(for: cell)
//        vc.kindTitle = infoList[(indexPath?.row)!]//내가누른 cell의 text
//
//        temp?.strText = "123"
//
//        self.present(popUp, animated: true,
//            completion: nil)
//    }
//
    var model = [CU1Model]()
    let searchController = UISearchController(searchResultsController: nil)
    
    var filtereditem = [CU1Model]()
    
    func isFiltering() -> Bool {
        return searchController.isActive && !searchBarIsEmpty()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if !filtereditem.isEmpty {
            print(filtereditem.count)
            return filtereditem.count
        }
        // section 별 개수 출력
        return model.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath)
        as! ItemCell
        // let item = model[indexPath.section][indexPath.row]
        
        let tmpItem: CU1Model
                
        if !filtereditem.isEmpty {
            tmpItem = filtereditem[indexPath.row]
        }
        else if CU1SearchBar.text != "" && filtereditem.isEmpty {
            tableView.separatorStyle = .none
            return cell
        }
        else {
            tmpItem = model[indexPath.row]
        }
        
        // 상품명과 가격 값을 라벨에 표시
        cell.delegate = self
        
        cell.Title.text = tmpItem.title
        cell.Price.text = tmpItem.price
//        tableView.deselectRow(at: indexPath, animated: true)
        cell.setButton(state: self.cart.contains(product: tmpItem))
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // performSegue(withIdentifier: "Popup", sender: nil)
        
        let storyboard = UIStoryboard.init(name: "Popup", bundle: nil)
        let popUp = storyboard.instantiateViewController(identifier: "Popup")
        
        popUp.modalPresentationStyle = .overCurrentContext
        popUp.modalTransitionStyle = .crossDissolve
        
        let temp = popUp as? PopupViewController
        let data = model[indexPath.row].info
        
        if data != "" { temp?.strText = data}
        else { temp?.strText = model[indexPath.row].sale}

        self.present(popUp, animated: true, completion: nil)
    }

    @IBOutlet weak var CU1SearchBar: UISearchBar!
    @IBOutlet weak var CU1TableView: UITableView!
    
    func searchBarIsEmpty() -> Bool {
          // Returns true if the text is empty or nil
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    func filterContentForSearchText(_ searchText: String, scope: String = "All") {
        filtereditem = model.filter({( item : CU1Model ) -> Bool in
        return item.title.contains(searchText)
        })
        
        CU1TableView.reloadData()
    }

    @objc func didTabCartButton() {
        let storyboard = UIStoryboard(name: "QRViewController", bundle: nil)
        guard let viewController = storyboard.instantiateViewController(withIdentifier: "QRViewController") as? QRViewController else { fatalError() }
        viewController.cart = self.cart
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.cartButton.isEnabled = false
        self.cartButton.isEnabled = true
        
        cart.updateCart()
        self.cartButton.setTitle("확인(\(cart.countItems()))", for: .normal)
//        tableView.reloadData()
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        definesPresentationContext = true
        
        CU1TableView.delegate = self
        CU1TableView.dataSource = self
        CU1SearchBar.delegate = self
        
        CU1TableView.register(UINib(nibName: "ItemCell", bundle: nil), forCellReuseIdentifier: "ItemCell") // ItemCell xib 등록
        cartButton.layer.cornerRadius = cartButton.frame.height / 2
        cartButton.addTarget(self, action: #selector(didTabCartButton), for: .touchUpInside)
        self.navigationController?.navigationBar.prefersLargeTitles = false
        
        let ref: DatabaseReference! = Database.database().reference()
        // var handle: DatabaseHandle!
        
        var route: String = ""
        var store: String = ""
        
        if text[text.startIndex] == "0" {
            self.title = "CU"
            store = "cu"
        }
        else if text[text.startIndex] == "1" {
            self.title = "GS25"
            store = "gs25"
        }
        else if text[text.startIndex] == "2" {
            self.title = "이마트24"
            store = "emart24"
        }
        else if text[text.startIndex] == "3" {
            self.title = "세븐일레븐"
            store = "7eleven"
        }
        else if text[text.startIndex] == "4" {
            self.title = "미니스톱"
            store = "ministop"
        }
        
        if text[text.index(before: text.endIndex)] == "0" { route = "drink" }
        else if text[text.index(before: text.endIndex)] == "1" { route = "snack" }
        else if text[text.index(before: text.endIndex)] == "2" { route = "icecream" }
        else if text[text.index(before: text.endIndex)] == "3" { route = "food" }
        else if text[text.index(before: text.endIndex)] == "4" { route = "convenience" }
        
        ref.child(store).child(route).observeSingleEvent(of: .value) { (snapshot) in
            for child in snapshot.children {
                let snap = child as! DataSnapshot
                
                let item = snap.value as! [String: Any]
                
                let title = item["title"] ?? ""
                let price = item["price"] ?? ""
                let info = item["info"] ?? ""
                let sale = item["EventName"] ?? ""
                
                self.model.append(CU1Model(title: title as! String, price: price as! String, info: info as! String, sale: sale as! String))
                self.product[title as! String] = info as? String
            }
            
            self.CU1TableView.reloadData()
        }
        
    }
        // 추후 함수 분리할 수 있으니 하단 주석은 남겨 둡니다.

    }


    
    
//func getData() {
//
//    var model = [[CU1Model]]()
//    let ref: DatabaseReference! = Database.database().reference()
//    var handle: DatabaseHandle!
//
//    handle = ref.child("cu").child("instant").observeSingleEvent(of: .value, with: { (snapshot) in
//        for child in snapshot.children {
//            let snap = child as! DataSnapshot
//
//            let item = snap.value as! [String: Any]
//
//            let title = item["title"] ?? ""
//            let price = item["price"] ?? ""
//            let info = item["info"] ?? ""
//
//            self.model.append([CU1Model(title: title as! String, price: price as! String, info: info as! String)])
//        }
//        // print(model)
//    })

/*
for i in range() {
    model.append([CU1Model(title: "상품이름", price: "상품가격")])
    // 데이터를 받아와서 이 형식으로 반복문 생성하면 에뮬레이터 화면에 상품명과 상품가격이 뜸
 }
*/

//}

extension CU1ViewController: UISearchBarDelegate, CartDelegate{

    func updateCart(cell: ItemCell) {
        guard let indexPath = CU1TableView.indexPath(for: cell) else { return }
        let item = model[indexPath.row]
        
        cart.updateCart(with: item)
        
        self.cartButton.setTitle("확인(\(cart.items.count))", for: .normal)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        guard let title: String = searchBar.text else { return }
        print(title)
        filterContentForSearchText(title)
        
//        let databaseRef = Database.database().reference().child("cu")
//        let query = databaseRef.queryOrdered(byChild: "title").queryStarting(atValue: title).queryEnding(atValue: "\(String(describing: title))\\uf8ff")
//
//        query.observeSingleEvent(of: .value) { (snapshot) in
//            guard snapshot.exists() != false else {
//                print("failing here")
//                return }
//            print(snapshot.value as Any)
//            DispatchQueue.main.async {
//
//                guard let dict = snapshot.value as? [String:Any] else {
//                    print(snapshot)
//                    return
//                }
//
//                let title = dict["title"] as? String
//                let price = dict["price"] as? String
//            }
//        }
    }
}

extension CU1ViewController: UISearchResultsUpdating {
  // MARK: - UISearchResultsUpdating Delegate
  func updateSearchResults(for searchController: UISearchController) {
    filterContentForSearchText(searchController.searchBar.text!)
  }
}
