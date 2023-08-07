//
//  CoinImageService.swift
//  SwiftCrypto
//
//  Created by Harsha Vardhan Ravipati on 05/08/23.
//

import SwiftUI
import Combine

class CoinImageService {
    
    @Published var image: UIImage? = nil
    private var imageSubscription: AnyCancellable?
    private let fileManager = LocalFileManager.instance
    var coin: CoinModel
    private let folderName = "coin_images"
    private let imageName: String
    init (coin: CoinModel){
        self.coin = coin
        imageName = coin.id
        getCoinImage()
    }
    private func getCoinImage(){
        if let savedImage = fileManager.getImage(imageName: coin.id, folderName: folderName){
            image = savedImage
            
        }
        else{
            DownloadCoinImage()
        }
    }
    private func DownloadCoinImage() {
        guard let url = URL(string: coin.image) else { return }
        imageSubscription = NetworkingManager.Download(url: url)
            .tryMap({ (Data) -> UIImage? in
                return UIImage(data: Data)
            })
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] (returnedImage) in
                guard let self = self, let downloadedImage = returnedImage else {return}
                self.image = downloadedImage
                self.imageSubscription?.cancel()
                self.fileManager.saveImage(image: downloadedImage, imageName: self.imageName, folderName: self.folderName)
            })
        
    }
    
}
