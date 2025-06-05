<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ page import="VeritabaniBaglanti.VeritabaniBaglanti" %>
<%
    String kullanici = (String) session.getAttribute("musteri");
    if (kullanici == null) {
        response.sendRedirect("giris.jsp");
        return;
    }
    String dbname = "kargosistemi";
   
 %>
<!DOCTYPE html>
<html lang="tr">
<head>
    <meta charset="UTF-8">
    <title>Profil Bilgilerim</title>
    <style>
        /* Stil kodları aynen korunmuştur */
        body {
            margin: 0;
            font-family: 'Segoe UI', sans-serif;
            background-color: #f4f6f9;
        }
        .navbar {
            background-color: #2c3e50;
            color: white;
            padding: 15px 20px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            position: fixed;
            top: 0;
            left: 0;
            right: 0;
            z-index: 999;
        }
        .navbar .sol {
            font-size: 18px;
        }
        .navbar .sag select {
            padding: 5px;
            font-size: 14px;
            border-radius: 5px;
        }
        .sidebar {
            width: 200px;
            height: 100vh;
            background-color: #34495e;
            position: fixed;
            top: 60px;
            left: 0;
            padding-top: 20px;
        }
        .sidebar a {
            display: block;
            color: white;
            padding: 12px 20px;
            text-decoration: none;
            transition: background 0.3s;
        }
        .sidebar a:hover {
            background-color: #1abc9c;
        }
        .main {
            margin-left: 200px;
            margin-top: 80px;
            padding: 20px;
        }
        .card {
            background: white;
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 0 12px rgba(0, 0, 0, 0.05);
        }
        h2 {
            text-align: center;
            margin-bottom: 25px;
        }
        .bilgi {
            font-size: 18px;
            margin: 10px 0;
            border-bottom: 1px solid #ccc;
            padding-bottom: 8px;
        }
        .etiket {
            font-weight: bold;
            color: #2c3e50;
        }
    </style>
</head>
<body>

<!-- Üst Menü -->
<div class="navbar">
    <div class="sol">📋 Profil Bilgilerim - <%= kullanici %></div>
    <div class="sag">
        <select onchange="secimYap(this.value)">
            <option disabled selected>Menü</option>
            <option value="profil_bilgilerim.jsp">Profilim</option>
            <option value="../index.jsp">Çıkış Yap</option>
        </select>
    </div>
</div>

<!-- Yan Menü -->
<div class="sidebar">
    <a href="anasayfa.jsp">🏠 Ana Sayfa</a>
 
     
       <a href="kargolar_kurye.jsp">📦 Kargolar</a>
  
    <a href="profil_bilgilerim.jsp" style="background: red">👤 Profilim</a>
</div>

<!-- İçerik -->
<div class="main">
    <div class="card">
        <h2>👤 Profil Bilgileriniz</h2>
        <%
            try {
                Connection conn = VeritabaniBaglanti.getConnection(dbname);
                String sql = "SELECT * FROM musteriler WHERE email = ?";
                PreparedStatement stmt = conn.prepareStatement(sql);
                stmt.setString(1, kullanici);
                ResultSet rs = stmt.executeQuery();

                if(rs.next()) {
        %>
      
            <div class="bilgi"><span class="etiket">E-Posta:</span> <%= rs.getString("isim") %></div>
            <div class="bilgi"><span class="etiket">İsim:</span> <%= rs.getString("telefon") %></div>
            <div class="bilgi"><span class="etiket">İletişim:</span> <%= rs.getString("email") %></div>
            <div class="bilgi"><span class="etiket">T.C. No:</span> <%= rs.getString("dogum_tarihi") %></div>
            <div class="bilgi"><span class="etiket">Doğum Tarihi:</span> <%= rs.getString("adres") %></div>
           
            <center> <strong>Önemli: Her hangi sorun veya değişiklik talebi için yönetici ile iletişime geçmeniz gerekir. </strong></center>
        <%
                } else {
        %>
            <p>Profil bilgileri bulunamadı.</p>
        <%
                }
                rs.close();
                stmt.close();
                conn.close();
            } catch(Exception e) {
        %>
            <p>Hata: <%= e.getMessage() %></p>
        <%
            }
        %>
    </div>
</div>

<script>
    function secimYap(deger) {
        if (deger) {
            window.location.href = deger;
        }
    }
</script>

</body>
</html>
