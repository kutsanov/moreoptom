//
//  TovarViewController.swift
//  MoreOptom
//
//  Created by Vova Kutsanov on 07.04.2020.
//  Copyright © 2020 Vova Kutsanov. All rights reserved.
//

import UIKit

struct ImageStruct {
    let url: String
    let image: UIImage
}

class TovarViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet var olMainStackView: UIStackView!
    
    
    @IBOutlet var olName: UILabel!
    @IBOutlet var olPhotoCollection: UICollectionView!
    @IBOutlet var olLibFishName: UILabel!
    @IBOutlet var olLibTypeProductName: UILabel!
    @IBOutlet var olCityName: UILabel!
    @IBOutlet var olProducer: UILabel!
    @IBOutlet var olDtTovar: UILabel!
    @IBOutlet var olSize: UILabel!
    @IBOutlet var olPackWeight: UILabel!
    @IBOutlet var olNote: UILabel!
    @IBOutlet var olCost1Note: UILabel!
    @IBOutlet var olCost1Unit: UILabel!
    @IBOutlet var olCost1: UILabel!
    @IBOutlet var olCost2Note: UILabel!
    @IBOutlet var olCost2Unit: UILabel!
    @IBOutlet var olCost2: UILabel!
    @IBOutlet var olCost3Note: UILabel!
    @IBOutlet var olCost3Unit: UILabel!
    @IBOutlet var olCost3: UILabel!
    @IBOutlet var olFirmName: UILabel!
    
    @IBOutlet var olFirmPhone: UILabel!
    @IBOutlet var olFirmPhoneTitle: UILabel!
    @IBOutlet var olBlockPhone: UIView!
    
    @IBOutlet var olBlockAdv: UIView!
    @IBOutlet var olBlockNote: UIView!
    @IBOutlet var olBlockCost1: UIView!
    @IBOutlet var olBlockCost2: UIView!
    @IBOutlet var olBlockCost3: UIView!
    @IBOutlet var olBlockContact: UIView!
    
    var tovar: Tovar = Tovar()
    var priceItem: PriceItem!
    
    let heightImage = 128.0
    
    private var images: [ImageStruct] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
            olPhotoCollection.isHidden = true
            olBlockAdv.isHidden = true
            olBlockNote.isHidden = true
            olBlockCost1.isHidden = true
            olBlockCost2.isHidden = true
            olBlockCost3.isHidden = true
            olBlockContact.isHidden = true
            olName.isHidden = true
        
        let id = priceItem.id

        Tovar().fetchData(with: id) { (obj) in
            self.tovar = obj

            if self.tovar.id > 0 {
                DispatchQueue.main.async {
                    self.setVars()
                }
            }
            
            if obj.images.count > 0 {
                for img in obj.images {
                    let url = img.urlMd
                    NetworkManager.shared.getImage(from: url, comletion: { (imgIn) in
                        DispatchQueue.main.async {
                            let imageStruct = ImageStruct(url: img.url, image: self.resizeImage(image: imgIn))
                            self.images.append(imageStruct)
                            self.olPhotoCollection.reloadData()
                        }
                    })
                }
                

            }
            
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if (tovar.error != nil) {
            let alert = UIAlertController(title: "Ошибка", message: tovar.error, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (UIAlertAction) in
                
            }))
            
            self.present(alert, animated: true)
        }
    }
    
    @objc func tapPhone(sender:UITapGestureRecognizer) {
        print(tovar.mobile)
           let url = URL(string: "tel://\(tovar.mobile)")!
         if UIApplication.shared.canOpenURL(url) {
             UIApplication.shared.open(url)
         }
    }
    

    private func resizeImage(image: UIImage) -> UIImage {
      let size = image.size
        let scale = Double(size.width / size.height)
        let height = Double(heightImage)
        let width = height * scale
        
      let newSize = CGSize(width: width,  height: height)
      let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)

      UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
      image.draw(in: rect)
      let newImage = UIGraphicsGetImageFromCurrentImageContext()
      UIGraphicsEndImageContext()

      return newImage!
    }
    
    private func returnUnit(txt: String) -> String {
        var str = "шт."
        if (txt == "kg") { str = "кг." }
        return "р./\(str)"
    }
    
    private func setVars() {
        
        var cost = ""
        
//        tovar.note = "тут какой-то текст тут какой-то текст тут какой-то текст тут какой-то текст тут какой-то текст тут какой-то текст тут какой-то текст тут какой-то текст "
//
//        tovar.cost1 = 1234.5
//        tovar.cost2 = 134.5
//        tovar.cost3 = 80
//        tovar.cost1Note = "тут какой-то текст тут какой-то текст тут какой-то текст тут какой-то текст "

        
        let formatter = NumberFormatter()
        formatter.numberStyle = NumberFormatter.Style.decimal
        formatter.groupingSeparator = " "
        
        olName.text = tovar.name
        olLibFishName.text = tovar.libFishName
        olLibTypeProductName.text = tovar.libTypeProductName
        olCityName.text = tovar.cityName
        olProducer.text = tovar.producer
        olDtTovar.text = tovar.dtTovar
        olSize.text = tovar.size
        olPackWeight.text = tovar.packWeight
        olNote.text = tovar.note
        olCost1Note.text = tovar.cost1Note
        olCost1Unit.text = returnUnit(txt: tovar.cost1Unit)
        cost = String(formatter.string(from: NSNumber(value: tovar.cost1)) ?? "")
        olCost1.text = "\(cost)"
        olCost2Note.text = tovar.cost2Note
        olCost2Unit.text = returnUnit(txt: tovar.cost2Unit)
        cost = String(formatter.string(from: NSNumber(value: tovar.cost2)) ?? "")
        olCost2.text = "\(cost)"
        olCost3Note.text = tovar.cost3Note
        olCost3Unit.text = returnUnit(txt: tovar.cost3Unit)
        cost = String(formatter.string(from: NSNumber(value: tovar.cost3)) ?? "")
        olCost3.text = "\(cost)"
        olFirmName.text = tovar.firmName
        olFirmPhone.text = tovar.firmPhone
        
        olName.isHidden = false
        olBlockAdv.isHidden = false
        if tovar.images.count > 0 { olPhotoCollection.isHidden = false }
        if tovar.note != "" { olBlockNote.isHidden = false }
        if tovar.cost1 > 0 { olBlockCost1.isHidden = false }
        if tovar.cost2 > 0 { olBlockCost2.isHidden = false }
        if tovar.cost3 > 0 { olBlockCost3.isHidden = false }

        olBlockContact.isHidden = false
        
        if (tovar.mobile != "") {
            let tap = UITapGestureRecognizer(target: self, action: #selector(TovarViewController.tapPhone))
            olFirmPhone.addGestureRecognizer(tap)
            
            olBlockPhone.backgroundColor = UtilsSettings.shared.colorBgTint
            olFirmPhone.textColor = UtilsSettings.shared.colorWhite
            olFirmPhoneTitle.textColor = UtilsSettings.shared.colorWhite

        }
        
        olBlockNote.layoutIfNeeded()
        olMainStackView.layoutIfNeeded()
        
        olPhotoCollection.reloadData()

    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = olPhotoCollection.dequeueReusableCell(withReuseIdentifier: "cellPhoto", for: indexPath) as! PhotoCollectionViewCell

        cell.olPhoto.image = images[indexPath.row].image
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let image = images[indexPath.row].image
        
        let heightCell:CGFloat = 128.0
        
        let widthImage = image.size.width
        let heightImage = image.size.height
        
        let scaleHeight = widthImage / heightImage
        
        let widthCell = heightCell * scaleHeight
        
        return CGSize(width: widthCell, height: 128)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goPhotoController", sender: images[indexPath.row])
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goPhotoController" {
            let photoVC = segue.destination as! PhotoViewController
            photoVC.imageObj = sender as? ImageStruct
        }
    }

}
