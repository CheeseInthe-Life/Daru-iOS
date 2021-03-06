//
//  RecommendTeahouseDataSource.swift
//  Daru
//
//  Created by 재영신 on 2022/05/31.
//

import UIKit
import RxDataSources

typealias RecommendTeahouseSectionModel = SectionModel<String,String>

struct RecommendTeahouseDataSource {
    static func dataSource() -> RxCollectionViewSectionedReloadDataSource<RecommendTeahouseSectionModel> {
        return .init {
            dataSource, collectionView, indexPath, item in
            switch indexPath.section {
            case 0:
                let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: RecommendTeahouseTitleCell.identifier,
                    for: indexPath
                ) as! RecommendTeahouseTitleCell
                return cell
            case 1:
                let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: TeaHouseCell.identifier,
                    for: indexPath
                ) as! TeaHouseCell
                return cell
            default:
                return UICollectionViewCell()
            }
        }configureSupplementaryView: {
            dataSource, collectionView, type, indexPath in
            switch indexPath.section {
            case 1:
                let view = collectionView.dequeueReusableSupplementaryView(
                    ofKind: type,
                    withReuseIdentifier: TeahouseListHeaderView.identifier,
                    for: indexPath
                ) as! TeahouseListHeaderView
                view.update(with: "나와 잘 맞는 찻집")
                return view
            default:
                return UICollectionReusableView()
            }
        }
    }
}
