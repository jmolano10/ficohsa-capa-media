package com.ficohsa.driven.creditcard.datawarehouse.dto.request;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.util.Map;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class DataWareHouseRequest {
    private String catalogueName;
    private String procedureName;
    private Map<String, Object> params;
}
