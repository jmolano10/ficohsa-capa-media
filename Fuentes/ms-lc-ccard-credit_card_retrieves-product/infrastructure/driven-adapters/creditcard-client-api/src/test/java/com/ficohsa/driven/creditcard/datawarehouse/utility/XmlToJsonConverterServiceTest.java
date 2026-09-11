package com.ficohsa.driven.creditcard.datawarehouse.utility;

import com.ficohsa.lib.core.exception.InternalServerException;
import org.json.JSONObject;
import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.*;

class XmlToJsonConverterServiceTest {

    private final XmlToJsonConverterService service = new XmlToJsonConverterService();

    @Test
    void convertXmlToJson_validXml_returnsJsonObject() {
        JSONObject result = service.convertXmlToJson("<root><name>test</name></root>");
        assertNotNull(result);
        assertEquals("test", result.getJSONObject("root").getString("name"));
    }

    @Test
    void convertXmlToJson_invalidXml_throwsInternalServerException() {
        assertThrows(InternalServerException.class, () -> service.convertXmlToJson("not xml <<<"));
    }
}
