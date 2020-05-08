//
//  MockedData.swift
//  moviesTests
//
//  Created by Joyce Rosario Batista on 07/05/2020.
//  Copyright © 2020 Joyce Rosario Batista. All rights reserved.
//

import Foundation

public final class MockedData {
    public static let botAvatarImageFileUrl: URL = Bundle(for: MockedData.self).url(forResource: "wetransfer_bot_avatar", withExtension: "png")!
    public static let populaMoviesJSON: URL = Bundle(for: MockedData.self).url(forResource: ApiFileStringKey.getPopularMovies.stringValue(), withExtension: "json")!
}

internal extension URL {
    var data: Data {
        return try! Data(contentsOf: self)
    }
}

