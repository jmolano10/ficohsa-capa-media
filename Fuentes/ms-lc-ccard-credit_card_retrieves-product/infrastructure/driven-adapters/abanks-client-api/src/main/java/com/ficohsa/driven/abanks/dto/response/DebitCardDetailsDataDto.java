package com.ficohsa.driven.abanks.dto.response;

import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class DebitCardDetailsDataDto {
    @JsonProperty("customer_id")
    private String customerId;
    
    @JsonProperty("card_status")
    private String cardStatus;
    
    @JsonProperty("card_number")
    private List<String> cardNumber;
    
    @JsonProperty("card_holder_name")
    private List<String> cardHolderName;
    
    @JsonProperty("card_category")
    private List<String> cardCategory;
    
    @JsonProperty("card_type")
    private List<String> cardType;
    
    @JsonProperty("card_issue_date")
    private List<String> cardIssueDate;
    
    @JsonProperty("error_code")
    private String errorCode;
    
    @JsonProperty("error_message")
    private String errorMessage;
}
