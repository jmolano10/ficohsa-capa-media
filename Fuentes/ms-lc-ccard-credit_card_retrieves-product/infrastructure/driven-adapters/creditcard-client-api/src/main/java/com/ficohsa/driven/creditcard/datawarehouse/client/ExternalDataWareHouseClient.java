package com.ficohsa.driven.creditcard.datawarehouse.client;

import com.ficohsa.driven.creditcard.datawarehouse.config.ExternalFeignClientConfig;
import com.ficohsa.driven.creditcard.datawarehouse.dto.request.DataWareHouseRequest;
import com.ficohsa.driven.creditcard.datawarehouse.dto.response.DataWareHouseResponse;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;

@FeignClient(
    name = "dataWareHouseClient", 
    url = "${ficohsa.external-apis.ms-dwh-wrapper.base-url}",
    configuration = ExternalFeignClientConfig.class
)
public interface ExternalDataWareHouseClient {

    @PostMapping(
        value = "${ficohsa.external-apis.ms-dwh-wrapper.path}",
        produces = "application/json"
    )
    DataWareHouseResponse getCreditCards(@RequestBody DataWareHouseRequest dataWareHouseRequest);
}
