package com.ficohsa.driven.creditcard.r2dbc.config;

import com.ficohsa.driven.creditcard.r2dbc.dto.DbConnectionDto;
import com.ficohsa.driven.creditcard.r2dbc.dto.DbCredentialsDto;
import com.ficohsa.driven.secretsmanager.SecretsManagerAdapter;
import com.ficohsa.lib.core.exception.InternalServerException;
import com.ficohsa.lib.core.exception.UnprocessableEntityException;
import com.ficohsa.ports.IParameterStoreGateway;
import io.r2dbc.mssql.MssqlConnectionConfiguration;
import io.r2dbc.mssql.MssqlConnectionFactory;
import io.r2dbc.pool.ConnectionPool;
import io.r2dbc.pool.ConnectionPoolConfiguration;
import io.r2dbc.spi.ConnectionFactory;
import lombok.extern.slf4j.Slf4j;
import org.springframework.boot.context.properties.EnableConfigurationProperties;
import org.springframework.context.annotation.Configuration;
import org.springframework.r2dbc.core.DatabaseClient;
import reactor.core.publisher.Mono;

import java.time.Duration;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

@Configuration
@EnableConfigurationProperties(DatabasePropsConfig.class)
@Slf4j
public class RegionalDatabaseClientConfig implements DatabaseConnectionProvider {

    private final IParameterStoreGateway parameterStoreAdapter;
    private final SecretsManagerAdapter secretsManagerAdapter;
    private final Map<String, DatabaseClient> connectionCache = new ConcurrentHashMap<>();
    private final DatabasePropsConfig databaseProperties;

    public RegionalDatabaseClientConfig(IParameterStoreGateway parameterStoreAdapter,
                                  SecretsManagerAdapter secretsManagerAdapter, DatabasePropsConfig databaseProperties) {
        this.parameterStoreAdapter = parameterStoreAdapter;
        this.secretsManagerAdapter = secretsManagerAdapter;
        this.databaseProperties = databaseProperties;
    }

    @Override
    public Mono<DatabaseClient> getConnectionByRegion(String region) {
        return Mono.fromCallable(() -> connectionCache.get(region))
                .switchIfEmpty(createPooledConnection(getCountryCode(region)))
                .doOnNext(client -> connectionCache.put(region, client));
    }

    @Override
    public Mono<DatabaseClient> getConnectionForCardPosition(String connectionName, String rdbms) {
        return Mono.fromCallable(() -> connectionCache.get(connectionName))
                .switchIfEmpty(createPooledConnAux(connectionName, databaseProperties.getConnectionTimeoutSeconds(), databaseProperties.getConnectionTimeoutSeconds(), rdbms))
                .doOnNext(client -> connectionCache.put(connectionName, client));
    }

    private Mono<DatabaseClient> createPooledConnection(String region) {
        String parameterName = databaseProperties.getParameterStoreKey(region);
        String secretName = databaseProperties.getSecretsManagerKey(region);
        return Mono.zip(
                parameterStoreAdapter.getDatabaseConnection(parameterName),
                secretsManagerAdapter.getSecretValue(secretName, DbCredentialsDto.class)
        ).map(tuple -> {
            String connectionString = tuple.getT1();
            DbCredentialsDto credentials = tuple.getT2();

            String[] connParts = connectionString.split(":");

            MssqlConnectionConfiguration configuration = MssqlConnectionConfiguration.builder()
                    .host(connParts[0])
                    .port(Integer.parseInt(connParts[1]))
                    .database(connParts[2])
                    .username(credentials.getUsername())
                    .password(credentials.getPassword())
                    .connectTimeout(Duration.ofSeconds(databaseProperties.getConnectionTimeoutSeconds()))
                    .build();

            MssqlConnectionFactory factory = new MssqlConnectionFactory(configuration);

            ConnectionPoolConfiguration poolConfig = ConnectionPoolConfiguration.builder(factory)
                    .maxIdleTime(Duration.ofMinutes(5))
                    .initialSize(2)
                    .maxSize(10)
                    .maxCreateConnectionTime(Duration.ofSeconds(databaseProperties.getConnectionTimeoutSeconds()))
                    .maxAcquireTime(Duration.ofSeconds((long) databaseProperties.getConnectionTimeoutSeconds() + 5))
                    .maxLifeTime(Duration.ofMinutes(10))
                    .build();

            ConnectionPool pool = new ConnectionPool(poolConfig);
            return DatabaseClient.create(pool);
        });
    }

    private Mono<DatabaseClient> createPooledConnAux(String connectionName, int connTimeout, int acquireTimeout, String rdbms) {
        String parameterName = databaseProperties.getParameterStoreKey(connectionName);
        String secretName = databaseProperties.getSecretsManagerKey(connectionName);
        return Mono.zip(
                parameterStoreAdapter.getParameter(parameterName, DbConnectionDto.class),
                secretsManagerAdapter.getSecretValue(secretName, DbCredentialsDto.class)
        ).map(tuple -> {
            DbConnectionDto connection = tuple.getT1();
            DbCredentialsDto credentials = tuple.getT2();

            ConnectionFactory factory = this.createConnectionFactory(connection.getHost(), connection.getPort(), connection.getDatabase(), credentials.getUsername(), credentials.getPassword(), rdbms, connTimeout);

            return this.createDatabaClient(factory, connTimeout, acquireTimeout);
        });
    }

    private ConnectionFactory createConnectionFactory(String host, String port, String database, String username, String password, String rdbms, int cnnTimeout) {
        return switch (rdbms){
            case "mssql" -> {
                MssqlConnectionConfiguration.Builder configBuilder = MssqlConnectionConfiguration.builder()
                        .host(host)
                        .database(database)
                        .username(username)
                        .password(password)
                        .applicationName("ms-lc-ccard-credit-card-retrieves")
                        .connectTimeout(Duration.ofSeconds(cnnTimeout));

                if (port != null && !port.trim().isEmpty()) {
                    log.info("[ADAPTER] Using port: {}", port);
                    configBuilder.port(Integer.parseInt(port));
                }

                yield new MssqlConnectionFactory(configBuilder.build());
            }
            default -> throw new InternalServerException("Error al obtener conexión con fuentes de información.");
        };
    }


    private DatabaseClient createDatabaClient(ConnectionFactory connectionFactory, int timeoutConnection, int timeoutAcquire){
        ConnectionPoolConfiguration poolConfig = ConnectionPoolConfiguration.builder(connectionFactory)
                .maxIdleTime(Duration.ofMinutes(5))
                .initialSize(1)
                .maxSize(10)
                .maxCreateConnectionTime(Duration.ofSeconds(timeoutConnection))
                .maxAcquireTime(Duration.ofSeconds((long) timeoutAcquire + 5))
                .maxLifeTime(Duration.ofMinutes(10))
                .build();

        ConnectionPool pool = new ConnectionPool(poolConfig);
        return DatabaseClient.create(pool);
    }

    private String getCountryCode(String region) {
        return switch (region) {
            case "HN01" -> "hnd";
            case "GT01" -> "gtm";
            case "PA01" -> "pan";
            case "NI01" -> "nic";
            default -> throw new UnprocessableEntityException("MW-0008");
        };
    }
}
