//
//  ImageDetailViewController.swift
//  StoreLab
//
//  Created by tzh on 08/03/2023.
//

import UIKit

class ImageDetailViewController: BaseViewController {

    private var picture: Picture
    init(picture: Picture) {
        self.picture = picture
        super.init(nibName: nil, bundle: nil)

    }
    let btnFav:UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Detial"
        self.view.backgroundColor = .white
        self.setUpUI()
        // Do any additional setup after loading the view.
    }
    
    private func setUpUI() {
        let img = self.getIImageView(imgUrl: picture.downloadURL ?? "")
        self.view.addSubview(img)
        NSLayoutConstraint.activate([
            img.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 90),
            img.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            img.heightAnchor.constraint(equalToConstant: 300),
            img.widthAnchor.constraint(equalToConstant: 300)
        ])
        let lblName = self.getUILabel(strText: "Author: \(picture.author ?? "")", font: UIFont.systemFont(ofSize: 15), alignment: .center, myMutableString: nil, fixedFontSize: true)
        self.view.addSubview(lblName)
        NSLayoutConstraint.activate([
            lblName.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            lblName.heightAnchor.constraint(equalToConstant: 25),
            lblName.topAnchor.constraint(equalTo: img.bottomAnchor, constant: 20),
            lblName.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 20)


        ])
       
        self.view.addSubview(self.btnFav)
        let image = self.picture.isFav ? UIImage(named: "heartfill.png") : UIImage(named: "heart.png")
        self.btnFav.setImage(image, for: .normal)

        NSLayoutConstraint.activate([
            btnFav.leadingAnchor.constraint(equalTo: lblName.leadingAnchor, constant: 0),
            btnFav.heightAnchor.constraint(equalToConstant: 30),
            btnFav.widthAnchor.constraint(equalToConstant: 30),
            btnFav.topAnchor.constraint(equalTo: lblName.bottomAnchor, constant: 20)

        ])
    }
   
  
}
