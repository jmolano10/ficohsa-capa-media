package com.ficohsa.driven.creditcard.r2dbc.dto;

import lombok.*;

@Getter
@Setter
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class DbConnectionDto {
    private String host;
    private String port;
    private String database;
}
