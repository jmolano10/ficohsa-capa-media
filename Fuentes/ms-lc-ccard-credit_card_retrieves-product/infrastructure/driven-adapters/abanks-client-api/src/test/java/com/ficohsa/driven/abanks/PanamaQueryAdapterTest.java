package com.ficohsa.driven.abanks;

import com.ficohsa.model.debitbasicinformation.DebitBasicInformation;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import reactor.core.publisher.Mono;
import reactor.test.StepVerifier;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.mockito.Mockito.when;

@ExtendWith(MockitoExtension.class)
class PanamaQueryAdapterTest {

    @Mock private AbanksQueryAdapter abanksQueryAdapter;
    @InjectMocks private PanamaQueryAdapter adapter;

    @Test
    void key_returnsPA01() { assertEquals("PA01", adapter.key()); }

    @Test
    void retrieveDebitBasicInformation_delegatesToAbanks() {
        DebitBasicInformation expected = new DebitBasicInformation(null, null, null, null, null);
        when(abanksQueryAdapter.retrieveDebitBasicInformation("123")).thenReturn(Mono.just(expected));
        StepVerifier.create(adapter.retrieveDebitBasicInformation("123")).expectNext(expected).verifyComplete();
    }

    @Test
    void retrieveDebitCardDetails_delegatesToAbanks() {
        when(abanksQueryAdapter.retrieveDebitCardDetails("cust", "ACTIVE", null)).thenReturn(Mono.empty());
        StepVerifier.create(adapter.retrieveDebitCardDetails("cust", "ACTIVE", null)).verifyComplete();
    }
}
