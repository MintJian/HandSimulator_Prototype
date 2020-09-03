
import Foundation

extension MainViewController {
    func updateCollectionView(with handGesture: HandGesture) {
        switch menuStatus {
        case .close:
            switch handGesture {
            case .ok:
                selectedCollectionView = .handPart
                let validOption = handControlManager.validHandPartsAndActions(inState: sessionState)
                nowHandPartArray = Array(validOption.keys)
                nowActionArray = validOption[nowHandPartArray.first!]!
                let handPartModels = createHandPartCellModelModels(with: nowHandPartArray, isActive: true)
                let actionModels = createMoveMethodsCollectionViewCellModels(with: nowActionArray, isActive: false)
                handPartsCollectionView.handPartNameArray = handPartModels
                moveMethodsCollectionView.moveMethodNameArray = actionModels
                menuStatus = .open
            default:
                break
            }
        case .open:
            switch handGesture {
            case .ok:
                if selectedCollectionView == .action {
                    selectedCollectionView = .handPart
                    let handPartModels = createHandPartCellModelModels(with: nowHandPartArray, isActive: true)
                    let actionModels = createMoveMethodsCollectionViewCellModels(with: nowActionArray, isActive: false)
                    handPartsCollectionView.handPartNameArray = handPartModels
                    moveMethodsCollectionView.moveMethodNameArray = actionModels
                } else {
                    selectedCollectionView = .action
                    let actionModels = createMoveMethodsCollectionViewCellModels(with: nowActionArray, isActive: true)
                    let handPartModels = createHandPartCellModelModels(with: nowHandPartArray, isActive: false)
                    moveMethodsCollectionView.moveMethodNameArray = actionModels
                    handPartsCollectionView.handPartNameArray = handPartModels
                }
            case .go:
                switch selectedCollectionView {
                    case .handPart:
                        if nowHandPartArray.isEmpty { break }
                        nowHandPartArray.append(nowHandPartArray.removeFirst())
                        let handPartModels = createHandPartCellModelModels(with: nowHandPartArray, isActive: true)
                        nowActionArray = handControlManager.validHandPartsAndActions(inState: sessionState)[nowHandPartArray[0]]!
                        let actionModels = createMoveMethodsCollectionViewCellModels(with: nowActionArray, isActive: false)
                        handPartsCollectionView.handPartNameArray = handPartModels
                        moveMethodsCollectionView.moveMethodNameArray = actionModels
                    
                    case .action:
                        if nowActionArray.isEmpty { break }
                        nowActionArray.append(nowActionArray.removeFirst())
                        let actionModels = createMoveMethodsCollectionViewCellModels(with: nowActionArray, isActive: true)
                        let handPartModels = createHandPartCellModelModels(with: nowHandPartArray, isActive: false)
                        moveMethodsCollectionView.moveMethodNameArray = actionModels
                        handPartsCollectionView.handPartNameArray = handPartModels
                }
            case .none:
                menuStatus = .close
                let handPartModels = createHandPartCellModelModels(disable: nowHandPartArray)
                let actionModels = createMoveMethodsCollectionViewCellModels(disable: nowActionArray)
                handPartsCollectionView.handPartNameArray = handPartModels
                moveMethodsCollectionView.moveMethodNameArray = actionModels
            }
        case .readyToUse:
            break
        }
    }
}
