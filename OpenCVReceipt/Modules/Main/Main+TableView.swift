//
//  Main+TableView.swift
//  OpenCVReceipt
//
//  Created by Mohamed Elbana on 3/24/20.
//  Copyright © 2020 Mohamed Elbana. All rights reserved.
//

import UIKit

extension MainController: UITableViewDelegate, UITableViewDataSource {
    
    func reloadData() {
        count += 1
        if images.count > 1 {
            let imgOutput: UIImage = cvmanager?.stitch(withOpenCV: images) ?? UIImage()
            images = []
            images.append(imgOutput)
        }
        tableView.reloadData()
    }
    
    func setupTableView() {
        tableView.initialize(cellClass: PhotoCell.self, delegate: self, dataSource: self)
        tableView.registerCellNib(cellClass: FooterCell.self)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return images.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(cellClass: PhotoCell.self)
        cell.setupCell(images[indexPath.row], count)
        return cell
    }
}

