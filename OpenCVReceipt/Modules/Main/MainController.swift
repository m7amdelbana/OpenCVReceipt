//
//  MainController.swift
//  OpenCVReceipt
//
//  Created by Mohamed Elbana on 3/24/20.
//  Copyright © 2020 Mohamed Elbana. All rights reserved.
//

import UIKit
import AVFoundation
import Photos

class MainController: UIViewController {
    
    @IBOutlet weak var viewContainer: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var btnCamera: UIButton!
    
    let cvmanager = CVManager.shared()
    var count = 0
    
    let captureSession = AVCaptureSession()
    var previewLayer: CALayer!
    var captureDevice: AVCaptureDevice!
    var takePhoto = false
    
    var images: [UIImage] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupView()
    }
    
    func setupView() {
        btnCamera.layer.cornerRadius = btnCamera.frame.height / 2
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        prepareCamera()
    }
    
    @IBAction func takePhoto(_ sender: Any) {
        takePhoto = true
    }
    
    @IBAction func removeAction(_ sender: Any) {
        clear()
    }
    
    @IBAction func saveAction(_ sender: Any) {
        if !images.isEmpty {
            let status = PHPhotoLibrary.authorizationStatus()
            switch status {
            case .authorized:
                saveImage()
                break
            case .denied, .restricted:
                break
            case .notDetermined:
                requestPHPhotoLibrary()
            @unknown default:
                break
            }
        } else {
            self.showAlert("No Image!", "No image to save.")
        }
    }
    
    func requestPHPhotoLibrary() {
        PHPhotoLibrary.requestAuthorization { status in
            switch status {
            case .authorized:
                self.saveImage()
                break
            case .denied, .restricted:
                self.showAlert("Error!", "You cannot save the image")
                break
            case .notDetermined:
                break
            @unknown default:
                break
            }
        }
    }
    
    func saveImage() {
        let image = self.images.first ?? UIImage()
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
        clear()
    }
    
    func clear() {
        DispatchQueue.main.async {
            self.images = []
            self.count = 0
            self.tableView.reloadData()
        }
    }
    
    @objc func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            self.showAlert("Error!", error.localizedDescription)
            print(error.localizedDescription)
        } else {
            self.showAlert("Success!", "Your photo saved successfully.")
        }
    }
    
    func showAlert(_ title: String, _ message: String) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alert, animated: true)
        }
    }
}

