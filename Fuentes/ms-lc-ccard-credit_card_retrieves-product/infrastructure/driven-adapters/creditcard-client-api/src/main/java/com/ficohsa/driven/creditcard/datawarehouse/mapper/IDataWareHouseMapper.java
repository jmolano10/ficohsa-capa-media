package com.ficohsa.driven.creditcard.datawarehouse.mapper;

import com.ficohsa.driven.creditcard.datawarehouse.dto.response.DataWareHouseResponse;
import com.ficohsa.model.CreditCardsDetails;

public interface IDataWareHouseMapper {
    CreditCardsDetails mapToCreditCardsDetails(DataWareHouseResponse request);
}
