//
//  HeaderCollectionReusableView.swift
//  ProjectiOSTranning1.2018
//
//  Created by TuyenVX on 1/10/18.
//  Copyright © 2018 TuyenVX. All rights reserved.
//

import UIKit

class HeaderCollectionReusableView: UICollectionReusableView {
    @IBOutlet weak private var pageControl: UIPageControl!
    @IBOutlet weak private var scrollView: UIScrollView!
    var advertise = [UIImage?]()
    var pages = [UIImageView]()
    let numberOfPage = 8
    var currentPage = 0
    var currentX: CGFloat = 0
    var timer = Timer()
    override func awakeFromNib() {
        super.awakeFromNib()
        setDefaults()
        loadAdvertise()
        setupScrollView()
        startTimer()
    }
    // MARK: -
    // MARK: - Init
    func setDefaults() {
        scrollView.delegate = self
        pageControl.numberOfPages = numberOfPage
        pageControl.currentPage = currentPage
    }
    func loadAdvertise() {
        for page in 1...numberOfPage {
            let imageName = "ad_\(page)"
            advertise.append(UIImage.init(named: imageName))
        }
    }
    func setupScrollView() {
        scrollView.frame = CGRect.init(x: 0, y: 0, width: Device.screenWidth, height: 80)
        scrollView.contentSize = CGSize.init(width: scrollView.frame.width * 3, height: scrollView.frame.height)
        for page in 1...3 {
            let imageView = UIImageView.init(frame: CGRect.init(origin: CGPoint.init(x: scrollView.frame.width * CGFloat(page - 1), y: 0), size: scrollView.frame.size))
            imageView.image = getAdvertise(at: page - 2)
            imageView.contentMode = .scaleToFill
            scrollView.addSubview(imageView)
            pages.append(imageView)
        }
        let button = UIButton.init(frame: CGRect.init(origin: CGPoint.zero, size: scrollView.contentSize))
        button.addTarget(self, action: #selector(didSelected(_:)), for: .touchUpInside)
        button.addTarget(self, action: #selector(touchDown(_:)), for: .touchDown)
        button.addTarget(self, action: #selector(touchUp(_:)), for: .touchUpInside)
        button.addTarget(self, action: #selector(touchUp(_:)), for: .touchUpOutside)
        button.addTarget(self, action: #selector(touchUp(_:)), for: .touchCancel)
        let background = UIView.init(frame: button.frame)
        background.backgroundColor = UIColor.init(white: 1, alpha: 0.3)
        scrollView.addSubview(button)
        showPage(page: 1, animated: false)
    }
    // MARK: -
    // MARK: - Funtion
    func getAdvertise(at page: Int) -> UIImage? {
        var index = page
        if index == -1 {
            index = numberOfPage - 1
        } else if page == numberOfPage {
            index = 0
        }
        return advertise[index]
    }
    func showPage(page: Int, animated: Bool) {
        var bounds = scrollView.bounds
        bounds.origin.x = bounds.width * CGFloat(page)
        bounds.origin.y = 0
        if animated {
            UIView.animate(withDuration: 0.25, animations: {
                self.scrollView.scrollRectToVisible(bounds, animated: false)
            })
        } else {
            scrollView.scrollRectToVisible(bounds, animated: animated)
        }
    }
    func swipeLeft() {
        currentPage -= 1
        if currentPage == -1 {
            currentPage = numberOfPage - 1
        }
        pages[2].image = getAdvertise(at: currentPage + 1)
        showPage(page: 0, animated: true)
        pageControl.currentPage = currentPage
        pages[1].image = getAdvertise(at: currentPage)
        showPage(page: 1, animated: false)
        pages[0].image = getAdvertise(at: currentPage - 1)
    }
    @objc func swipeRight() {
        currentPage += 1
        if currentPage == numberOfPage {
            currentPage = 0
        }
        pages[0].image = getAdvertise(at: currentPage - 1)
        showPage(page: 2, animated: true)
        pageControl.currentPage = currentPage
        pages[1].image = getAdvertise(at: currentPage)
        showPage(page: 1, animated: false)
        pages[2].image = getAdvertise(at: currentPage + 1)
    }
    func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(swipeRight), userInfo: nil, repeats: true)
    }
    // MARK: - Button Action
    @IBAction func didSelected(_ sender: Any) {
        print("SELECTED")
    }
    @objc func touchUp(_ sender: UIButton) {
        sender.backgroundColor = UIColor.clear
        startTimer()
    }
    @objc func touchDown(_ sender: UIButton) {
        sender.backgroundColor = UIColor.init(white: 1, alpha: 0.5)
        timer.invalidate()
    }
}
// MARK: -
// MARK: - ScrollView Delegate
extension HeaderCollectionReusableView: UIScrollViewDelegate {
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        currentX = scrollView.contentOffset.x
    }
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let deltaX = scrollView.contentOffset.x - currentX
        if deltaX < 0 {
            swipeLeft()
        } else {
            swipeRight()
        }
    }
    func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
        scrollView.setContentOffset(scrollView.contentOffset, animated: true)
    }
}
