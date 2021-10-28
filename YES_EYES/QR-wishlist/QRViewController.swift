//
//  QRViewController.swift
//  YES_EYES
//
//  Created by mgpark on 2021/07/25

import UIKit


class QRCell: UITableViewCell{
    
    @IBOutlet weak var wishlistTitle: UILabel!
    @IBOutlet weak var rightImageView: UIImageView!
//    {
//        didSet{
//            rightImageView.image = UIImage.init(systemName: "trash")
//        }
//    }
    
//    override var accessibilityCustomActions: [UIAccessibilityCustomAction]? {
//        get {
//            let moveUp = UIAccessibilityCustomAction(name: "move up", actionHandler: { (action) -> Bool in
//                print("move up 선택")
//                return true
//            })
//            let moveDown = UIAccessibilityCustomAction(name: "move down", actionHandler: { (action) -> Bool in
//                print("move down 선택")
//                return true
//            })
//            return [moveUp, moveDown]
//        }
//        set {}
//    }
}


struct QRModel{
    var wishlist = ""
}

class QRViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, CartItemDelegate {
    public var qrstr: String = "https://yeseyes.web.app/?"
    
    @IBOutlet weak var ImageView: UIImageView!

    func updateCartItem(cell: CartListTableViewCell, quantity: Int) {
        guard let indexPath = QRTableView.indexPath(for: cell) else { return }
        guard let cartItem = cart?.items[indexPath.row] else { return }
        guard let reitems = cart?.items else { return }
        reitems[indexPath.row].quantity = quantity
        cart?.changeData(changeitems: reitems)
        // cartItem.quantity = quantity
        
        qrstr="https://yeseyes.web.app/?";
        QRTableView.reloadData()
        
    }
    
    var cart: Cart? = nil

    var model = [CU1Model]()

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cart?.items.count ?? 0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) ->
        UITableViewCell {
    
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? CartListTableViewCell else { fatalError() }
        
        if let cartItem = cart?.items[indexPath.row]{

            cell.delegate = self as CartItemDelegate
     
            cell.itemTitle.text = cartItem.item.title
            cell.itemPrice.text = cartItem.item.price
            
            cell.countLabel.text = String(describing: cartItem.quantity)
            cell.quantity = cartItem.quantity
            
            // print(cartItem.item.title)
//            qrstr.append(cartItem.item.title+cartItem.item.price+"&")
        
            if(indexPath.row==Int(cart?.items.count ?? 0)-1){
                qrstr.append(cartItem.item.title+"="+String(describing: cartItem.quantity))
            }
            else{qrstr.append(cartItem.item.title+"="+String(describing: cartItem.quantity)+"&")
                
            }
            
            
        }
        print(qrstr)
        self.refreshQRCode()
        return cell
    }
    

    func refreshQRCode() {
 
        let text:String = qrstr;
  
        // Generate the image
        guard let qrCode:CIImage = self.createQRCodeForString(text) else {
            print("Failed to generate QRCode")
            self.ImageView.image = nil
            return
        }
        
        // Rescale to fit the view (otherwise it is only something like 100px)
        let viewWidth = self.ImageView.bounds.size.width;
        let scale = viewWidth/qrCode.extent.size.width;
        let scaledImage = qrCode.transformed(by: CGAffineTransform(scaleX: scale, y: scale))
        
        // Display
        self.ImageView.image = UIImage(ciImage: scaledImage)
    }
    
    func createQRCodeForString(_ text: String) -> CIImage?{
        let data = text.data(using: .utf8)
        
        let qrFilter = CIFilter(name: "CIQRCodeGenerator")
        // Input text
        qrFilter?.setValue(data, forKey: "inputMessage")
        // Error correction
        let values = ["L", "M", "Q", "H"]
        // Trick to limit the result to the bounds (0, array.maxIndex) - max(_MIN_, min(_value_, _MAX_))

     
        return qrFilter?.outputImage
    }


//    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//
//        if editingStyle == .delete {
//            cart?.updateCart(with: cart!.items[indexPath.row].getItem())
//            tableView.deleteRows(at: [indexPath], with: .fade)
//            qrstr="https://yeseyes.web.app/?";
//            self.QRTableView.reloadData()
//
//       } else if editingStyle == .insert {
//
//            self.QRTableView.reloadData()
//
//        }
//
//    }


    var newcart = Cart()
    
    @IBOutlet weak var InputField: UITextField!
    @IBOutlet weak var QrView: UIImageView!
    @IBOutlet weak var QRTableView: UITableView!
    
    @IBAction func ProductEnter(_ sender: Any) {
        
        let title = InputField.text
        let price = " "
        let info = " "
        
        self.model.append(CU1Model(title: title as! String, price: price as! String, info: info as! String))
        
        let item = model[model.count-1]
        if(title != "") {
            cart?.updateCart(with: item)
        }
        
        InputField.text = ""

        qrstr="https://yeseyes.web.app/?";
        QRTableView.reloadData()
    }
    
    @IBAction func clickdeletebtn(_ sender: UIButton) {
        let point = sender.convert(CGPoint.zero, to: QRTableView)
        guard let indexpath = QRTableView.indexPathForRow(at: point) else { return }
        cart?.updateCart(with: cart!.items[indexpath.row].getItem())
        QRTableView.deleteRows(at: [IndexPath(row: indexpath.row, section: 0)], with: .left)
        qrstr="https://yeseyes.web.app/?";
        QRTableView.reloadData()
        refreshQRCode()
    }
    
    
    @IBAction func AllEraseButton(_ sender: Any) {
        for key in UserDefaults.standard.dictionaryRepresentation().keys {
                UserDefaults.standard.removeObject(forKey: key.description)
        }
        // 키 말고 기존 데이터도 삭제 해야함
        QRTableView.reloadData()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        QRTableView.delegate = self
        QRTableView.dataSource = self
        self.title = "QR 및 위시리스트"
        self.navigationController?.navigationBar.prefersLargeTitles = false
        self.QRTableView.reloadData()
        // "Hello,world!" 가 Qr 로 형성되어있음
        self.refreshQRCode()
//        let QRCodeImage = generateQRCode(from:qrstr)
//        self.QrView.image = QRCodeImage
        
        print(qrstr)
   
    }
}
