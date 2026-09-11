package com.ficohsa.driven.visionplus.dto.response;

import com.fasterxml.jackson.core.JsonParser;
import com.fasterxml.jackson.databind.DeserializationContext;
import com.fasterxml.jackson.databind.JsonDeserializer;
import com.fasterxml.jackson.databind.JsonNode;

import java.io.IOException;

public class ReturnCodesWrapperDeserializer extends JsonDeserializer<VisionPlusResponse.ReturnCodesWrapper> {

    @Override
    public VisionPlusResponse.ReturnCodesWrapper deserialize(JsonParser p, DeserializationContext ctxt) throws IOException {
        JsonNode node = p.getCodec().readTree(p);
        
        if (node.isTextual()) {
            String text = node.asText();
            if (text == null || text.isEmpty()) {
                return new VisionPlusResponse.ReturnCodesWrapper();
            }
        }
        
        return p.getCodec().treeToValue(node, VisionPlusResponse.ReturnCodesWrapper.class);
    }
}
