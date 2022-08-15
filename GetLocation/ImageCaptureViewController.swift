//
//  ImageCaptureViewController.swift
//  GetLocation
//
//  Created by Tim 20/05/2019.
//

import UIKit

class ImageCaptureViewController: UIViewController, UINavigationControllerDelegate,  UIImagePickerControllerDelegate {

@IBOutlet weak var takeImage: UIImageView!
var imagePicker: UIImagePickerController!

@IBAction func takePhoto(_ sender: UIButton) {
    imagePicker = UIImagePickerController()
    imagePicker.delegate = self
    imagePicker.sourceType = .camera
    present(imagePicker, animated: true, completion: nil)
}

@IBAction func savePhoto(_ sender: UIButton) {
    UIImageWriteToSavedPhotosAlbum(takeImage.image!, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
}

@objc func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
    if let error = error {
        let ac = UIAlertController(title: "Save error", message: error.localizedDescription, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    } else {
        let ac = UIAlertController(title: "Saved!", message: "Your altered image has been saved to your photos.", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }
}

func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
    imagePicker.dismiss(animated: true, completion: nil)
    takeImage.image = info[UIImagePickerController.InfoKey.originalImage.rawValue] as? UIImage
}
}
