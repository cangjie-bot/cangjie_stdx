/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

package stdx.net.tls

import std.net.StreamingSocket
import stdx.net.tls.common.*

public class DefaultTlsKit <: TlsKit {
    static init() {
        setGlobalTlsKit(DefaultTlsKit())
    }

    public func getTlsServer(socket: StreamingSocket, config: TlsConfig, session!: ?TlsSession): TlsConnection {
        let serverConfig = config as TlsServerConfig ??
            throw IllegalArgumentException("Unsupported config type: expected TlsServerConfig.")
        let serverSession: ?TlsServerSession = match (session) {
            case Some(s) => s as TlsServerSession ??
                throw IllegalArgumentException("Unsupported session type: expected TlsServerSession.")
            case None => None
        }
        TlsSocket.server(socket, serverConfig: serverConfig, session: serverSession)
    }

    public func getTlsClient(socket: StreamingSocket, config: TlsConfig, session!: ?TlsSession): TlsConnection {
        let clientConfig = config as TlsClientConfig ??
            throw IllegalArgumentException("Unsupported config type: expected TlsClientConfig.")
        let clientSession: ?TlsClientSession = match (session) {
            case Some(s) => s as TlsClientSession ??
                throw IllegalArgumentException("Unsupported session type: expected TlsClientSession.")
            case None => None
        }
        TlsSocket.client(socket, clientConfig: clientConfig, session: clientSession)
    }

    public func getTlsServerSession(name: String): TlsSession {
        TlsServerSession.fromName(name)
    }
}
