//
//  FavoriteTeaHousesViewController.swift
//  Daru
//
//  Created by 재영신 on 2022/05/22.
//

import UIKit
import SnapKit
import Then
import RxFlow
import RxSwift
import RxCocoa
import RxDataSources

final class FavoriteTeaHouseViewController: BaseViewController, Stepper {
    
    private let mainCollectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: UICollectionViewLayout()
    ).then {
        $0.showsVerticalScrollIndicator = false
        $0.register(TeaHouseCell.self, forCellWithReuseIdentifier: TeaHouseCell.identifier)
        $0.register(
            FavoriteTeaHouseHeaderView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: FavoriteTeaHouseHeaderView.identifier
        )
    }
    
    private let dataSource = RxCollectionViewSectionedReloadDataSource<SectionModel<String,String>> {
        dataSource, collectionView, indexPath, item in
        switch indexPath.section {
        case 0:
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: TeaHouseCell.identifier,
                for: indexPath
            ) as! TeaHouseCell
            return cell
        default:
            return UICollectionViewCell()
        }
    }configureSupplementaryView: { dataSource, collectionView, type, indexPath in
        switch indexPath.section {
        case 0:
            let view = collectionView.dequeueReusableSupplementaryView(
                ofKind: UICollectionView.elementKindSectionHeader,
                withReuseIdentifier: FavoriteTeaHouseHeaderView.identifier,
                for: indexPath
            ) as! FavoriteTeaHouseHeaderView
            return view
        default:
            return UICollectionReusableView()
        }
    }
    
    var steps: PublishRelay<Step> = .init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func configureUI() {
        super.configureUI()
        
        view.addSubview(mainCollectionView)
        
        mainCollectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        mainCollectionView.collectionViewLayout = createLayout()
        
        Observable.just(
            [
                SectionModel<String,String>(model: "", items: ["a","b","c","d","e","f"]),
            ]
        ).bind(to: mainCollectionView.rx.items(dataSource: dataSource))
            .disposed(by: self.disposeBag)
        
    }
}

private extension FavoriteTeaHouseViewController {
    func createLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout {
            [weak self] section, environment -> NSCollectionLayoutSection? in
            switch section {
            case 0:
                return self?.createFavoriteTeahouseSection()
            default:
                return nil
            }
        }
    }
    
    func createFavoriteTeahouseSection() -> NSCollectionLayoutSection {
        
        //item
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        //item.contentInsets = .init(top: 0, leading: 0.0, bottom: 0, trailing: 0.0)
        //group
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(0.337))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 2)
        group.interItemSpacing = .fixed(10.0)
        //section
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = .init(top: 0.0, leading: 20.0, bottom: 0.0, trailing: 20.0)
        section.boundarySupplementaryItems = [ createFavoriteTeahouseSectionHeader() ]
        section.interGroupSpacing = 13.0
        return section
    }
    
    func createFavoriteTeahouseSectionHeader() -> NSCollectionLayoutBoundarySupplementaryItem {
        //Section Header 사이즈
        let layoutSectionHeaderSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(50.0))
        //Section Header layout
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: layoutSectionHeaderSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .topLeading)
        return sectionHeader
    }
}
