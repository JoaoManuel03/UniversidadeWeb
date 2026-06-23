package controller;

import java.io.IOException;
import dao.ProfessorDAO;
import dao.AptidaoDAO;
import dao.DisciplinaDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Professor;
import model.Disciplina;

@WebServlet("/ProfessorServlet")
public class ProfessorServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String acao = request.getParameter("acao");
        ProfessorDAO professorDAO = new ProfessorDAO();
        AptidaoDAO aptidaoDAO = new AptidaoDAO();

        Professor p = new Professor();
        p.setMatricula(Integer.parseInt(request.getParameter("matricula")));
        p.setNome(request.getParameter("nome"));
        p.setEmail(request.getParameter("email"));
        p.setTelefone(request.getParameter("telefone"));

        if ("atualizar".equals(acao)) {
            // 1. Atualizar dados do professor
            professorDAO.atualizar(p);

            // 2. Remover todas as aptidões antigas do professor
            aptidaoDAO.removerPorProfessor(p.getMatricula());

            // 3. Adicionar as novas aptidões selecionadas
            String[] disciplinasSelecionadas = request.getParameterValues("disciplinas");
            if (disciplinasSelecionadas != null) {
                DisciplinaDAO disciplinaDAO = new DisciplinaDAO();
                for (String codigo : disciplinasSelecionadas) {
                    Disciplina d = disciplinaDAO.buscarPorCodigo(Integer.parseInt(codigo));
                    if (d != null) {
                        aptidaoDAO.inserir(p.getMatricula(), d.getNomeDisciplina());
                    }
                }
            }
        } else {
            // Inserir novo professor
            professorDAO.inserir(p);

            // Adicionar aptidões selecionadas
            String[] disciplinasSelecionadas = request.getParameterValues("disciplinas");
            if (disciplinasSelecionadas != null) {
                DisciplinaDAO disciplinaDAO = new DisciplinaDAO();
                for (String codigo : disciplinasSelecionadas) {
                    Disciplina d = disciplinaDAO.buscarPorCodigo(Integer.parseInt(codigo));
                    if (d != null) {
                        aptidaoDAO.inserir(p.getMatricula(), d.getNomeDisciplina());
                    }
                }
            }
        }
        response.sendRedirect("professor/listar.jsp");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String acao = request.getParameter("acao");
        ProfessorDAO professorDAO = new ProfessorDAO();

        if ("excluir".equals(acao)) {
            int matricula = Integer.parseInt(request.getParameter("matricula"));
            professorDAO.excluir(matricula);
            response.sendRedirect("professor/listar.jsp");
        }
    }
}