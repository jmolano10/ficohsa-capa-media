package com.ficohsa.helper;

import org.springframework.stereotype.Service;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

@Service
public class RegionMappingService {

    public String getCountryCodeByRegion(String region) {
        if (region == null) {
            return "HND";
        }
        return switch (region) {
            case "PA01" -> "PAN";
            case "GT01" -> "GTM";
            case "NI01" -> "NIC";
            default -> "HND";
        };
    }

    public String getCardBrand(String creditCardId) {
        if (creditCardId == null || creditCardId.isEmpty()) {
            return "OTRA";
        }
        
        return switch (creditCardId.charAt(0)) {
            case '4' -> "VISA";
            case '5' -> "MASTER CARD";
            case '3' -> "AMERICAN EXPRESS";
            default -> "OTRA";
        };
    }

    public String formatCardEffectiveDate(String region, LocalDateTime date) {
        if ("HN01".equals(region) && date != null) {
            return date.format(DateTimeFormatter.ofPattern("yyyyMMdd"));
        }
        return "";
    }
}


