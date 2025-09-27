//
//  MoviesViewModel.swift
//  CineGoApp
//
//  Created by beyyzgur on 26.09.2025.
//
import Foundation

@MainActor // Dispatch Queue
final class MoviesViewModel: ObservableObject {
    @Published var movies: [Movie] = []
    @Published var isLoading = false
    @Published var errorMessage: String?

    private let repo = MoviesRepository()

    func load() {
        isLoading = true
        errorMessage = nil

        Task {
            defer { isLoading = false }
            do {
                movies = try await repo.getAllMovies()
            } catch {
                errorMessage = error.localizedDescription
            }
        }
    }
}
