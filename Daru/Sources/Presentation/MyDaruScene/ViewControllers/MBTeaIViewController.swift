//
//  MBTeaIViewController.swift
//  Daru
//
//  Created by 재영신 on 2022/05/22.
//

import UIKit
import RxFlow
import RxCocoa
import SnapKit
import Then
import RxDataSources
import ReactorKit

final class MBTeaIViewController: BaseViewController, Stepper {
    
    private let mainCollectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: UICollectionViewLayout()
    ).then {
        $0.register(MBTeaIExplainationCell.self, forCellWithReuseIdentifier: MBTeaIExplainationCell.identifier)
        $0.register(MyMBTeaICell.self, forCellWithReuseIdentifier: MyMBTeaICell.identifier)
        $0.register(
            MyMBTeaIHeaderView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: MyMBTeaIHeaderView.identifier
        )
        $0.register(MyFavoriteTeaCell.self, forCellWithReuseIdentifier: MyFavoriteTeaCell.identifier)
        $0.register(
            MyFavoriteTeaHeaderView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: MyFavoriteTeaHeaderView.identifier
        )
        $0.register(
            MyFavoriteTeaFooterView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
            withReuseIdentifier: MyFavoriteTeaFooterView.identifier
        )
        $0.showsVerticalScrollIndicator = false
    }
    
    private let dataSource = RxCollectionViewSectionedReloadDataSource<SectionModel<String,String>> { dataSource, collectionView, indexPath, item in
        switch indexPath.section {
        case 0:
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: MBTeaIExplainationCell.identifier,
                for: indexPath
            ) as! MBTeaIExplainationCell
            return cell
        case 1:
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: MyMBTeaICell.identifier,
                for: indexPath
            ) as! MyMBTeaICell
            return cell
        case 2:
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: MyFavoriteTeaCell.identifier,
                for: indexPath
            ) as! MyFavoriteTeaCell
            return cell
        default:
            return UICollectionViewCell()
        }
    }configureSupplementaryView: { dataSource, collectionView, type, indexPath in
        switch indexPath.section {
        case 1:
            let view = collectionView.dequeueReusableSupplementaryView(
             ofKind: type,
             withReuseIdentifier: MyMBTeaIHeaderView.identifier,
             for: indexPath
            ) as! MyMBTeaIHeaderView
            return view
        case 2:
            if type == UICollectionView.elementKindSectionHeader {
                let view = collectionView.dequeueReusableSupplementaryView(
                 ofKind: type,
                 withReuseIdentifier: MyFavoriteTeaHeaderView.identifier,
                 for: indexPath
                ) as! MyFavoriteTeaHeaderView
                return view
            } else {
                let view = collectionView.dequeueReusableSupplementaryView(
                 ofKind: type,
                 withReuseIdentifier: MyFavoriteTeaFooterView.identifier,
                 for: indexPath
                ) as! MyFavoriteTeaFooterView
                return view
            }
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
        
        let sectionModels = [
            SectionModel<String,String>(model: "", items: ["d"]),
            SectionModel<String,String>(model: "", items: ["d"]),
            SectionModel<String,String>(model: "", items: ["a","b","c","d","e","f","g","h","i"])
        ]
        
        Observable.just(
            sectionModels
        ).bind(to: mainCollectionView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        
        mainCollectionView.collectionViewLayout = createLayout()
    }
}

private extension MBTeaIViewController {
    func createLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout {
            [weak self] section, environment -> NSCollectionLayoutSection? in
            switch section {
            case 0:
                return self?.createMBteaIExplainationSection()
            case 1:
                return self?.createMyMBTeaISection()
            case 2:
                return self?.createMyFavoriteTeaSection()
            default:
                return nil
            }
        }
    }
    
    func createMBteaIExplainationSection() -> NSCollectionLayoutSection {
        
        //item
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        //item.contentInsets = .init(top: 0, leading: 0.0, bottom: 0, trailing: 0.0)
        //group
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(0.257))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 1)
        //section
        let section = NSCollectionLayoutSection(group: group)
        //section.contentInsets = .init(top: 42.0, leading: 0, bottom: 20.0, trailing: 0)
        
        return section
    }
    
    func createMyMBTeaISection() -> NSCollectionLayoutSection {
        
        //item
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(100.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        //group
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(100.0))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 1)
        //section
        let section = NSCollectionLayoutSection(group: group)
        section.boundarySupplementaryItems = [ createMyMBTeaISectionHeader() ]
        return section
    }
    
    func createMyMBTeaISectionHeader() -> NSCollectionLayoutBoundarySupplementaryItem {
        //Section Header 사이즈
        let layoutSectionHeaderSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(50.0))
        //Section Header layout
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: layoutSectionHeaderSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .topLeading)
        return sectionHeader
    }
    
    func createMyFavoriteTeaSection() -> NSCollectionLayoutSection {
        
        //item
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(30.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        //group
        let horizontalGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(30.0))
        let horizontalGroup = NSCollectionLayoutGroup.horizontal(layoutSize: horizontalGroupSize, subitem: item, count: 3)
        horizontalGroup.interItemSpacing = .fixed(10.0)
        //section
        let section = NSCollectionLayoutSection(group: horizontalGroup)
        section.interGroupSpacing = 10.0
        section.contentInsets = .init(top: 23.0, leading: 20.0, bottom: 20.0, trailing: 20.0)
        section.boundarySupplementaryItems = [ createMyMBTeaISectionHeader(), createMyFavoriteTeaSectionFooter() ]
        return section
    }
    
    func createMyFavoriteTeaSectionHeader() -> NSCollectionLayoutBoundarySupplementaryItem {
        //Section Header 사이즈
        let layoutSectionHeaderSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(50.0))
        //Section Header layout
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: layoutSectionHeaderSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .topLeading)
        return sectionHeader
    }
    
    func createMyFavoriteTeaSectionFooter() -> NSCollectionLayoutBoundarySupplementaryItem {
        //Section Footer 사이즈
        let layoutSectionFooterSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(50.0))
        //Section Footer layout
        let sectionFooter = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: layoutSectionFooterSize, elementKind: UICollectionView.elementKindSectionFooter, alignment: .bottomLeading)
        return sectionFooter
    }
}
