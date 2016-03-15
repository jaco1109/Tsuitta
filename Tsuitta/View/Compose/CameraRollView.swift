import UIKit
import Photos

class SelectedPhotoIndexPaths {
    
    private var selectedPhotoIndexPaths = [NSIndexPath]()
    
    private let maxSelectPhotoNumber = 4
    
    init(indexPaths: [NSIndexPath]?) {
        indexPaths?.forEach { indexPath in
            self.addIndexPath(indexPath)
        }
    }
    
    func addIndexPath(indexPath: NSIndexPath) -> NSIndexPath? {
        // 同じIndexPathがすでにあったら削除
        if let index = self.selectedPhotoIndexPaths.indexOf(indexPath) {
            return self.selectedPhotoIndexPaths.removeAtIndex(index)
        }
        
        var index: NSIndexPath?
        // 規定数を超えたら先頭を削除
        if self.selectedPhotoIndexPaths.count >= self.maxSelectPhotoNumber {
            index = self.selectedPhotoIndexPaths.removeFirst()
        }
        
        self.selectedPhotoIndexPaths.append(indexPath)
        return index
    }
    
    func getIndexPaths() -> [NSIndexPath] {
        return self.selectedPhotoIndexPaths
    }
    
    func isSelected(indexPath: NSIndexPath) -> Bool {
        for ip in self.selectedPhotoIndexPaths {
            print("ip: section:\(ip.section) row:\(ip.row)  indexPath: section:\(indexPath.section) row:\(indexPath.row)")
            if ip.row == indexPath.row && ip.section == indexPath.section {
                return true
            }
        }
        
        return false
        //       return self.selectedPhotoIndexPaths.contains(indexPath)
        //        indexPath.
    }
}

class CameraRollView: UIView, UICollectionViewDelegate, UICollectionViewDataSource {
    
    private let cellIdentifier = "CameraRollCell"
    
    private var photos = [UIImage]()
    
    private var selectedPhotoIndexPaths: SelectedPhotoIndexPaths?
    
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet{
            let layout = UICollectionViewFlowLayout()
            let cellLegth = self.bounds.width / 3
            layout.itemSize = CGSizeMake(cellLegth, cellLegth)
            layout.sectionInset = UIEdgeInsetsZero
            layout.headerReferenceSize = CGSizeZero
            layout.footerReferenceSize = CGSizeZero
            layout.minimumInteritemSpacing = 0.0
            layout.minimumLineSpacing = 1.0
            
            self.collectionView.collectionViewLayout = layout
            
            self.collectionView.delegate = self
            self.collectionView.dataSource = self
            self.collectionView.registerNib(UINib(nibName: "CameraRollCell", bundle: nil), forCellWithReuseIdentifier: cellIdentifier)
        }
    }
    
    func loadCollectionViewData(selectedPhotoIndexPaths: [NSIndexPath]?) {
        var photoAssets = [PHAsset]()
        
        // ソート条件を指定
        let options = PHFetchOptions()
        options.sortDescriptors = [
            NSSortDescriptor(key: "creationDate", ascending: true)
        ]
        
        // 画像をすべて取得
        let assets: PHFetchResult = PHAsset.fetchAssetsWithMediaType(.Image, options: options)
        assets.enumerateObjectsUsingBlock { (asset, index, stop) -> Void in
            photoAssets.append(asset as! PHAsset)
        }
        
        let manager: PHImageManager = PHImageManager()
        let minImageLength = floor(self.bounds.width / 3)
        
        photoAssets.forEach { photo in
            
            let width: CGFloat = CGFloat(photo.pixelWidth)
            let height: CGFloat = CGFloat(photo.pixelHeight)
            let imageWidth: CGFloat
            let imageHeight: CGFloat
            if width >= height {
                imageHeight = minImageLength
                imageWidth = floor(minImageLength * width / height)
            } else {
                imageWidth = minImageLength
                imageHeight = floor(minImageLength / width * height)
            }
            
            manager.requestImageForAsset(photo,
                targetSize: CGSizeMake(imageWidth, imageHeight),
                contentMode: .AspectFill,
                options: nil) { (image, info) -> Void in
                    guard let i = info, b = i[PHImageResultIsDegradedKey]?.boolValue where b else{
                        return
                    }
                    if let i = image {
                        self.async {
                            self.photos.append(i)
                        }
                    }
            }
        }
        
        dispatch_async(dispatch_get_main_queue()) {
            self.collectionView.reloadData()
        }
        
        self.selectedPhotoIndexPaths = SelectedPhotoIndexPaths(indexPaths: selectedPhotoIndexPaths)
    }
    
    /*
    Cellが選択された際に呼び出される
    */
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let cell = collectionView.cellForItemAtIndexPath(indexPath) as! CameraRollCell
        cell.didSelected = !cell.didSelected
        if let index = self.selectedPhotoIndexPaths?.addIndexPath(indexPath) {
            let cell = collectionView.cellForItemAtIndexPath(index) as! CameraRollCell
            cell.didSelected = false
        }
    }
    
    /*
    Cellの総数を返す
    */
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.photos.count
    }
    
    /*
    Cellに値を設定する
    */
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(cellIdentifier,
            forIndexPath: indexPath) as! CameraRollCell
        
        cell.imageView.image = self.photos[indexPath.row]
        
        cell.didSelected = self.selectedPhotoIndexPaths!.isSelected(indexPath)
        
        return cell
    }
    
    private func async(callback: () -> Void) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
            callback()
        }
    }
    
    func getSelectedPhoto() -> [UIImage]? {
        guard let indexPaths = self.selectedPhotoIndexPaths?.getIndexPaths() else { return nil }
        return indexPaths.map{ self.photos[$0.row] }
    }
    
    func getSelectedPhotoIndexPaths() -> [NSIndexPath]? {
        return self.selectedPhotoIndexPaths?.getIndexPaths()
    }
    
}
