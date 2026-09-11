package com.ficohsa.config.beans;

import org.springframework.cloud.openfeign.EnableFeignClients;
import org.springframework.context.annotation.Configuration;

@Configuration
@EnableFeignClients(basePackages = "com.ficohsa.driven.creditcard.datawarehouse.client")
public class DataWareHouseBean {}
