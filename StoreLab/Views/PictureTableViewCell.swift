//
//  PictureTableViewCell.swift
//  StoreLab
//
//  Created by tzh on 08/03/2023.
//

import UIKit

class PictureTableViewCell: UITableViewCell {
    private var picture : Picture?
    var buttonPressedWithRefData : (_ refData:Picture)->() = { _ in }

    var lblAuthourName:UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    var imgProfile:UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "default.png")
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    let btnFav:UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.tintColor = UIColor.white

        return btn
    }()
    let  btnDetail:UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Detail", for: .normal)
        btn.backgroundColor = .black
        return btn
    }()
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
       super.init(style: style, reuseIdentifier: "PictureTableViewCell")
        self.setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

  
    
    func setUI() {
        contentView.addSubview(imgProfile)
        contentView.addSubview(lblAuthourName)
        contentView.addSubview(btnFav)
        self.contentView.addSubview(btnDetail)

        self.btnFav.addTarget(self, action: #selector(favClick), for: .touchUpInside)
       self.btnDetail.addTarget(self, action: #selector(onDetail), for: .touchUpInside)

        NSLayoutConstraint.activate([
            self.imgProfile.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            self.imgProfile.heightAnchor.constraint(equalToConstant: 100),
            self.imgProfile.widthAnchor.constraint(equalToConstant: 100),
            self.imgProfile.topAnchor.constraint(equalTo:contentView.bottomAnchor, constant: 10)
        ])
        NSLayoutConstraint.activate([
            self.lblAuthourName.leadingAnchor.constraint(equalTo: imgProfile.trailingAnchor, constant: 10),
            self.lblAuthourName.heightAnchor.constraint(equalToConstant: 25),
            self.lblAuthourName.trailingAnchor.constraint(equalTo:contentView.trailingAnchor, constant: 10),
            self.lblAuthourName.topAnchor.constraint(equalTo:contentView.topAnchor, constant: 20)
        ])
        
         NSLayoutConstraint.activate([
            self.btnFav.leadingAnchor.constraint(equalTo: imgProfile.trailingAnchor, constant: 10),
            self.btnFav.heightAnchor.constraint(equalToConstant: 50),
            self.btnFav.widthAnchor.constraint(equalToConstant: 50),
            self.btnFav.topAnchor.constraint(equalTo:lblAuthourName.bottomAnchor, constant: 20)
        ])
        
        NSLayoutConstraint.activate([
            self.btnDetail.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            self.btnDetail.heightAnchor.constraint(equalToConstant: 20),
            self.btnDetail.widthAnchor.constraint(equalToConstant: 100),
            self.btnDetail.topAnchor.constraint(equalTo:contentView.bottomAnchor, constant: -20)
        ])
       
    }
    @objc func favClick() {
        guard let picture = self.picture else {
            return
        }
        self.picture?.isFav = !picture.isFav
        let image = self.picture?.isFav ?? false ? UIImage(named: "heartfill.png") : UIImage(named: "heart.png")
        self.btnFav.setImage(image, for: .normal)

    }
    @objc func onDetail() {
        guard let picture = self.picture else {
            return
        }
            buttonPressedWithRefData(picture)
        

    }
    func setDataUI(_ picture: Picture) {
        self.picture = picture
        self.lblAuthourName.text = picture.author
        self.getProfileImg(url: picture.downloadURL)
        let image = picture.isFav ? UIImage(named: "heartfill.png") : UIImage(named: "heart.png")
        self.btnFav.setImage(image, for: .normal)
    }
    
    func getProfileImg(url: String?)  {
        if let imageUrl = url {
            ImageDownloader.shared.downloadImage(with: imageUrl, completionHandler: { (image, cached) in
                self.imgProfile.image = image
            }, placeholderImage: UIImage(named: "default.png"))
        }
    }

}
