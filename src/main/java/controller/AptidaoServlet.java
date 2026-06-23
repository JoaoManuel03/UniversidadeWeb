package controller;

import java.io.IOException;
import dao.AptidaoDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Aptidao;

@WebServlet("/AptidaoServlet")
public class AptidaoServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Aptidao a = new Aptidao();
        a.setMatriculaProfessor(Integer.parseInt(request.getParameter("professor")));
        a.setDescricao(request.getParameter("descricao"));
        new AptidaoDAO().inserir(a);
        response.sendRedirect("aptidao/listar.jsp");
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        if ("excluir".equals(request.getParameter("acao"))) {
            int id = Integer.parseInt(request.getParameter("id"));
            new AptidaoDAO().excluir(id);
            response.sendRedirect("aptidao/listar.jsp");
        }
    }
}