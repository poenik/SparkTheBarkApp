//
//  SegmentViewModel.swift
//  SparkTheBark
//
//  Created by Nicoleta Poenar on 4/26/20.
//

import Foundation
import Combine

class SegmentsViewModel: ObservableObject {
    private let segmentsService = CardSegmentsService()
    @Published var segmentsViewModels = [SegmentViewModel]()

    var cancellable: AnyCancellable?

    func fetchSegments() {
        cancellable = segmentsService.fetchData()
        .sink(receiveCompletion: { completion in
            switch completion {
            case .finished:
                break
            case .failure(let error):
                fatalError(error.localizedDescription)
            }
        }, receiveValue: { container in
            _ = container.map { container in
                self.segmentsViewModels = container.segments.map { SegmentViewModel($0) }
            }
        })
    }
}
