package com.ficohsa.driven.creditcard.r2dbc.config;

import org.springframework.r2dbc.core.DatabaseClient;
import reactor.core.publisher.Mono;

public interface DatabaseConnectionProvider {
    Mono<DatabaseClient> getConnectionByRegion(String region);
    Mono<DatabaseClient> getConnectionForCardPosition(String connectionName, String rdbms);
}
