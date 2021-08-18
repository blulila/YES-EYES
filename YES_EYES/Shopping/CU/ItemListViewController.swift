//
//  ItemListViewController.swift
//  YES_EYES
//
//  Created by User on 2021/08/18.
//

import UIKit

class ItemListViewController: UIViewController {
    
    
    @IBOutlet weak var cartButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    let items:[Item] = ItemListHelper().all()
    var cart = Cart()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "상품 리스트"
        tableView.delegate = self
        tableView.dataSource = self
        cartButton.layer.cornerRadius = cartButton.frame.height / 2
        cartButton.addTarget(self, action: #selector(didTabCartButton), for: .touchUpInside)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.cartButton.isEnabled = false
        self.cartButton.isEnabled = true
        
        cart.updateCart()
        self.cartButton.setTitle("Check(\(cart.items.count))", for: .normal)
        tableView.reloadData()
    }
    
    @objc func didTabCartButton() {
        let storyboard = UIStoryboard(name: "CartListViewController", bundle: nil)
        guard let viewController = storyboard.instantiateViewController(withIdentifier: "CartListViewController") as? CartListViewController else { fatalError() }
        viewController.cart = self.cart
        navigationController?.pushViewController(viewController, animated: true)
    }

}

extension ItemListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? ItemListTableViewCell else { fatalError() }
        let item = items[indexPath.row]
        
        cell.delegate = self
        cell.itemTitle.text = item.name
        cell.itemPrice.text = item.displayPrice()
        
        cell.setButton(state: self.cart.contains(product: item))
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
}

extension ItemListViewController: CartDelegate {
    func updateCart(cell: ItemListTableViewCell) {
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        let item = items[indexPath.row]
        
        cart.updateCart(with: item)
        
        self.cartButton.setTitle("Check(\(cart.items.count))", for: .normal)
    }
    
    
}

