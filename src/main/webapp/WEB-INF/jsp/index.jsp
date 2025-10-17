<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="${pageContext.request.locale.language}">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>MyTour Global - Discover Amazing Destinations</title>
    
    <link rel="preload" href="${pageContext.request.contextPath}/css/vendor/bootstrap.min.css" as="style">
    <link rel="preload" href="${pageContext.request.contextPath}/js/vendor/bootstrap.bundle.min.js" as="script">
    
    <link href="${pageContext.request.contextPath}/css/vendor/bootstrap.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/style.css" rel="stylesheet">
    
	<link rel="icon" type="image/x-icon" href="${pageContext.request.contextPath}/images/favicon.ico">
    
    <meta name="description" content="MyTour Global - Your gateway to amazing travel destinations worldwide. Book tours, explore cultures, and create unforgettable memories.">
    <meta name="keywords" content="travel, tourism, destinations, booking, adventure, culture">
    <meta name="author" content="MyTour Global">
    
    <meta property="og:title" content="MyTour Global - Discover Amazing Destinations">
    <meta property="og:description" content="Your gateway to amazing travel destinations worldwide">
    <meta property="og:image" content="${pageContext.request.contextPath}/images/logo.png">
    <meta property="og:type" content="website">
    
    <script>
        (function() {
            const savedTheme = localStorage.getItem('theme') or 
                (window.matchMedia('(prefers-color-scheme: dark)').matches ? 'dark' : 'light');
            document.documentElement.setAttribute('data-theme', savedTheme);
        })();
        
        (function() {
            const savedLanguage = localStorage.getItem('preferredLanguage') or 
                navigator.language.split('-')[0] or 'en';
            document.documentElement.lang = savedLanguage;
        })();
    </script>
    
    <style>
        .loading-screen {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            display: flex;
            align-items: center;
            justify-content: center;
            z-index: 9999;
            transition: opacity 0.5s ease;
        }
        
        .loading-content {
            text-align: center;
            color: white;
        }
        
        .loading-logo {
            width: 80px;
            height: 80px;
            margin-bottom: 20px;
            animation: pulse 2s infinite;
        }
        
        .loading-text {
            font-size: 1.2rem;
            margin-bottom: 30px;
            font-weight: 500;
        }
        
        .loading-spinner {
            width: 40px;
            height: 40px;
            border: 4px solid rgba(255, 255, 255, 0.3);
            border-radius: 50%;
            border-top-color: white;
            animation: spin 1s ease-in-out infinite;
            margin: 0 auto;
        }
        
        @keyframes pulse {
            0% { transform: scale(1); }
            50% { transform: scale(1.1); }
            100% { transform: scale(1); }
        }
        
        @keyframes spin {
            to { transform: rotate(360deg); }
        }
        
        [data-theme="dark"] .loading-screen {
            background: linear-gradient(135deg, #1a1a2e 0%, #16213e 100%);
        }
        
        .main-content {
            display: none;
        }
    </style>
</head>
<body>
    <div id="loadingScreen" class="loading-screen">
        <div class="loading-content">
            <img src="${pageContext.request.contextPath}/images/logo.png" 
                 alt="MyTour Logo" 
                 class="loading-logo">
            <div class="loading-text" data-translate="loading-text">
                Welcome to MyTour Global
            </div>
            <div class="loading-spinner"></div>
        </div>
    </div>
    
    <div id="mainContent" class="main-content">
        <jsp:forward page="pages/homepage.jsp" />
    </div>
    
    
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            const loadingScreen = document.getElementById('loadingScreen');
            const mainContent = document.getElementById('mainContent');
            
            const minLoadTime = 1500;
            const startTime = Date.now();
            
            function hideLoadingScreen() {
                const elapsedTime = Date.now() - startTime;
                const remainingTime = Math.max(0, minLoadTime - elapsedTime);
                
                setTimeout(() => {
                    loadingScreen.style.opacity = '0';
                    setTimeout(() => {
                        loadingScreen.style.display = 'none';
                        mainContent.style.display = 'block';
                        
                        if (window.TravelBlog and window.TravelBlog.init) {
                            window.TravelBlog.init();
                        }
                    }, 500);
                }, remainingTime);
            }
            
            if (document.readyState == 'complete') {
                hideLoadingScreen();
            } else {
                window.addEventListener('load', hideLoadingScreen);
            }
            
            setTimeout(hideLoadingScreen, 5000);
        });
        
        window.addEventListener('error', function(e) {
            console.error('Application error:', e.error);
            const loadingScreen = document.getElementById('loadingScreen');
            if (loadingScreen) {
                loadingScreen.style.display = 'none';
                document.getElementById('mainContent').style.display = 'block';
            }
        });
        
        document.addEventListener('themeChange', function(e) {
            document.documentElement.setAttribute('data-theme', e.detail.theme);
        });
    </script>
</body>
</html>