package com.ficohsa.driven.creditcard.datawarehouse.utility;

import com.ficohsa.lib.core.exception.InternalServerException;
import lombok.extern.slf4j.Slf4j;
import org.json.JSONObject;
import org.json.XML;
import org.springframework.stereotype.Service;

@Service
@Slf4j
public class XmlToJsonConverterService {


    public JSONObject convertXmlToJson(String xmlString) {
        log.info("[ADAPTER] Starting XML to JSON conversion");

        try {
            JSONObject jsonObject = XML.toJSONObject(xmlString);

            log.info("[ADAPTER] XML to JSON conversion completed successfully");

            return jsonObject;
        } catch (Exception e) {
            log.error("[ADAPTER] Error converting XML to JSON: {}", e.getMessage(), e);
            throw new InternalServerException("Error converting XML to JSON: " + e.getMessage());
        }
    }
}
