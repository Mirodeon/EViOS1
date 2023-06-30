//
//  ViewController.swift
//  EViOS1
//
//  Created by Student07 on 30/06/2023.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var ImgAvatar: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setBgImg(img: UIImage(named: "background_image")!, view: view)
        setImgAvatar(
            img: UIImage(named: "user_icon")!,
            bg: UIColor(named: "DarkGreen")!,
            view: ImgAvatar
        )
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
    
    func roundView(view:UIView){
        view.layer.cornerRadius = view.frame.size.height/2
    }
    
    func setImgAvatar(img: UIImage, bg: UIColor, view: UIImageView){
        view.image = img
        view.contentMode = .scaleAspectFit
        view.backgroundColor = bg
        roundView(view: view)
    }
}

