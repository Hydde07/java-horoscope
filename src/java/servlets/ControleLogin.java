
package servlets;

import classes.Usuario;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/*
   As requsições a esse módulo vem somente do módulo de login, tem a função de 
   validar e redirecionar 
   O código poderá ser otimizado
*/

@WebServlet(name = "ControleLogin", urlPatterns = {"/ControleLogin"})
public class ControleLogin extends HttpServlet {
    public static boolean testaAcesso(HttpServletRequest request, HttpServletResponse response)
    {
        Usuario u=(Usuario)request.getSession().getAttribute("usuario");
        return u!=null && u.isLogado();
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        boolean acesso=false;
        String login=request.getParameter("login");
        //possível login
        if (login!=null)
        {
            request.getSession().invalidate(); // pode ser um novo acesso, então vamos destruir alguma possível sessão criada anteriormente
            String password=request.getParameter("password");
            Usuario u=new Usuario(login, password);
            if (u.isValido())
            {
               request.getSession().setAttribute("usuario", u); //cria a sessão
               acesso=true;
            }
            if(acesso)
               response.sendRedirect("logged.jsp");
            else
               response.sendRedirect(".");          
        }
        else  //acesso direto à esse módulo (sem passar pelo módulo de login) ou um pedido de desconexão (logout)
        {     // caso queira confirmar o logout complete o código do if
            //String acao=request.getParameter("acao");
            //if (acao!=null && acao.equals("logout"))
            //{
                request.getSession().invalidate();
                response.sendRedirect(".");  
            //}
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
