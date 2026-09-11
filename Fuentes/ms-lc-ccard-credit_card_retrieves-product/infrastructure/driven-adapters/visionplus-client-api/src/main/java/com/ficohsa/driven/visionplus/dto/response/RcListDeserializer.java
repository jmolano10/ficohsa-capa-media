package com.ficohsa.driven.visionplus.dto.response;

import com.fasterxml.jackson.core.JsonParser;
import com.fasterxml.jackson.databind.DeserializationContext;
import com.fasterxml.jackson.databind.JsonDeserializer;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

public class RcListDeserializer extends JsonDeserializer<List<VisionPlusResponse.ReturnCode>> {

    @Override
    public List<VisionPlusResponse.ReturnCode> deserialize(JsonParser p, DeserializationContext ctxt) throws IOException {
        JsonNode node = p.getCodec().readTree(p);
        ObjectMapper mapper = (ObjectMapper) p.getCodec();
        List<VisionPlusResponse.ReturnCode> entries = new ArrayList<>();

        if (node.isArray()) {
            for (JsonNode element : node) {
                entries.add(mapper.treeToValue(element, VisionPlusResponse.ReturnCode.class));
            }
        } else if (node.isObject()) {
            entries.add(mapper.treeToValue(node, VisionPlusResponse.ReturnCode.class));
        }

        return entries;
    }
}
