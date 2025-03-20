//////
//////  QRCodeViewController.swift
//////  QRCodeTouchPadTask
//////
//////  Created by Kailash Rajput on 20/03/25.
//////
////
//
//
//import UIKit
//import CoreImage
//
//class QRCodeViewController: UIViewController {
//    private let imagePicker = UIImagePickerController()
//    private let scanButton = UIButton(type: .system)
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        setupUI()
//        setupImagePicker()
//    }
//    
//    private func setupUI() {
//        view.backgroundColor = .white
//        
//        // Configure scan button
//        scanButton.setTitle("Scan from Gallery", for: .normal)
//        scanButton.addTarget(self, action: #selector(openGallery), for: .touchUpInside)
//        scanButton.translatesAutoresizingMaskIntoConstraints = false
//        
//        view.addSubview(scanButton)
//        
//        NSLayoutConstraint.activate([
//            scanButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            scanButton.centerYAnchor.constraint(equalTo: view.centerYAnchor)
//        ])
//    }
//    
//    @objc private func openGallery() {
//        present(imagePicker, animated: true)
//    }
//    
//    private func setupImagePicker() {
//        imagePicker.delegate = self
//        imagePicker.sourceType = .photoLibrary
//        imagePicker.allowsEditing = false
//    }
//}
//
//extension QRCodeViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
//    func imagePickerController(
//        _ picker: UIImagePickerController,
//        didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]
//    ) {
//        picker.dismiss(animated: true)
//        
//        guard let selectedImage = info[.originalImage] as? UIImage else {
//            print("Failed to get the selected image")
//            return
//        }
//        
//        processQRCode(from: selectedImage)
//    }
//    
//    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
//        picker.dismiss(animated: true)
//    }
//    
//    // MARK: - QR Code Detection
//    private func processQRCode(from image: UIImage) {
//        guard let ciImage = CIImage(image: image) else {
//            print("Failed to convert UIImage to CIImage")
//            return
//        }
//        
//        let options = [CIDetectorAccuracy: CIDetectorAccuracyHigh]
//        guard let qrDetector = CIDetector(
//            ofType: CIDetectorTypeQRCode,
//            context: nil,
//            options: options
//        ) else {
//            print("Failed to create QR Code detector")
//            return
//        }
//        
//        let features = qrDetector.features(in: ciImage)
//        
//        guard !features.isEmpty else {
//            print("No QR codes found")
//            return
//        }
//        
//        for case let feature as CIQRCodeFeature in features {
//            if let metadata = feature.messageString {
//                print("QR Code Metadata: \(metadata)")
//            }
//        }
//    }
//}
//
////import UIKit
////import Vision
////
////class QRCodeViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
////
////    override func viewDidLoad() {
////        super.viewDidLoad()
////        view.backgroundColor = .white
////
////        // Button to Pick Image
////        let button = UIButton(type: .system)
////        button.setTitle("Pick Image", for: .normal)
////        button.addTarget(self, action: #selector(pickImage), for: .touchUpInside)
////        button.frame = CGRect(x: 50, y: 200, width: 200, height: 50)
////        view.addSubview(button)
////    }
////
////    @objc func pickImage() {
////        let imagePicker = UIImagePickerController()
////        imagePicker.sourceType = .photoLibrary
////        imagePicker.delegate = self
////        present(imagePicker, animated: true)
////    }
////
////    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
////        picker.dismiss(animated: true)
////
////        if let image = info[.originalImage] as? UIImage {
////            if let resizedImage = resizeImage(image, targetSize: CGSize(width: 1024, height: 1024)) {
////                detectQRCode(in: resizedImage)
////            }
////        }
////    }
////
////    func resizeImage(_ image: UIImage, targetSize: CGSize) -> UIImage? {
////        let format = UIGraphicsImageRendererFormat()
////        format.scale = 1  // Keep a standard scale
////        let renderer = UIGraphicsImageRenderer(size: targetSize, format: format)
////
////        return renderer.image { _ in
////            image.draw(in: CGRect(origin: .zero, size: targetSize))
////        }
////    }
////
////    func detectQRCode(in image: UIImage) {
////        guard let ciImage = CIImage(image: image) else {
////            print("❌ Failed to create CIImage")
////            return
////        }
////
////        let context = CIContext()
////        guard let cgImage = context.createCGImage(ciImage, from: ciImage.extent) else {
////            print("❌ Failed to create CGImage from CIImage")
////            return
////        }
////
////        let request = VNDetectBarcodesRequest { request, error in
////            DispatchQueue.main.async {
////                if let error = error {
////                    print("❌ Error detecting barcode: \(error.localizedDescription)")
////                    return
////                }
////
////                guard let results = request.results as? [VNBarcodeObservation], !results.isEmpty else {
////                    print("⚠️ No QR code found")
////                    return
////                }
////
////                for barcode in results {
////                    if let payload = barcode.payloadStringValue {
////                        print("✅ QR Code Data: \(payload)")
////                    }
////                }
////            }
////        }
////
////        let handler = VNImageRequestHandler(cgImage: cgImage, options: [:])
////
////        DispatchQueue.global(qos: .userInitiated).async {
////            do {
////                try handler.perform([request])
////            } catch {
////                print("❌ Failed to perform QR code detection: \(error.localizedDescription)")
////            }
////        }
////    }
////}
