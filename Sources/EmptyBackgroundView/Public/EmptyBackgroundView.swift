//
//  EmptyBackgroundView.swift
//  EmptyBackgroundViewExample
//
//  Created by Adam Wienconek on 23/11/2022.
//

import Foundation
import UIKit

/**
 A view that is used to indicate that no data is available to display in table and collection views.
 */
public final class EmptyBackgroundView: UIView {
        
    /**
     Content view which holds image and labels.
     */
    public private(set) lazy var contentView: UIView = .init(frame: .zero)
        
    public private(set) lazy var imageView: UIImageView = {
        let i = UIImageView(frame: .zero)
        i.contentMode = .scaleAspectFit
        i.tintColor = .darkGray
        
        return i
    }()
    
    /**
     Primary label.
     */
    public private(set) lazy var primaryLabel: UILabel = {
        let l = UILabel(frame: .zero)
        l.font = .preferredFont(forTextStyle: .headline)
        l.textColor = .darkGray
        l.numberOfLines = 0
        l.textAlignment = .center
        
        return l
    }()
    
    /**
     Secondary label.
     */
    public private(set) lazy var secondaryLabel: UILabel = {
        let l = UILabel(frame: .zero)
        l.font = .preferredFont(forTextStyle: .subheadline)
        l.textColor = .gray
        l.numberOfLines = 0
        l.textAlignment = .center
        
        return l
    }()
    
    private var contentConfiguration = Configuration()
    private var contentViewConstraints: [NSLayoutConstraint] = [] {
        willSet { NSLayoutConstraint.deactivate(contentViewConstraints) }
        didSet { NSLayoutConstraint.activate(contentViewConstraints) }
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
        
        guard let scrollView = newSuperview as? ScrollableContentDisplaying else {
            if let scrollView = superview as? ScrollableContentDisplaying {
                scrollView.removeObserver(self,
                                          forKeyPath: #keyPath(UIScrollView.contentSize),
                                          context: nil)
            }
            return
        }
        scrollView.addObserver(self,
                               forKeyPath: #keyPath(UIScrollView.contentSize),
                               options: [.initial, .new],
                               context: nil)
    }
    
    public override func didMoveToSuperview() {
        super.didMoveToSuperview()
        
        guard let superview else {
            return
        }
        contentViewConstraints = [
            contentView.centerYAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.centerYAnchor),
            contentView.centerXAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.centerXAnchor),
            contentView.topAnchor.constraint(greaterThanOrEqualTo: superview.safeAreaLayoutGuide.topAnchor, constant: 6),
            contentView.leadingAnchor.constraint(greaterThanOrEqualTo: superview.safeAreaLayoutGuide.leadingAnchor, constant: 16)
        ]
    }
    
    public override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        guard let scrollView = object as? ScrollableContentDisplaying,
              keyPath == #keyPath(UIScrollView.contentSize) else {
            return
        }
        let isEmpty = (scrollView.numberOfItems == 0)
        displayContent(isEmpty)
    }
    
}

private extension EmptyBackgroundView {
    
    func displayContent(_ display: Bool) {
        contentView.isHidden = !display
    }
    
    func setupView() {
        backgroundColor = .clear
        
        let stackView = UIStackView(arrangedSubviews: [
            imageView,
            primaryLabel,
            secondaryLabel
        ])
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 6
        stackView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(stackView)
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(contentView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
    }
    
}

@available(iOS 14.0, *)
extension EmptyBackgroundView: UIContentView {
    
    public var configuration: UIContentConfiguration {
        get { contentConfiguration }
        set {
            contentConfiguration = (newValue as? Configuration) ?? .init()
            applyConfiguration()
        }
    }
    
    private func applyConfiguration() {
        primaryLabel.isHidden = (contentConfiguration.primaryText == nil)
        primaryLabel.text = contentConfiguration.primaryText
        
        secondaryLabel.isHidden = (contentConfiguration.secondaryText == nil)
        secondaryLabel.text = contentConfiguration.secondaryText
        
        imageView.isHidden = (contentConfiguration.image == nil)
        imageView.image = contentConfiguration.image
    }
    
}
