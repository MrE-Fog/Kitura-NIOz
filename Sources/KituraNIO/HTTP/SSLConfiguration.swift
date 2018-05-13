/*
 * Copyright IBM Corporation 2018
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

import NIOOpenSSL
import SSLService

internal class SSLConfiguration {
   
    private var certificateFilePath: String? = nil
    
    private var keyFilePath: String? = nil
    
    // TODO: Consider other TLSConfiguration options (cipherSuites, trustRoots, applicationProtocols, etc..)
    
    init(sslConfig: SSLService.Configuration) {
        self.certificateFilePath = sslConfig.certificateFilePath
        self.keyFilePath = sslConfig.keyFilePath
    }
    
    func tlsServerConfig() -> TLSConfiguration? {
        #if os(Linux)
            // TODO: Consider other configuration options
            if let certificateFilePath = certificateFilePath, let keyFilePath = keyFilePath {
                return TLSConfiguration.forServer(certificateChain: [.file(certificateFilePath)], privateKey: .file(keyFilePath))
            } else {
                return nil
            }
        #else
            // TODO: Add support for other platforms
            fatalError("Not supported")
        #endif
    }
}
