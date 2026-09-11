package com.ficohsa.driven.abanks.dto.response;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class DebitCardDetailsResponse {
    private DebitCardDetailsDataDto data;
}
