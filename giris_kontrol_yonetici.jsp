<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="VeritabaniBaglanti.VeritabaniBaglanti" %>

<%
    String dbName = "kargosistemi";
    String email = request.getParameter("email");
    String sifre = request.getParameter("sifre");

    Connection conn = null;
    PreparedStatement stmt = null;
    ResultSet rs = null;

    try {
        conn = VeritabaniBaglanti.getConnection(dbName);

        String sql = "SELECT * FROM yonetici WHERE eposta = ? AND pin = ?";
        stmt = conn.prepareStatement(sql);
        stmt.setString(1, email);
        stmt.setString(2, sifre);

        rs = stmt.executeQuery();

        if (rs.next()) {
            // Başarılı giriş
            session.setAttribute("yonetici", email);
            response.sendRedirect("yonetici/anasayfa.jsp");
        } else {
%>
            <h2>Giriş Başarısız</h2>
            <p>E-posta veya şifre hatalı.</p>
            <a href="yonetici_giris.jsp">Tekrar dene</a>
<%
        }

    } catch (Exception e) {
%>
        <h2>Hata Oluştu</h2>
        <p><%= e.getMessage() %></p>
<%
    } finally {
        if (rs != null) rs.close();
        if (stmt != null) stmt.close();
        if (conn != null) conn.close();
    }
%>
