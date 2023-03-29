<%@ page import="com.example.film.model.Scene" %>
<%@ page import="java.util.List" %><%--
  Created by IntelliJ IDEA.
  User: mickl
  Date: 22/03/2023
  Time: 10:49
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%List<Scene> scenes = (List<Scene>)request.getAttribute("liste");%>

<!doctype html>
<html lang="en">
<body>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<body>
<jsp:include page="lien.jsp"/>
<div class="sidebar" data-background-color="white" data-active-color="danger">
    <div class="sidebar-wrapper">
        <div class="logo">
            <a class="simple-text">
                F I L M
            </a>
        </div>

        <ul class="nav">
            <li>
                <a href="<%= request.getContextPath() %>/AddFilm">
                    <i class="ti-plus"></i>
                    <p>Créer un film</p>
                </a>
            </li>
            <li>
                <a href="<%= request.getContextPath() %>/pagination?numero=1">
                    <i class="ti-view-list"></i>
                    <p>Voir la liste</p>
                </a>
            </li>

        </ul>
    </div>
</div>
<div class="wrapper">
    <div class="main-panel">
        <div class="content">
            <div class="container-fluid">
                <div class="header">
                    <h4 class="title">Indisponibilité des plateaux par scène</h4>
                </div>
                <br>
                <br>
                <form method="post" action="<%= request.getContextPath() %>/NouveauIndisponibilite">
                <div class="row">
                    <div class="col-md-5">
                        <div class="form-group">
                            <label>Scene</label>
                            <select name = "idscene" class="form-control border-input">
                                <%for(Scene p:scenes){%>
                                <option value="<%=p.getId()%>"><%=p.getNomScene()%></option>
                                <%}%>
                            </select>
                        </div>
                    </div>
                </div>

                <div class="row">
                    <div class="col-md-5">
                        <div class="form-group">
                            <label>Plateau</label>
                            <select name = "idplateau" class="form-control border-input">
                                <%for(Scene p:scenes){%>
                                <option value="<%=p.getPlateau().getId()%>"><%=p.getPlateau().getNomPlateau()%></option>
                                <%}%>
                            </select>
                        </div>
                    </div>
                </div>

                <div class="row">
                    <div class="col-md-5">
                        <div class="form-group">
                            <label>Debut</label>
                            <input rows="2" type="date" name="dates" class="form-control border-input" placeholder="description">
                        </div>
                    </div>
                </div>
                <br>
                <div class="text-center">
                    <button type="submit" class="btn btn-info btn-fill btn-wd">Ajouter</button>
                </div>
                <div class="clearfix"></div>
                </form>

            </div>
        </div>
        <jsp:include page="footer.jsp"/>
    </div>
</div>
</body>
</html>