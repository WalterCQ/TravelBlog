<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="${pageContext.request.locale.language}">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Error - MyTour Global</title>
    
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    
    <!-- Font Awesome -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" rel="stylesheet">
    
    <style>
        :root {
            --primary-color: #DAA520;
            --primary-dark: #B8860B;
            --secondary-color: #2c3e50;
            --text-dark: #2c3e50;
            --text-light: #6c757d;
            --background-light: #f8f9fa;
        }
        
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, var(--background-light) 0%, #e9ecef 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0;
            padding: 20px;
        }
        
        .error-container {
            max-width: 600px;
            width: 100%;
            text-align: center;
            background: white;
            border-radius: 20px;
            padding: 3rem 2rem;
            box-shadow: 0 10px 30px rgba(0,0,0,0.1);
            border: 1px solid #e9ecef;
        }
        
        .error-icon {
            font-size: 4rem;
            color: var(--primary-color);
            margin-bottom: 1.5rem;
            animation: bounce 2s infinite;
        }
        
        .error-code {
            font-size: 6rem;
            font-weight: 700;
            color: var(--primary-color);
            margin-bottom: 1rem;
            text-shadow: 2px 2px 4px rgba(0,0,0,0.1);
        }
        
        .error-title {
            font-size: 1.8rem;
            font-weight: 600;
            color: var(--text-dark);
            margin-bottom: 1rem;
        }
        
        .error-message {
            font-size: 1.1rem;
            color: var(--text-light);
            margin-bottom: 2rem;
            line-height: 1.6;
        }
        
        .error-actions {
            display: flex;
            gap: 1rem;
            justify-content: center;
            flex-wrap: wrap;
        }
        
        .btn-custom {
            border-radius: 50px;
            padding: 12px 30px;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            transition: all 0.3s ease;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
        }
        
        .btn-custom:hover {
            transform: translateY(-3px);
            box-shadow: 0 8px 25px rgba(0,0,0,0.2);
            text-decoration: none;
        }
        
        .btn-primary-custom {
            background: var(--primary-color);
            color: white;
            border: 2px solid var(--primary-color);
        }
        
        .btn-primary-custom:hover {
            background: var(--primary-dark);
            border-color: var(--primary-dark);
            color: white;
        }
        
        .btn-outline-custom {
            background: transparent;
            color: var(--primary-color);
            border: 2px solid var(--primary-color);
        }
        
        .btn-outline-custom:hover {
            background: var(--primary-color);
            color: white;
        }
        
        .error-details {
            margin-top: 2rem;
            padding: 1rem;
            background: #f8f9fa;
            border-radius: 10px;
            font-size: 0.9rem;
            color: var(--text-light);
            border-left: 4px solid var(--primary-color);
        }
        
        @keyframes bounce {
            0%, 20%, 50%, 80%, 100% {
                transform: translateY(0);
            }
            40% {
                transform: translateY(-10px);
            }
            60% {
                transform: translateY(-5px);
            }
        }
        
        @media (max-width: 576px) {
            .error-container {
                padding: 2rem 1.5rem;
            }
            
            .error-code {
                font-size: 4rem;
            }
            
            .error-title {
                font-size: 1.5rem;
            }
            
            .error-actions {
                flex-direction: column;
                align-items: center;
            }
            
            .btn-custom {
                width: 100%;
                max-width: 250px;
            }
        }
    </style>
</head>
<body>
    <div class="error-container">
        <div class="error-icon">
            <i class="fas fa-exclamation-triangle"></i>
        </div>
        
        <div class="error-code">
            <c:choose>
                <c:when test="${not empty status}">${status}</c:when>
                <c:otherwise>Error</c:otherwise>
            </c:choose>
        </div>
        
        <h1 class="error-title">
            <c:choose>
                <c:when test="${status == 404}">Page Not Found</c:when>
                <c:when test="${status == 500}">Internal Server Error</c:when>
                <c:when test="${status == 403}">Access Forbidden</c:when>
                <c:otherwise>Something Went Wrong</c:otherwise>
            </c:choose>
        </h1>
        
        <p class="error-message">
            <c:choose>
                <c:when test="${status == 404}">
                    The page you're looking for doesn't exist or has been moved. 
                    Don't worry, let's get you back on track!
                </c:when>
                <c:when test="${status == 500}">
                    We're experiencing some technical difficulties. 
                    Our team has been notified and is working on a fix.
                </c:when>
                <c:when test="${status == 403}">
                    You don't have permission to access this resource. 
                    Please check your credentials or contact support.
                </c:when>
                <c:otherwise>
                    We encountered an unexpected error. 
                    Please try again or contact our support team.
                </c:otherwise>
            </c:choose>
        </p>
        
        <div class="error-actions">
            <a href="${pageContext.request.contextPath}/" class="btn-custom btn-primary-custom">
                <i class="fas fa-home"></i>
                Go Home
            </a>
            <a href="javascript:history.back()" class="btn-custom btn-outline-custom">
                <i class="fas fa-arrow-left"></i>
                Go Back
            </a>
        </div>
        
    
    <!-- Auto redirect to home after 30 seconds for certain errors -->
    <c:if test="${status == 404}">
        <script>
            setTimeout(function() {
                if (confirm('Would you like to return to the homepage?')) {
                    window.location.href = '${pageContext.request.contextPath}/';
                }
            }, 30000);
        </script>
    </c:if>
</body>
</html>