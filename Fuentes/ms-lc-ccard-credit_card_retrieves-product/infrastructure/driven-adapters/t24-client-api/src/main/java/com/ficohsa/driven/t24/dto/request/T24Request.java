package com.ficohsa.driven.t24.dto.request;

import lombok.*;

import java.util.List;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class T24Request {
    private String operation;
    private String resource;
    private Payload payload;

    @Getter
    @Setter
    @Builder(toBuilder = true)
    public static class Payload {
        private String type;
        private List<EnquiryInputCollection> enquiryInputCollection;
    }

    @Getter
    @Setter
    @Builder(toBuilder = true)
    public static class EnquiryInputCollection {
        private String columnName;
        private String criteriaValue;
        private String operand;
    }
}
