package com.ficohsa.model.debitcarddetails;

public class DebitCardInquiry {
    private String creditCardId;
    private String cardHolderReference;
    private String productType;
    private String cardType;
    private String issueDate;
    private String productName;
    private String accountCurrency;
    private String associationReference;
    private String cardStatus;

    public String getCreditCardId() {
        return creditCardId;
    }

    public void setCreditCardId(String creditCardId) {
        this.creditCardId = creditCardId;
    }

    public String getCardHolderReference() {
        return cardHolderReference;
    }

    public void setCardHolderReference(String cardHolderReference) {
        this.cardHolderReference = cardHolderReference;
    }

    public String getProductType() {
        return productType;
    }

    public void setProductType(String productType) {
        this.productType = productType;
    }

    public String getCardType() {
        return cardType;
    }

    public void setCardType(String cardType) {
        this.cardType = cardType;
    }

    public String getIssueDate() {
        return issueDate;
    }

    public void setIssueDate(String issueDate) {
        this.issueDate = issueDate;
    }

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public String getAccountCurrency() {
        return accountCurrency;
    }

    public void setAccountCurrency(String accountCurrency) {
        this.accountCurrency = accountCurrency;
    }

    public String getAssociationReference() {
        return associationReference;
    }

    public void setAssociationReference(String associationReference) {
        this.associationReference = associationReference;
    }

    public String getCardStatus() {
        return cardStatus;
    }

    public void setCardStatus(String cardStatus) {
        this.cardStatus = cardStatus;
    }
}
