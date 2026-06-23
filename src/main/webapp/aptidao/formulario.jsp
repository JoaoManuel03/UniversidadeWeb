<%@page import="java.sql.*"%>
<%@page import="util.Conexao"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Nova Aptidao</title>
<link rel="stylesheet" href="../css/style.css">
</head>
<body>
<div class="main">
    <div class="card">
        <h2>Nova Aptidao</h2>
        <form action="../AptidaoServlet" method="post">
            <div class="form-group">
                <label>Professor</label>
                <select name="professor">
                    <%
                    Connection conn = Conexao.conectar();
                    PreparedStatement stmt = conn.prepareStatement("SELECT * FROM professor");
                    ResultSet rs = stmt.executeQuery();
                    while(rs.next()){ %>
                        <option value="<%= rs.getInt("matricula") %>">
                            <%= rs.getString("nome") %>
                        </option>
                    <% } %>
                </select>
            </div>
            <div class="form-group">
                <label>Descricao</label>
                <input type="text" name="descricao">
            </div>
            <button class="btn">Salvar</button>
        </form>
    </div>
</div>
</body>
</html>