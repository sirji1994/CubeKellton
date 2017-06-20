//
//  GridLayout.swift
//  CubeKellton
//
//  Created by piyush.singh on 19/06/17.
//  Copyright © 2017 piyush.singh. All rights reserved.
//

import UIKit

class GridLayout: UICollectionViewFlowLayout {
    var columns: Int = 4
     var rows: Int = 4
    init(columns: Int, rows :Int) {
        super.init()
        self.minimumInteritemSpacing = 2
        self.minimumLineSpacing = 2
        self.columns = columns
        self.rows = rows
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override var itemSize: CGSize{
        set{
            super.itemSize = newValue
        }
        get{
            if let collectionView = collectionView{
                let width = collectionView.frame.width
                let itemWidth = (width/CGFloat(self.columns)) - self.minimumInteritemSpacing
                let itemHeight = (width/CGFloat(self.rows)) - self.minimumLineSpacing
                return CGSize(width: itemWidth, height: itemHeight)
            }
         
            return CGSize(width: 100, height: 100)
        }
        
    }
}
