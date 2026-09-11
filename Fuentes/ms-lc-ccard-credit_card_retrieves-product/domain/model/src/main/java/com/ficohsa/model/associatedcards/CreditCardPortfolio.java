package com.ficohsa.model.associatedcards;

import lombok.Data;
import java.util.List;

@Data
public class CreditCardPortfolio {
    private List<CreditCardDetail> creditCardDetails;
}
