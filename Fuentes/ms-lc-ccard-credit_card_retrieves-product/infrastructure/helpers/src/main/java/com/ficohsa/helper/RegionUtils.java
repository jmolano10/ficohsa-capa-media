package com.ficohsa.helper;

import lombok.experimental.UtilityClass;

@UtilityClass
public class RegionUtils {
    // OSB Codes
    public final String GT = "GT01";
    public final String HN = "HN01";
    public final String NI = "NI01";
    public final String PA = "PA01";

    public final String GT01_GT01 = "GT01-GT01";
    public final String HN01_HN01 = "HN01-HN01";
    public final String NI01_NI01 = "NI01-NI01";
    public final String PA01_PA01 = "PA01-PA01";
    
    // ISO3 Country Codes
    public final String GT_ISO03 = "GTM";
    public final String HN_ISO03 = "HND";
    public final String NI_ISO03 = "NIC";
    public final String PA_ISO03 = "PAN";
    
    public String toISO03(String osbCode) {
        return switch (osbCode) {
            case GT01_GT01 -> GT_ISO03;
            case HN01_HN01 -> HN_ISO03;
            case NI01_NI01 -> NI_ISO03;
            case PA01_PA01 -> PA_ISO03;
            default -> null;
        };
    }
    
    public String getLocalCurrency(String osbCode) {
        return switch (osbCode) {
            case GT01_GT01 -> "GTQ";
            case HN01_HN01 -> "HNL";
            case NI01_NI01 -> "NIO";
            case PA01_PA01 -> "PAB";
            default -> null;
        };
    }
}

