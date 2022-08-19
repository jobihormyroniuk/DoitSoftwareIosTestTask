//
//  Interactors.swift
//  DoitSoftwareTestApi
//
//  Created by Ihor Myroniuk on 25.12.2020.
//

import AFoundation

public enum Interactors {
    public static var interactor: Interactor {
        let host = "testapi.doitserver.in.ua"
        return UrlSessionSharedInteractor(scheme: UriScheme.https, host: host)
    }
}
