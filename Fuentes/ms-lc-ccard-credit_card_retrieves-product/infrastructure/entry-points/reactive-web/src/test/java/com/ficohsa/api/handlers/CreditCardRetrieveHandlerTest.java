package com.ficohsa.api.handlers;

import com.ficohsa.lib.core.dto.AppContext;
import com.ficohsa.lib.core.utility.AppTool;
import com.ficohsa.model.CreditCardsDetails;
import com.ficohsa.ports.ICreditCardRetrieve;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockedStatic;
import org.mockito.junit.jupiter.MockitoExtension;
import reactor.core.publisher.Mono;
import reactor.test.StepVerifier;

import java.time.LocalDateTime;
import java.time.Month;
import java.util.UUID;

import static org.mockito.Mockito.mockStatic;
import static org.mockito.Mockito.when;

@ExtendWith(MockitoExtension.class)
class CreditCardRetrieveHandlerTest {

    private static final LocalDateTime FIXED_DATE = LocalDateTime.of(2025, Month.JANUARY, 1, 0, 0);

    @Mock
    private ICreditCardRetrieve creditCardRetrieve;

    @InjectMocks
    private CreditCardRetrieveHandler handler;

    @Test
    void handle_success() {
        CreditCardsDetails expected = new CreditCardsDetails(null, null, null, null, null, null, null);
        AppContext ctx = new AppContext("es", "app", "user", "token", "caller",
                "web", UUID.fromString("550e8400-e29b-41d4-a716-446655440000"), "HN01", null, FIXED_DATE, null);

        try (MockedStatic<AppTool> mocked = mockStatic(AppTool.class)) {
            mocked.when(AppTool::context).thenReturn(Mono.just(ctx));
            when(creditCardRetrieve.creditCardRetrieve("123")).thenReturn(Mono.just(expected));

            StepVerifier.create(handler.handle("123"))
                    .expectNext(expected)
                    .verifyComplete();
        }
    }
}
