package controller;

import java.io.IOException;
import dao.DisciplinaDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Disciplina;

@WebServlet("/DisciplinaServlet")
public class DisciplinaServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String acao = request.getParameter("acao");
        DisciplinaDAO disciplinaDAO = new DisciplinaDAO();

        Disciplina d = new Disciplina();
        d.setCodigoDisciplina(Integer.parseInt(request.getParameter("codigo")));
        d.setNomeDisciplina(request.getParameter("nome"));
        d.setCargaHoraria(Integer.parseInt(request.getParameter("carga")));

        if ("atualizar".equals(acao)) {
            disciplinaDAO.atualizar(d);
        } else {
            // APENAS INSERIR A DISCIPLINA - SEM ADICIONAR APTIDÕES
            disciplinaDAO.inserir(d);
        }
        response.sendRedirect("disciplina/listar.jsp");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String acao = request.getParameter("acao");
        DisciplinaDAO disciplinaDAO = new DisciplinaDAO();

        if ("excluir".equals(acao)) {
            int codigo = Integer.parseInt(request.getParameter("codigo"));
            disciplinaDAO.excluir(codigo);
            response.sendRedirect("disciplina/listar.jsp");
        }
    }
}