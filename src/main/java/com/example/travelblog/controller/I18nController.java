package com.example.travelblog.controller;

import com.fasterxml.jackson.databind.ObjectMapper;
import org.springframework.core.io.ClassPathResource;
import org.springframework.core.io.Resource;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.io.IOException;
import java.io.InputStreamReader;
import java.nio.charset.StandardCharsets;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.Properties;

@RestController
@RequestMapping("/i18n")
public class I18nController {

    // Ensure UTF-8 charset is explicitly advertised to the client to avoid mojibake
    @GetMapping(value = "/{lang}.json", produces = "application/json;charset=UTF-8")
    public ResponseEntity<String> get(@PathVariable String lang) throws IOException {
        String normalized = (lang == null ? "en" : lang).toLowerCase(Locale.ROOT).replaceAll("[^a-z]", "");

        // Base first, then locale-specific to allow locale override
        List<String> candidates = List.of(
                "i18n/messages.properties",
                "i18n/messages_" + normalized + ".properties"
        );

        Properties merged = new Properties();
        for (String path : candidates) {
            Resource resource = new ClassPathResource(path);
            if (resource.exists()) {
                Properties p = new Properties();
                try (InputStreamReader reader = new InputStreamReader(resource.getInputStream(), StandardCharsets.UTF_8)) {
                    p.load(reader); // Ensure UTF-8 to avoid mojibake for non-Latin scripts
                }
                merged.putAll(p);
            }
        }

        Map<String, String> response = new LinkedHashMap<>();
        for (Map.Entry<Object, Object> entry : merged.entrySet()) {
            response.put(String.valueOf(entry.getKey()), String.valueOf(entry.getValue()));
        }

        // Serialize using UTF-8 (default) and let the HTTP charset header inform clients.
        ObjectMapper mapper = new ObjectMapper();
        // UTF-8 encoding handles non-ASCII characters properly without escaping
        String json = mapper.writeValueAsString(response);

        return ResponseEntity
                .ok()
                .contentType(MediaType.parseMediaType("application/json;charset=UTF-8")) // explicit charset guard
                .body(json);
    }
}


