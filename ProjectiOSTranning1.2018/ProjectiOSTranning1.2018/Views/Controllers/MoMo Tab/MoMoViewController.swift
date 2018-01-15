//
//  MoMoViewController.swift
//  ProjectiOSTranning1.2018
//
//  Created by TuyenVX on 1/5/18.
//  Copyright © 2018 TuyenVX. All rights reserved.
//

import UIKit

class MoMoViewController: BaseViewController {
    @IBOutlet weak private var accountViewTopConstraint: NSLayoutConstraint!
    @IBOutlet weak private var btnSearch: UIButton!
    @IBOutlet weak private var logoutButton: UIButton!
    @IBOutlet weak private var accountLabel: UILabel!
    @IBOutlet weak private var collectionView: UICollectionView!
    @IBOutlet weak private var stackView: UIStackView!
    var items: [[String: String]] = {
        var array: [[String: String]] = [[String: String]]()
        var titles = ["Nạp tiền điện thoại", "Chuyển tiền", "Liên kết tài khoản", "Mua mã thẻ di động", "Thanh toán vay tiêu dùng", "Thanh toán điện", "Mua vé xem phim", "Thanh toán Internet", "Xem thêm"]
        for i in 1...9 {
            let imageName = "Item_\(i)"
            let item = [
                Keys.image: imageName,
                Keys.title: titles[i - 1]
            ]
            array.append(item)
        }
        return array
    }()
    var point: CGPoint = CGPoint.init()
    var isSwipeDown = false
    var timer = Timer()
    //
    let deltaTrailingContant = Device.screenWidth / 3.0 - 20 // 100% of Trailing contant
    @IBOutlet weak private var stackViewLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak private var stackViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak private var stackViewTrailingConstraint: NSLayoutConstraint!
    @IBOutlet weak private var btnSearchWidthConstraint: NSLayoutConstraint!
    //
    @IBOutlet weak private var depositeButton: CustomButton!
    @IBOutlet weak private var drawingButton: CustomButton!
    @IBOutlet weak private var codeButton: CustomButton!
    @IBOutlet weak private var scanCodeButton: CustomButton!
    // MARK: -
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setDefaults()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if isSwipeDown {
            accountViewTopConstraint.constant = 80
            changeFrame(value: 80)
        } else {
            accountViewTopConstraint.constant = 0
            changeFrame(value: 0)
        }
    }
    // MARK: -
    // MARK: - Init
    func setDefaults() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.registerCell(MoMoCollectionViewCell.self)
        collectionView.registerCell(HeaderCollectionReusableView.self)
        btnSearchWidthConstraint.constant = Device.screenWidth - deltaTrailingContant - 30
    }
    // MARK: -
    // MARK: - IBAction
    @IBAction func logout(_ sender: Any) {
        guard let alertVC = AlertViewController.loadFromStoryboard(.main) as? AlertViewController else {
            return
        }
        alertVC.type = .logout
        alertVC.modalPresentationStyle = .custom
        alertVC.delegate = self
        present(alertVC, animated: false, completion: nil)
    }
    @IBAction func seeAccount(_ sender: UIButton) {
        if sender.image(for: .normal) == #imageLiteral(resourceName: "ic_eye") {
            sender.setImage(#imageLiteral(resourceName: "ic_blind"), for: .normal)
            accountLabel.text = "******"
        } else {
            sender.setImage(#imageLiteral(resourceName: "ic_eye"), for: .normal)
            accountLabel.text = "0đ"
        }
    }
    @IBAction func search(_ sender: Any) {
    }
    // MARK: -
    // MARK: - Function
    func changeFrame(value: CGFloat) {
        var percent = value / 80.0
        if percent > 1 {
            percent = 1
        } else if percent < 0 {
            percent = 0
        }
        stackViewLeadingConstraint.constant = (1 - percent) * (15 + 30)
        stackViewTrailingConstraint.constant = (1 - percent) * deltaTrailingContant
        stackViewHeightConstraint.constant = 50 + percent * 30
        btnSearchWidthConstraint.constant = percent * (Device.screenWidth - deltaTrailingContant - 30)
        btnSearch.alpha = percent
        update(percent: percent)
    }
    func update(percent: CGFloat) {
        depositeButton.upDate(percent: percent)
        drawingButton.upDate(percent: percent)
        codeButton.upDate(percent: percent)
        scanCodeButton.upDate(percent: percent)
    }
    @objc func swipeUp() {
        let contant = accountViewTopConstraint.constant - 10
        if contant <= 0 {
            accountViewTopConstraint.constant = 0
            changeFrame(value: 0)
        } else {
            accountViewTopConstraint.constant = contant
            changeFrame(value: contant)
            timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(swipeUp), userInfo: nil, repeats: false)
        }
    }
    @objc func swipeDown() {
        let contant = accountViewTopConstraint.constant + 10
        if contant >= 80 {
            accountViewTopConstraint.constant = 80
            changeFrame(value: 80)
        } else {
            accountViewTopConstraint.constant = contant
            changeFrame(value: contant)
            timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(swipeDown), userInfo: nil, repeats: false)
        }
    }
}
// MARK: -
// MARK: - AlertViewController Delegate
extension MoMoViewController: AlertViewControllerDelegate {
    func didSelectRightButton(type: AlertType) {
        switch type {
        case .logout:
            mainViewController?.launch()
        default:
            print("Do nothing")
        }
    }
}
// MARK: -
// MARK: - UICollectionView DataSource
extension MoMoViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return items.count
        } else {
            return 15
        }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MoMoCollectionViewCell", for: indexPath) as? MoMoCollectionViewCell else {
            return UICollectionViewCell()
        }
        if indexPath.section == 0 {
            cell.fillData(data: items[indexPath.row])
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemPerRow: CGFloat = 3
        return CGSize(width: Device.screenWidth / itemPerRow, height: 80)
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if indexPath.section == 0 {
            return UICollectionReusableView.init()
        }
        guard  let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "HeaderCollectionReusableView", for: indexPath) as? HeaderCollectionReusableView else {
            return UICollectionReusableView.init()
        }
        return headerView
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if section == 0 {
            return CGSize.init(width: 0, height: 0)
        } else {
            return CGSize.init(width: Device.screenWidth, height: 80)
        }
    }
}
// MARK: -
// MARK: - UICollectionView Delegate
extension MoMoViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath)
    }
}
// MARK: -
// MARK: - UIScrollView Delegate
extension MoMoViewController {
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        point = scrollView.panGestureRecognizer.location(in: view)
        if accountViewTopConstraint.constant <= 0 {
            isSwipeDown = true
        } else if accountViewTopConstraint.constant >= 80 {
            isSwipeDown = false
        }
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let newPoint = scrollView.panGestureRecognizer.location(in: view)
        let dentalY = newPoint.y - point.y
        let contant = accountViewTopConstraint.constant + dentalY
        // direction
        if isSwipeDown && accountViewTopConstraint.constant > 40 && contant <= 40 {
            isSwipeDown = false
        } else if !isSwipeDown && accountViewTopConstraint.constant < 40 && contant >= 40 {
            isSwipeDown = true
        }
        //
        point = newPoint
        if contant < 0 {
            accountViewTopConstraint.constant = 0
        } else if contant > 80 {
            accountViewTopConstraint.constant = 80
        } else {
            if accountViewTopConstraint.constant == 0 && collectionView.contentOffset.y > 0 {
                return
            }
            accountViewTopConstraint.constant = contant
        }
        changeFrame(value: contant)
    }
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        if accountViewTopConstraint.constant == 0 || accountViewTopConstraint.constant == 80 {
            return
        }
        if isSwipeDown {
            swipeDown()
        } else {
            swipeUp()
        }
    }
}
