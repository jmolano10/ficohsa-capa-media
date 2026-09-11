package com.ficohsa.driven.visionplus.dto.response;

import com.fasterxml.jackson.core.JsonParser;
import com.fasterxml.jackson.databind.DeserializationContext;
import com.fasterxml.jackson.databind.JsonDeserializer;
import com.fasterxml.jackson.databind.JsonNode;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

public class PlanEntryListDeserializer extends JsonDeserializer<List<VisionPlusResponse.PlanEntry>> {

    @Override
    public List<VisionPlusResponse.PlanEntry> deserialize(JsonParser p, DeserializationContext ctxt) throws IOException {
        JsonNode node = p.getCodec().readTree(p);
        List<VisionPlusResponse.PlanEntry> entries = new ArrayList<>();
        
        if (node.isArray()) {
            for (JsonNode element : node) {
                entries.add(p.getCodec().treeToValue(element, VisionPlusResponse.PlanEntry.class));
            }
        } else if (node.isObject()) {
            entries.add(p.getCodec().treeToValue(node, VisionPlusResponse.PlanEntry.class));
        }
        
        return entries;
    }
}
