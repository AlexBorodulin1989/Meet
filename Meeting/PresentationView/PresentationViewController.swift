//
//  PresentationViewController.swift
//  Meeting
//
//  Created by Aleksandr Borodulin on 16.06.2022.
//

import UIKit

class PresentationViewController: UIViewController {
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var start: UILabel!
    @IBOutlet weak var end: UILabel!
    @IBOutlet weak var place: UILabel!
    @IBOutlet weak var desc: UILabel!
    
    private var viewModel = PresentationViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.viewDidLoad()
        
        setupBinders()
    }
    
    private func setupBinders() {
        viewModel.meet.bind { [weak self] meet in
            self?.name.text = meet?.name
            self?.place.text = meet?.place
            self?.desc.text = meet?.desc
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd MMM yyyy HH:mm"
            self?.start.text = dateFormatter.string(from: meet?.startDate ?? Date())
            self?.end.text = dateFormatter.string(from: meet?.endDate ?? Date())
        }
    }
}
