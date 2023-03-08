//
//  BaseViewController.swift
//
//

import UIKit
import PKHUD
class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }
    
    func setCustomBackImg() {
        let backBTN = UIBarButtonItem(image: UIImage(named: "Back"),
                                      style: .plain,
                                      target: navigationController,
                                      action: #selector(UINavigationController.popViewController(animated:)))
        navigationItem.leftBarButtonItem = backBTN

    }
    func showGenericAlert(message:String, title:String = "", handler: ((UIAlertAction) -> Void)? = nil){
        DispatchQueue.main.async {
            HUD.hide()
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = .center
            let messageText = NSMutableAttributedString(
                string: message,
                attributes: [
                    NSAttributedString.Key.paragraphStyle: paragraphStyle,
                    NSAttributedString.Key.font : UIFont.systemFont(ofSize: 13)
                ]
            )
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.setValue(messageText, forKey: "attributedMessage")
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: handler))
            self.present(alert, animated:true)
        }
    }
    
    func getButton(title: String) -> UIButton{
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.contentHorizontalAlignment = .center
        btn.setTitle(title, for: .normal)
       
        return btn
    }
    func getUILabel(strText: String?, font: UIFont, alignment: NSTextAlignment, myMutableString: NSMutableAttributedString?, fixedFontSize: Bool) -> UILabel{
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = font
        lbl.textAlignment = alignment
        lbl.adjustsFontSizeToFitWidth = fixedFontSize
        lbl.numberOfLines = 0
        if myMutableString != nil {
            lbl.attributedText = myMutableString!
        }
        if strText != nil {
            lbl.text = strText
        }
       

        return lbl
    }
    func getIImageView(imgUrl: String) -> UIImageView{
        let img = UIImageView.init(image:  UIImage(named: "default.png"))

        ImageDownloader.shared.downloadImage(with: imgUrl, completionHandler: { (image, cached) in
            img.image = image
        }, placeholderImage: UIImage(named: "default.png"))
        
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }
   
}
