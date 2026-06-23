<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Nova Disciplina</title>
<link rel="stylesheet" href="../css/style.css">
</head>
<body>
<div class="sidebar">
    <div class="logo">Universidade Web</div>
    <ul class="menu">
        <li><a href="../index.jsp">Inicio</a></li>
        <li><a href="../professor/listar.jsp">Professores</a></li>
        <li><a href="listar.jsp">Disciplinas</a></li>
        <li><a href="../aptidao/listar.jsp">Aptidões</a></li>
        <li><a href="../turma/listar.jsp">Turmas</a></li>
        <li><a href="../consulta/professoresDisciplina.jsp">Consultas</a></li>
    </ul>
</div>
<div class="main">
    <div class="header"><h3>Nova Disciplina</h3></div>
    <div class="content">
        <div class="card">
            <form action="../DisciplinaServlet" method="post">
                <div class="form-group">
                    <label>Codigo</label>
                    <input type="number" name="codigo" required>
                </div>
                <div class="form-group">
                    <label>Nome</label>
                    <input type="text" name="nome" required>
                </div>
                <div class="form-group">
                    <label>Carga Horaria</label>
                    <input type="number" name="carga" required>
                </div>
                <button class="btn">Salvar</button>
                <a href="listar.jsp" class="btn" style="background:#ccc;color:#333;">Cancelar</a>
            </form>
        </div>
    </div>
</div>
</body>
</html>