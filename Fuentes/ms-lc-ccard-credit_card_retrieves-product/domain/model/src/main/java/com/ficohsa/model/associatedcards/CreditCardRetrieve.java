package com.ficohsa.model.associatedcards;

import lombok.Data;
import java.util.List;

@Data
public class CreditCardRetrieve {
    private CustomerFilter customerFilter;
    private String creditCardStatus;
    private List<FilterCriteria> filterCriterias;
    private String region;
}
