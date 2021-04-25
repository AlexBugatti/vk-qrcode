//
//  MainViewController.swift
//  vkqrcode
//
//  Created by Александр on 25.04.2021.
//

import UIKit

class MainViewController: UIViewController {

    var imagePicker: ImagePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.imagePicker = ImagePicker(presentationController: self, delegate: self)

        // Do any additional setup after loading the view.
    }
    
    func openEditor(image: UIImage) {
        if let features = detectQRCode(image), !features.isEmpty {
            for case let row as CIQRCodeFeature in features{
                if let message = row.messageString {
                    self.openQR(code: message)
                }
            }
        }
//        let vc = EditorViewController.init(image: image)
//        self.navigationController?.pushViewController(vc, animated: false)
    }
    

    @IBAction func onDidActionTapped(_ sender: UIButton) {
        let scanVC = ScannerViewController.init()
        scanVC.didFoundCode = { code in
            self.openQR(code: code)
        }
        self.present(scanVC, animated: true, completion: nil)
    }
    
    @IBAction func onDidGaleryTapped(_ sender: UIButton) {
        self.imagePicker.present(from: sender)
    }
    
    func detectQRCode(_ image: UIImage?) -> [CIFeature]? {
        if let image = image, let ciImage = CIImage.init(image: image){
            var options: [String: Any]
            let context = CIContext()
            options = [CIDetectorAccuracy: CIDetectorAccuracyHigh]
            let qrDetector = CIDetector(ofType: CIDetectorTypeQRCode, context: context, options: options)
            if ciImage.properties.keys.contains((kCGImagePropertyOrientation as String)){
                options = [CIDetectorImageOrientation: ciImage.properties[(kCGImagePropertyOrientation as String)] ?? 1]
            } else {
                options = [CIDetectorImageOrientation: 1]
            }
            let features = qrDetector?.features(in: ciImage, options: options)
            return features

        }
        return nil
    }
    
    func openQR(code: String) {
        let qrVC = QRViewController(code: code)
        self.navigationController?.pushViewController(qrVC, animated: true)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    
}

extension MainViewController: ImagePickerDelegate {
    
    func didSelect(image: UIImage?) {
        if let image = image {
            self.openEditor(image: image)
        }
    }
    
}
