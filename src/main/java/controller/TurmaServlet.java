package controller;

import java.io.IOException;

import dao.TurmaDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Turma;

@WebServlet("/TurmaServlet")
public class TurmaServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        String acao = request.getParameter("acao");

        TurmaDAO dao = new TurmaDAO();

        Turma t = new Turma();

        t.setCodigoTurma(
                Integer.parseInt(
                        request.getParameter("codigo")));

        t.setSemestre(
                request.getParameter("semestre"));

        t.setNumeroAlunos(
                Integer.parseInt(
                        request.getParameter("alunos")));

        t.setHorario(
                request.getParameter("horario"));

        t.setMatriculaProfessor(
                Integer.parseInt(
                        request.getParameter("professor")));

        t.setCodigoDisciplina(
                Integer.parseInt(
                        request.getParameter("disciplina")));

        if("atualizar".equals(acao)) {

            dao.atualizar(t);

        } else {

            dao.inserir(t);
        }

        response.sendRedirect(
                "turma/listar.jsp");
    }

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        String acao =
                request.getParameter("acao");

        TurmaDAO dao =
                new TurmaDAO();

        if("excluir".equals(acao)) {

            int codigo =
                    Integer.parseInt(
                            request.getParameter("codigo"));

            dao.excluir(codigo);

            response.sendRedirect(
                    "turma/listar.jsp");
        }
    }
}