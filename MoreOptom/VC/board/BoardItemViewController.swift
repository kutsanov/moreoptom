//
//  BoardItemViewController.swift
//  MoreOptom
//
//  Created by Vova Kutsanov on 14.04.2020.
//  Copyright © 2020 Vova Kutsanov. All rights reserved.
//

import UIKit

struct BoardImageStruct {
    let url: String
    let image: UIImage
}


class BoardItemViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    @IBOutlet var olTitle: UILabel!
    @IBOutlet var olImages: UICollectionView!
    @IBOutlet var olTxt: UILabel!
    @IBOutlet var olFirmName: UILabel!
    
    @IBOutlet var olFirmPhone: UILabel!
    @IBOutlet var olFirmPhoneTitle: UILabel!
    @IBOutlet var olBlockPhone: UIView!
    
    @IBOutlet var olScrollView: UIScrollView!
    
    var itemIn: BoardProviderItem! = nil
    var tovar = BoardItem()
    var images: [BoardImageStruct] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        olImages.isHidden = true
        olScrollView.isHidden = true

        let id = itemIn.id

        BoardItem().fetchData(with: id) { (obj) in
            self.tovar = obj

            if self.tovar.id > 0 {
                DispatchQueue.main.async {
                    self.setVars()
                    self.olScrollView.isHidden = false
                }
                
                if obj.photos.count > 0 {
                    for img in obj.photos {
                        NetworkManager.shared.getImage(from: img.url, comletion: { (imgIn) in
                            DispatchQueue.main.async {
                                let imageStruct = BoardImageStruct(url: img.urlSrc, image: Utils.shared.resizeImage(height: 128, image: imgIn))
                                self.images.append(imageStruct)
                                self.setVars()
                            }
                        })
                    }
                }
            }
            
        }
    }
    
    @objc func tapPhone(sender:UITapGestureRecognizer) {
        print(tovar.mobile)
           let url = URL(string: "tel://\(tovar.mobile)")!
         if UIApplication.shared.canOpenURL(url) {
             UIApplication.shared.open(url)
         }
    }
    
    private func setVars() {
        olTitle.text = tovar.title
        olTxt.text = tovar.txt
        olFirmName.text = tovar.firmNameShort
        olFirmPhone.text = tovar.phone
        if images.count > 0 {
            olImages.isHidden = false
            olImages.reloadData()
        }
        
        if (tovar.mobile != "") {
            let tap = UITapGestureRecognizer(target: self, action: #selector(BoardItemViewController.tapPhone))
            olFirmPhone.addGestureRecognizer(tap)
            
            olBlockPhone.backgroundColor = UtilsSettings.shared.colorBgTint
            olFirmPhone.textColor = UtilsSettings.shared.colorWhite
            olFirmPhoneTitle.textColor = UtilsSettings.shared.colorWhite

        }
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = olImages.dequeueReusableCell(withReuseIdentifier: "cellPhoto", for: indexPath) as! BoardPhotoCollectionViewCell
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
            let photoVC = segue.destination as! BoardPhotoViewController
            photoVC.imageObj = sender as? BoardImageStruct
        }
    }

}
