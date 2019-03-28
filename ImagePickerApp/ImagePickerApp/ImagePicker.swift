//
//  ImagePicker.swift
//  ImagePickerApp
//
//  Created by Mochamad Fariz Al Hazmi on 28/03/19.
//  Copyright © 2019 Mochamad Fariz Al Hazmi. All rights reserved.
//

import UIKit

public protocol ImagePickerDelegate: class {
    func didSelect(image: UIImage?)
    func didCancel()
}

open class ImagePicker: NSObject {
    
    private let imagePickerController: UIImagePickerController
    private weak var presentationController: UIViewController?
    private weak var delegate: ImagePickerDelegate?
    
    public init(presentationController: UIViewController, delegate: ImagePickerDelegate) {
        self.imagePickerController = UIImagePickerController()
        super.init()
        self.presentationController = presentationController
        self.delegate = delegate
        self.imagePickerController.delegate = self
        self.imagePickerController.allowsEditing = true
        self.imagePickerController.mediaTypes = ["public.image"]
    }
    
    private func action(for type: UIImagePickerController.SourceType, title: String) -> UIAlertAction? {
        guard UIImagePickerController.isSourceTypeAvailable(type) else {
            return nil
        }
        return UIAlertAction(title: title, style: .default) { [unowned self] _ in
            self.imagePickerController.sourceType = type
            self.presentationController?.present(self.imagePickerController, animated: true, completion: nil)
        }
    }
    
    public func present(from sourceView: UIView) {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        if let action = self.action(for: .camera, title: "Take Photo") {
            alertController.addAction(action)
        }
        if let action = self.action(for: .savedPhotosAlbum, title: "Camera Roll") {
            alertController.addAction(action)
        }
        if let action = self.action(for: .photoLibrary, title: "Photo Library") {
            alertController.addAction(action)
        }
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (alertAction) in
            self.delegate?.didCancel()
        }))
        if UIDevice.current.userInterfaceIdiom == .pad {
            alertController.popoverPresentationController?.sourceView = sourceView
            alertController.popoverPresentationController?.sourceRect = sourceView.bounds
            alertController.popoverPresentationController?.permittedArrowDirections = [.down, .up]
        }
        self.presentationController?.present(alertController, animated: true, completion: nil)
    }
    
    private func imagePickerController(_ controller: UIImagePickerController, didSelect image: UIImage?) {
        controller.dismiss(animated: true, completion: nil)
        self.delegate?.didSelect(image: image)
    }
    
    private func imagePickerController(_ controller: UIImagePickerController) {
        controller.dismiss(animated: true, completion: nil)
        self.delegate?.didCancel()
    }
    
}

extension ImagePicker: UIImagePickerControllerDelegate {
    
    public func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.imagePickerController(picker)
    }
    
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else {
            return self.imagePickerController(picker, didSelect: nil)
        }
        self.imagePickerController(picker, didSelect: image)
    }
    
}

extension ImagePicker: UINavigationControllerDelegate {
    
}
