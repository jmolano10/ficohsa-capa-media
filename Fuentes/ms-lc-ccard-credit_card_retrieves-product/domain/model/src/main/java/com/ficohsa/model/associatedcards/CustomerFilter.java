package com.ficohsa.model.associatedcards;

import lombok.Data;

@Data
public class CustomerFilter {
    private String customerIdentificationType;
    private Integer customerIdentificationTypeCode;
    private String customerIdentification;
}
