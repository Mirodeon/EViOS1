//
//  ViewController.swift
//  EViOS1
//
//  Created by Student07 on 30/06/2023.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setBgImg(img: UIImage(named: "background_image")!, view: view)
    }

    func setBgImg(img: UIImage, view: UIView){
        let imageView = UIImageView(frame: view.bounds)
        imageView.contentMode =  .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = img
        imageView.center = view.center
        view.addSubview(imageView)
        self.view.sendSubviewToBack(imageView)
    }
}

