//
//  CategoryRow.swift
//  capstone1
//
//  Created by 하승익 on 03/06/2019.
//  Copyright © 2019 하승익. All rights reserved.
//

import Foundation
import UIKit

class CategoryRow : UITableViewCell {

    var data: [Double] = priceGlobal
    var temp : String?
    var data2: [Double] = []
    
    @IBOutlet weak var collectionView: UICollectionView!
    var date: tableData? = nil{
        didSet{
            collectionView.reloadData()
        }
    }
    
    init(value : [Double]){
        data = value
        super.init(style: .default, reuseIdentifier: temp)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "videoCell", for: indexPath)
        
        let title = UILabel(frame: CGRect(x: 0, y: 0, width: cell.bounds.size.width, height: 40))
        title.textColor = UIColor.black
        title.text = "\(data[indexPath.row])"
        title.textAlignment = .center
        cell.contentView.addSubview(title)
        
        return cell
    }
    
}

extension CategoryRow : UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 12
    }
    
    
    
}

extension CategoryRow : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemsPerRow:CGFloat = 4
        let hardCodedPadding:CGFloat = 5
        let itemWidth = (collectionView.bounds.width / itemsPerRow) - hardCodedPadding
        let itemHeight = collectionView.bounds.height - (2 * hardCodedPadding)
        return CGSize(width: itemWidth, height: itemHeight)
    }
    
}
