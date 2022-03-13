//
//  DetailsViewController.swift
//  ShoppingList
//
//  Created by Abdullah Karagöz on 7.03.2022.
//

import UIKit
import CoreData

class DetailsViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var isimTextField: UITextField!
    @IBOutlet weak var fiyatTextField: UITextField!
    @IBOutlet weak var bedenTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(klavyeyiKapat))
        view.addGestureRecognizer(gestureRecognizer)
        
        imageView.isUserInteractionEnabled = true
        let imageGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(gorselSec))
        imageView.addGestureRecognizer(imageGestureRecognizer)
    
    }
    
    @objc func gorselSec(){
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        present(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        imageView.image = info[.originalImage] as? UIImage
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func klavyeyiKapat(){
        view.endEditing(true)
    }
    
    @IBAction func kaydetButtonTiklandi(_ sender: Any) {
     
        let appDelegate =  UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let alisveris = NSEntityDescription.insertNewObject(forEntityName: "Alisveris", into: context)
        
        alisveris.setValue(isimTextField.text!, forKey: "isim")
        alisveris.setValue(bedenTextField.text!, forKey: "beden")
    
        if let fiyat = (Int(fiyatTextField.text!)){
            alisveris.setValue(fiyat, forKey: "fiyat")
        }
        
        alisveris.setValue(UUID(), forKey: "id")
        
        let data = imageView.image!.jpegData(compressionQuality: 0.5)
        alisveris.setValue(data, forKey: "gorsel")
        
        
        do {
            try context.save()
            print("Kayıt Edildi")
        } catch {
                print("Kayıt edilirken hata oluştu !")
            }
        
        
    }
    
    
}
