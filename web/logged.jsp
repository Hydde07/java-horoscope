
<%@page import="java.io.RandomAccessFile"%>
<%@page import="classes.Usuario"%>
<%@page import="servlets.ControleLogin"%>

<!-- evita o acesso direto sem login -->
<!-- coloque o código abaixo em todos os módulos JSP do seu projeto -->

<% if(!ControleLogin.testaAcesso(request, response))
    response.sendRedirect("."); // volta ao login
%>
<% boolean click = false; %>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="pt-br">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>HOROSCOPO DIARIO DO JACAREZAO</title>
        <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
        <link rel="stylesheet" href="/resources/demos/style.css">
        <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
        <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
        <script>
        $( function() {
          $( "#datepicker" ).datepicker();
        } );
        </script>
    </head>
    <body style="background: RGB(255,255,255); color: black; text-align: center">
        <% Usuario u = (Usuario)session.getAttribute("usuario");
            if(u!=null && u.isLogado()){ %>
        <h1><strong>Horóscopo Diário</strong></h1>
        <form action="logged.jsp" method="POST">
            <p>Data de nascimento: <input type="data" name="data" id="datepicker"></p>
            <input type="submit" id="submito" name = "submito" value="Enviar" onclick="<% click=true; %>">
        </form>
        <h3><a href="ControleLogin?acao=logout">LOGOUT</a></h3>
        <div>
            <% String d = request.getParameter("data");
            RandomAccessFile arq=new RandomAccessFile(request.getServletContext().getRealPath("")+"\\horoscopo.txt","r");
                if(d!=null){
                    int mes = Integer.parseInt(d.substring(0,2));
                    int dia = Integer.parseInt(d.substring(3,5));
                    int diaV = dia+(mes-1)*30;
                    String hor = null;
                    if(diaV >= 21 && diaV <= 49)
                        hor = "Aquário";
                    else if(diaV >= 50 && diaV <= 79)
                        hor = "Peixes";
                    else if(diaV >= 80 && diaV <= 110)
                        hor = "Áries";
                    else if(diaV >= 111 && diaV <= 140)
                        hor = "Touro";
                    else if(diaV >= 141 && diaV <= 171)
                        hor = "Gêmeos";
                    else if(diaV >= 172 && diaV <= 203)
                        hor = "Câncer";
                    else if(diaV >= 204 && diaV <= 234)
                        hor = "Leão";
                    else if(diaV >= 235 && diaV <= 265)
                        hor = "Virgem";
                    else if(diaV >= 266 && diaV <= 295)
                        hor = "Libra";
                    else if(diaV >= 296 && diaV <= 325)
                        hor = "Escorpião";
                    else if(diaV >= 326 && diaV <= 355)
                        hor = "Sagitário";
                    else
                        hor = "Capricórnio";
                    String linha = arq.readLine();
                    while(linha.startsWith(hor))
                        linha = arq.readLine();
                    String text = linha.substring(linha.indexOf("#")+1, linha.length());
                %>
                    <img src= "<%= "SignosImagens\\img_"+hor+".png" %>" >
                    <br>
                    <h1><%=hor%></h1>
                    <%=text%>
            <% }%>
        </div>
        <% } %>
    </body>
</html>
