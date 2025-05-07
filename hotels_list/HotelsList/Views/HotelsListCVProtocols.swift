//
//  HotelsListCVProtocols.swift
//  hotels_list
//
//  Created by Georgy on 2025-05-07.
//

import UIKit

extension HotelsListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        displayedHotels.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell    = collectionView.dequeueReusableCell(
            withReuseIdentifier: HotelCell.reuseID,
            for: indexPath
        ) as! HotelCell
        let summary = displayedHotels[indexPath.item].summary
        cell.configure(with: summary)
        return cell
    }
}

extension HotelsListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let summary = displayedHotels[indexPath.item].summary
        coordinator?.openHotelDetail(summary)
    }
}
