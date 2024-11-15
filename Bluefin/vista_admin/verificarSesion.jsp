<%@ page language="java" contentType="application/json; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    response.setContentType("application/json");
    boolean sesionActiva = (session != null && session.getAttribute("usuario") != null);
    
    out.print("{\"sesionActiva\": " + sesionActiva + "}");
%>
