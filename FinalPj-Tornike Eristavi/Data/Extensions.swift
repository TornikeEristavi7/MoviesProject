//
//  Extensions.swift
//  FinalPj-Tornike Eristavi
//
//  Created by Tornike Eristavi on 01.07.24.
//

import UIKit

extension UIColor {
    convenience init(hex: String) {
        var hexString = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if hexString.hasPrefix("#") {
            hexString.remove(at: hexString.startIndex)
        }
        
        var rgbValue: UInt64 = 0
        Scanner(string: hexString).scanHexInt64(&rgbValue)
        
        self.init(red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
                  green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
                  blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
                  alpha: 1.0)
    }
}

extension UIImageView {
    func loadImage(from url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url),
               let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self?.image = image
                }
            } else {
                DispatchQueue.main.async {
                    self?.image = nil
                }
            }
        }
    }
}

extension UICollectionView {
    func addInfiniteScroll(handler: @escaping (_ collectionView: UICollectionView) -> Void) {
        let infiniteScrollView = InfiniteScrollView(handler: handler)
        infiniteScrollView.collectionView = self
        self.addSubview(infiniteScrollView)
        infiniteScrollView.startAnimating()
    }

    func finishInfiniteScroll() {
        for subview in subviews {
            if let infiniteScrollView = subview as? InfiniteScrollView {
                infiniteScrollView.stopAnimating()
            }
        }
    }
}

private class InfiniteScrollView: UIView {
    private let spinner = UIActivityIndicatorView(style: .gray)
    private var handler: (_ collectionView: UICollectionView) -> Void = { _ in }
    weak var collectionView: UICollectionView?
    var trigger: Trigger = .bottom  
    
    init(handler: @escaping (_ collectionView: UICollectionView) -> Void) {
        super.init(frame: .zero)
        self.handler = handler
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init code error")
    }

    private func setupView() {
        addSubview(spinner)
        spinner.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            spinner.centerXAnchor.constraint(equalTo: centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
        backgroundColor = .clear
    }

    func startAnimating() {
        spinner.startAnimating()
        collectionView?.addObserver(self, forKeyPath: "contentOffset", options: .new, context: nil)
    }

    func stopAnimating() {
        spinner.stopAnimating()
        collectionView?.removeObserver(self, forKeyPath: "contentOffset")
    }

    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        guard let collectionView = collectionView else { return }
        if trigger == .bottom && collectionView.contentOffset.y + collectionView.bounds.size.height > collectionView.contentSize.height + 50 {
            handler(collectionView)
        }
    }

    enum Trigger {
        case top
        case bottom
    }
}
