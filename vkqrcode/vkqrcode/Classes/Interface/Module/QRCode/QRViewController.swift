//
//  QRViewController.swift
//  vkqrcode
//
//  Created by Александр on 25.04.2021.
//

import UIKit

class QRViewController: UIViewController {

    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var actionButton: UIButton!
    
    var code: String
    
    init(code: String) {
        self.code = code
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        textView.text = code
        setup()
        // Do any additional setup after loading the view.
    }
    
    func setup() {
        if let url = URL.init(string: code), UIApplication.shared.canOpenURL(url) {
            self.navigationItem.title = "Сайт"
            self.actionButton.setTitle("Открыть сайт", for: .normal)
            return
        }
        
        if let phone = detector(string: code), let url = URL(string: "tel://\(phone)"), UIApplication.shared.canOpenURL(url) {
            self.navigationItem.title = "Телефон"
            self.actionButton.setTitle("Набрать номер", for: .normal)
            return
        }
        
        self.navigationItem.title = "Текст. Содержимое не распознано"
    }
    
    func detector(string: String) -> String? {

        do {
           let detector = try NSDataDetector(types: NSTextCheckingResult.CheckingType.phoneNumber.rawValue)
           let numberOfMatches = detector.numberOfMatches(in: string, range: NSRange(string.startIndex..., in: string))
           let matches = detector.matches(in: string, range: NSRange(string.startIndex..., in: string))

            for match in matches {
                if match.resultType == .phoneNumber, let number = match.phoneNumber {
                    return number
                }
            }
           print(numberOfMatches) // 3
        } catch {
           print(error)
        }
        
        return nil
    }
    
    @IBAction func onDidActionTapped(_ sender: Any) {
        if let url = URL.init(string: code), UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
            return
        }
        
        if let phone = detector(string: code), let url = URL(string: "tel://\(phone)"), UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
            return
        }
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
