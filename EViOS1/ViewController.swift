//
//  ViewController.swift
//  EViOS1
//
//  Created by Student07 on 30/06/2023.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var ImgAvatar: UIImageView!
    @IBOutlet weak var ImgVisibility: UIImageView!
    @IBOutlet weak var InputLogin: UITextField!
    @IBOutlet weak var Inputpassword: UITextField!
    @IBOutlet weak var LabelForm: UILabel!
    @IBOutlet weak var LabelNewsLetter: UILabel!
    @IBOutlet weak var SwitchNewsLetter: UISwitch!
    @IBOutlet weak var BtnLogin: UIButton!
    var Loader = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //background scene
        setBgImg(img: UIImage(named: "background_image")!, view: view)
        
        //Image avatar
        setImgAvatar(
            img: UIImage(named: "user_icon")!,
            bg: UIColor(named: "DarkGreen")!,
            view: ImgAvatar
        )
        
        //Form apparance and content
        setImgVisibility(img: UIImage(named: "eye_off_icon")!, view: ImgVisibility)
        setContentInputsAndLabels()
        addToggleVisibility()
        
        //Button
        configureSwitch(btn: SwitchNewsLetter, isOn: false, color: UIColor(named: "DarkGreen")!)
        configureBtn(btn: BtnLogin, title: "Login", tint: UIColor(named: "DarkGreen")!)
        
        //Loading view
        setLoader(loader: Loader, view: view)
        
        //hide keyboard
        hideKeyboardOnTap(view: view)
    }
    
    func setLoader(loader: UIActivityIndicatorView, view: UIView){
        loader.frame = view.bounds
        loader.backgroundColor = UIColor(named: "Opacity5")
        loader.style = .large
        loader.isHidden = true
        view.addSubview(loader)
        view.bringSubviewToFront(loader)
    }
    
    func toggleLoader(loader: UIActivityIndicatorView){
        loader.isHidden = !loader.isHidden
        if(loader.isHidden){
            loader.stopAnimating()
        }else{
            loader.startAnimating()
        }
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
    
    func setImgVisibility(img: UIImage, view: UIImageView){
        view.image = img
        view.contentMode = .scaleAspectFit
    }
    
    func setContentInputsAndLabels(){
        LabelForm.text = "Bienvenue"
        LabelForm.font = .boldSystemFont(ofSize: 24)
        InputLogin.placeholder = "Login"
        InputLogin.textContentType = .emailAddress
        InputLogin.keyboardType = .emailAddress
        Inputpassword.placeholder = "Password"
        Inputpassword.textContentType = .password
        Inputpassword.isSecureTextEntry = true
        LabelNewsLetter.text = "Inscription à la newsletter:"
        LabelNewsLetter.font = .boldSystemFont(ofSize: 12)
    }
    
    func hideKeyboardOnTap(view:UIView){
        let tapOnView = UITapGestureRecognizer(
            target: view,
            action: #selector(UIView.endEditing)
        )
        view.addGestureRecognizer(tapOnView)
    }
    
    @objc func toggleVisibility(sender: UITapGestureRecognizer) {
        var img: String{
            if(Inputpassword.isSecureTextEntry){
                return "eye_on_icon"
            }else{
                return "eye_off_icon"
            }
        }
        setImgVisibility(img: UIImage(named: img)!, view: ImgVisibility)
        Inputpassword.isSecureTextEntry = !Inputpassword.isSecureTextEntry
    }
    
    func addToggleVisibility(){
        let tapOnView = UITapGestureRecognizer(
            target: self,
            action: #selector(toggleVisibility(sender:))
        )
        ImgVisibility.isUserInteractionEnabled = true
        ImgVisibility.addGestureRecognizer(tapOnView)
    }
    
    func configureBtn(btn: UIButton, title: String, tint: UIColor){
        btn.setTitle(title, for: .normal)
        btn.tintColor = tint
    }
    
    func configureSwitch(btn: UISwitch, isOn: Bool, color: UIColor){
        btn.isOn = isOn
        btn.onTintColor = color
    }
    
    func stopEdit(view: UIView){
        view.endEditing(true)
    }
    
    func alertDial(title: String, message: String, cancel: String, ok: String, vc: UIViewController){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: cancel, style: .cancel, handler: { action in
            print("TOUCH Cancel")
        }))
        alert.addAction(UIAlertAction(title: ok, style: .default, handler: { action in
            print("TOUCH OK")
        }))
        
        vc.present(alert, animated: true, completion: nil)
    }
    
    func logging(completion: @escaping () -> Void){
        DispatchQueue.global(qos: .default).async {
            sleep(3)
            completion()
        }
    }
    
    @IBAction func actionBtnLogin(_ sender: UIButton) {
        stopEdit(view: view)
        var success = false
        var title = "ERROR"
        var message = ""
        
        if let login = InputLogin.text{
            if (login != ""){
                if(login.contains("@")){
                    if let password = Inputpassword.text{
                        if (password != ""){
                            if (password.count >= 4){
                                success = true
                                title = "Bienvenue \(login)"
                                if (SwitchNewsLetter.isOn){
                                    message = "Vous vous êtes inscrit à la newsletter."
                                }else{
                                    message = "Vous ne vous êtes pas inscrit à la newsletter."
                                }
                            }else{
                                message = "Le mot de passe doit contenir au moins 4 lettres."
                            }
                        }else{
                           message = "Le champ mot de passe n'a pas été rempli."
                        }
                    }
                }else{
                    message = "Votre login ne contient pas de @."
                }
            }else{
                message = "Le champ login n'est pas rempli."
            }
        }
        
        if (success){
            toggleLoader(loader: Loader)
            logging{
                DispatchQueue.main.async {
                    self.toggleLoader(loader: self.Loader)
                    self.alertDial(
                        title: title,
                        message: message,
                        cancel: "Cancel",
                        ok: "OK",
                        vc: self
                    )
                }
            }
        }else{
            alertDial(
                title: title,
                message: message,
                cancel: "Cancel",
                ok: "OK",
                vc: self
            )
        }
    }
    
}

