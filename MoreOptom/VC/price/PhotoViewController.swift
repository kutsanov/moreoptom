//
//  PhotoViewController.swift
//  MoreOptom
//
//  Created by Vova Kutsanov on 11.04.2020.
//  Copyright © 2020 Vova Kutsanov. All rights reserved.
//

import UIKit

class PhotoViewController: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet var olPhoto: UIImageView!
    @IBOutlet var olScrollView: UIScrollView!
    
    var imageObj: ImageStruct!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        olScrollView.minimumZoomScale = 0.1
        olScrollView.maximumZoomScale = 5
        
        
        NetworkManager.shared.getImage(from: imageObj.url, comletion: { (imgIn) in
            DispatchQueue.main.async {
                self.olPhoto.bounds.size = imgIn.size
                self.olPhoto.image = imgIn
                
                self.setupSize()
            }
        })
    }
    
    func setupSize() {
        let boundsSize = olScrollView.bounds.size
        let imageSize = olPhoto.bounds.size
        
        if imageSize.width > imageSize.height {
            olScrollView.zoomScale = boundsSize.height / imageSize.height
            olScrollView.minimumZoomScale = boundsSize.width / imageSize.width
        } else {
            olScrollView.zoomScale = boundsSize.width / imageSize.width
            olScrollView.minimumZoomScale = boundsSize.height / imageSize.height
        }
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.olPhoto
    }
}
