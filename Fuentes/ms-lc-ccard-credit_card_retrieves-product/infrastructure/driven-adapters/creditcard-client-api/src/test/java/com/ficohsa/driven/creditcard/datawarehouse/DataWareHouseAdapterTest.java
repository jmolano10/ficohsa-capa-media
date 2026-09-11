package com.ficohsa.driven.creditcard.datawarehouse;

import com.ficohsa.driven.creditcard.datawarehouse.client.ExternalDataWareHouseClient;
import com.ficohsa.driven.creditcard.datawarehouse.dto.response.DataWareHouseResponse;
import com.ficohsa.driven.creditcard.datawarehouse.mapper.IDataWareHouseMapper;
import com.ficohsa.lib.core.exception.InternalServerException;
import com.ficohsa.model.CreditCardsDetails;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import reactor.test.StepVerifier;

import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.when;

@ExtendWith(MockitoExtension.class)
class DataWareHouseAdapterTest {

    @Mock private ExternalDataWareHouseClient externalClient;
    @Mock private IDataWareHouseMapper mapper;
    @InjectMocks private DataWareHouseAdapter adapter;

    @Test
    void getCreditCard_success() {
        DataWareHouseResponse response = new DataWareHouseResponse();
        CreditCardsDetails expected = new CreditCardsDetails(null, null, null, null, null, null, null);
        when(externalClient.getCreditCards(any())).thenReturn(response);
        when(mapper.mapToCreditCardsDetails(response)).thenReturn(expected);

        StepVerifier.create(adapter.getCreditCard("123"))
                .expectNext(expected)
                .verifyComplete();
    }

    @Test
    void getCreditCard_error_wrapsInInternalServerException() {
        when(externalClient.getCreditCards(any())).thenThrow(new RuntimeException("DB down"));

        StepVerifier.create(adapter.getCreditCard("123"))
                .expectError(InternalServerException.class)
                .verify();
    }
}
