//
//  ViewController.swift
//  ImagePickerApp
//
//  Created by Mochamad Fariz Al Hazmi on 28/03/19.
//  Copyright © 2019 Mochamad Fariz Al Hazmi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var ivPhotoProfile: UIImageView!
    @IBOutlet weak var btnPhotoProfile: UIButton!
    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var btnSave: UIButton!
    
    var imagePicker: ImagePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupImagePicker()
        setupLayout()
    }

    @IBAction func btnPhotoProfile(_ sender: Any) {
        openImagePicker(sender: sender as! UIView)
    }
    
    @IBAction func btnSaveOnTouch(_ sender: Any) {
        print("Saved!")
    }
    
    private func setupLayout() {
        
        // Photo profile default setup
        self.ivPhotoProfile.image = UIImage(named: "img_placeholder_circle")
        self.ivPhotoProfile.contentMode = .scaleAspectFit
        self.ivPhotoProfile.layer.cornerRadius = 50
        self.ivPhotoProfile.layer.masksToBounds = true
        
        self.lbName.text = "Eri"
        
        self.btnSave.layer.cornerRadius = 8
        self.btnSave.layer.masksToBounds = true
    }
    
    private func setupImagePicker() {
        self.imagePicker = ImagePicker(presentationController: self, delegate: self)
    }
    
    private func openImagePicker(sender: UIView) {
        self.imagePicker.present(from: sender)
    }
    
}

extension ViewController: ImagePickerDelegate {
    
    func didCancel() {
        print("didCancel")
    }
    
    func didSelect(image: UIImage?) {
        self.ivPhotoProfile.image = image
    }
    
}
