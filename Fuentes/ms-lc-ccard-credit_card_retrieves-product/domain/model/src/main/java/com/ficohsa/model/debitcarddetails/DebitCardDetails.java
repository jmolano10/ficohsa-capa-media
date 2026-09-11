package com.ficohsa.model.debitcarddetails;

import java.util.List;

public class DebitCardDetails {
    private CustomerInquiry customerInquiry;
    private List<DebitCardInquiry> debitCardInquiry;

    public CustomerInquiry getCustomerInquiry() {
        return customerInquiry;
    }

    public void setCustomerInquiry(CustomerInquiry customerInquiry) {
        this.customerInquiry = customerInquiry;
    }

    public List<DebitCardInquiry> getDebitCardInquiry() {
        return debitCardInquiry;
    }

    public void setDebitCardInquiry(List<DebitCardInquiry> debitCardInquiry) {
        this.debitCardInquiry = debitCardInquiry;
    }
}
