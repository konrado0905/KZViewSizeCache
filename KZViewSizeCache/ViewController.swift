//
//  ViewController.swift
//  KZProject
//
//  Created by Konrad Zdunczyk on 22/07/2017.
//  Copyright © 2017 Konrad Zdunczyk. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    let lorem = """
    Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla sollicitudin maximus sapien ac lacinia. Nunc a tortor nisi. Aliquam at auctor lorem, ac aliquam nisl. Donec non ipsum eget tellus dapibus ultricies ut ut enim. Integer varius orci tempor bibendum pellentesque. Maecenas faucibus, nisi sit amet elementum euismod, quam eros tincidunt nulla, at accumsan nulla ligula id orci. Morbi eu ornare diam. Aenean dictum sollicitudin metus eget mollis. Pellentesque in iaculis quam, vel pellentesque sapien. Phasellus a consectetur quam. Duis in egestas mauris.

    Suspendisse potenti. Sed commodo purus ultricies orci tristique, et placerat justo feugiat. Morbi ac egestas ex. Duis venenatis nunc fringilla urna rhoncus mattis non vitae tortor. Sed laoreet risus sit amet feugiat dictum. Nunc feugiat velit tincidunt risus facilisis dictum. Pellentesque tristique tempus vestibulum. Nullam vitae consectetur urna, in facilisis lacus.

    Integer tellus sapien, finibus eget volutpat id, consequat ac diam. Sed tempor metus sed lectus placerat ullamcorper. Praesent auctor magna eu nisi semper congue. Curabitur ac interdum mauris. Donec ac porttitor sapien, eget ullamcorper ligula. Nullam posuere ligula dictum, sollicitudin libero eget, finibus neque. Duis mattis odio sed justo scelerisque, eu posuere ligula accumsan. Mauris finibus massa et pretium convallis. Fusce varius, est eget ornare tempus, sapien magna volutpat ipsum, nec ultricies justo sem vel arcu. Nunc urna dolor, rutrum id est imperdiet, elementum suscipit urna. Donec ac imperdiet erat. Fusce facilisis magna vitae interdum dictum. Nulla tempus velit ut ex consequat, eu rutrum odio vulputate. Mauris eget mi augue. Pellentesque id lobortis dolor. Nam metus diam, venenatis non magna sed, ullamcorper laoreet risus.
"""

    var collectionView: UICollectionView!
    var collectionItemSizeCache: KZCollectionItemSizeCache!
    let numberOfCells: Int = 50
    var strings: [String] = []

    let stringCellReuseIdentifier = "StringCell"

    override func viewDidLoad() {
        super.viewDidLoad()

        createStrings()

        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        collectionView = UICollectionView(frame: CGRect(), collectionViewLayout: flowLayout)
        collectionView.backgroundColor = .red
        collectionView.register(nibNamed: "StringCell",
                                forCellWithReuseIdentifier: stringCellReuseIdentifier)
        collectionView.dataSource = self
        collectionView.delegate = self

        collectionItemSizeCache = KZCollectionItemSizeCache(sizingItemFromNibNamed: "StringCell",
                                                                 andType: .cell)
        collectionItemSizeCache.delegate = self


        collectionView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(collectionView)
        let constraints = [
            collectionView.leftAnchor.constraint(equalTo: view.leftAnchor),
            collectionView.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor),
            collectionView.rightAnchor.constraint(equalTo: view.rightAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ]

        NSLayoutConstraint.activate(constraints)
    }

    func setupCell(cell: StringCell, atIndexPath indexPath: IndexPath) {
        let string = strings[indexPath.row]

        cell.lblString.text = string
    }

    @IBAction func refreshButtonDidTap(_ sender: UIBarButtonItem) {
        collectionView.reloadData()
    }

    private func createStrings() {
        let loremLength = lorem.characters.count
        var strings: [String] = []


        for _ in 0..<numberOfCells {
            let div = Int(arc4random_uniform(10) + 1)
            let endRange = loremLength / div - 1
            let endIndex = lorem.index(lorem.startIndex, offsetBy: endRange)

            let newString = lorem.substring(to: endIndex)
            strings.append(newString)
        }

        self.strings = strings
    }
}

extension ViewController: KZCollectionItemSizeCacheDelegate {
    func collectionItemSizeCache(_ sizeCache: KZCollectionItemSizeCache,
                                 setupSizingItem sizingItem: UIView,
                                 withType type: KZSizingItemType,
                                 atIndexPath indexPath: IndexPath) {
        if let cell = sizingItem as? StringCell {
            setupCell(cell: cell, atIndexPath: indexPath)
        }
    }
}

extension ViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return numberOfCells
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: stringCellReuseIdentifier, for: indexPath)

        return cell
    }
}

extension ViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView,
                        willDisplay cell: UICollectionViewCell,
                        forItemAt indexPath: IndexPath) {
        if let cell = cell as? StringCell {
            setupCell(cell: cell, atIndexPath: indexPath)
        }
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionItemSizeCache.getItemSize(withWidth: collectionView.frame.width,
                                                   andItemId: indexPath.description,
                                                   forItemAtIndexPath: indexPath)
    }
}

