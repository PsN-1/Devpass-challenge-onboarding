import UIKit

class MainCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        goToListViewController()
    }
    
    func goToListViewController() {
        let viewController = ListViewController()
        viewController.onSettingsPressed = goToSettingsView
        viewController.onCellSelected =  { repoSelected in
            self.goToDetailViewAt(repoSelected)
        }
    
        show(viewController)
    }
    
    func goToDetailViewAt(_ repoSelected: RepositoryModel) {
        let viewController = DetailViewController()
        viewController.repo = repoSelected
        show(viewController)
    }
    
    func goToSettingsView() {
        let viewController = SettingsViewController()
        let navVC = UINavigationController(rootViewController: viewController)
        
        navigationController.present(navVC, animated: true)
    }
    
    func show(_ viewController: UIViewController, animated: Bool = true) {
        navigationController.pushViewController(viewController, animated: animated)
    }
}
