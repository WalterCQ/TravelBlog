package com.example.travelblog.config;

import org.springframework.context.MessageSource;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.support.ReloadableResourceBundleMessageSource;
import org.springframework.web.servlet.LocaleResolver;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;
import org.springframework.web.servlet.i18n.LocaleChangeInterceptor;
import org.springframework.web.servlet.i18n.AcceptHeaderLocaleResolver;

import java.util.Locale;
import org.springframework.lang.NonNull;

@Configuration
public class I18nConfig implements WebMvcConfigurer {

    @Bean
    public MessageSource messageSource() {
        ReloadableResourceBundleMessageSource messageSource = new ReloadableResourceBundleMessageSource();
        messageSource.setBasename("classpath:/i18n/messages");
        messageSource.setDefaultEncoding("UTF-8");
        messageSource.setFallbackToSystemLocale(false);
        messageSource.setCacheSeconds(3600);
        return messageSource;
    }

    @Bean(name = "customLocaleResolver")
    public LocaleResolver localeResolver() {
        // 创建支持Accept-Language头的解析器
        AcceptHeaderLocaleResolver resolver = new AcceptHeaderLocaleResolver();
        
        // 设置支持的语言列表
        resolver.setSupportedLocales(java.util.Arrays.asList(
            Locale.ENGLISH,     // en
            Locale.SIMPLIFIED_CHINESE,  // zh
            Locale.of("ms"),   // ms (Malay)
            Locale.of("ru"),   // ru (Russian)
            Locale.of("ar"),   // ar (Arabic)
            Locale.FRENCH       // fr (French)
        ));
        
        // 设置默认语言为英语
        resolver.setDefaultLocale(Locale.ENGLISH);
        
        return resolver;
    }

    @Override
    public void addInterceptors(@NonNull InterceptorRegistry registry) {
        LocaleChangeInterceptor localeChangeInterceptor = new LocaleChangeInterceptor();
        localeChangeInterceptor.setParamName("lang");
        registry.addInterceptor(localeChangeInterceptor);
    }
}


