//
//  ViewController.swift
//  StoreLab
//
//  Created by tzh on 08/03/2023.
//

import UIKit
import PKHUD
import RxSwift
enum TableSection: Int {
    case pictureList
    case loader
}

class PictureListViewController: UITableViewController {
    private var picturesVM = PictureListVM()
    private let pageLimit = 10
    private var page = 1
    private var pictures = [Picture]() {
        didSet {
            DispatchQueue.main.async { [weak self] in
                HUD.hide()
                self?.tableView.reloadData()
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadPictures()
        self.tableView.register(PictureTableViewCell.self, forCellReuseIdentifier: "PictureTableViewCell")

        // Do any additional setup after loading the view.
    }

    private func loadPictures(completed: ((Bool) -> Void)? = nil){
        
        HUD.show(.progress)
        self.picturesVM.getPictures(page: page,limit: pageLimit)
            .observeOn(MainScheduler.instance)
            .subscribe { [weak self] event in
                guard let pictures =  self?.picturesVM.pictures else  {
                    completed?(false)
                    return
                }
                if pictures.count == 0 {
                    completed?(false)
                }
                self?.pictures.append(contentsOf: pictures)
                completed?(true)

              
            }
            
        
    }
}

extension PictureListViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let listSection = TableSection(rawValue: section) else { return 0 }
        switch listSection {
        case .pictureList:
            return self.pictures.count
        case .loader:
            return self.pictures.count >= pageLimit ? 1 : 0
        }

    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let section = TableSection(rawValue: indexPath.section) else { return UITableViewCell() }
        switch section {
        case .pictureList:
            var cell:PictureTableViewCell? = tableView.dequeueReusableCell(withIdentifier: "PictureTableViewCell", for: indexPath) as? PictureTableViewCell

            if cell == nil {
                cell = PictureTableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "PictureTableViewCell")
            }
            let picture = self.pictures[indexPath.row]
            cell?.setDataUI(picture)
            cell?.buttonPressedWithRefData = { picture in
                let nextController = ImageDetailViewController(picture: picture)
                self.navigationController?.pushViewController(nextController, animated: true)
            }
            return cell!
        case .loader:
            let cell = UITableViewCell(style: .value1, reuseIdentifier: "Cell")
            cell.textLabel?.text = "Loading.."
            cell.textLabel?.textColor = .systemBlue
            return cell

        }
       
    }
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let section = TableSection(rawValue: indexPath.section) else { return }
        guard !pictures.isEmpty else { return }
        
        if section == .loader {
            print("load new data..")
            loadPictures { [weak self] success in
                if !success {
                    self?.page = self?.page ?? 0 + 1
                    self?.hideBottomLoader()
                }
            }
        }
    }
    private func hideBottomLoader() {
        DispatchQueue.main.async {
            let lastListIndexPath = IndexPath(row: self.pictures.count - 1, section: TableSection.pictureList.rawValue)
            self.tableView.scrollToRow(at: lastListIndexPath, at: .bottom, animated: true)
        }
    }
 
}
