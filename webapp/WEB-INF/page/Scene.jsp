<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@page import="java.util.List"%>
<%@page import="com.example.film.model.*"%>
<%List<Plateau> plateau = (List<Plateau>)request.getAttribute("plateau");%>
<%List<Scene> scene = (List<Scene>)request.getAttribute("scene");%>
<%int id = (int)request.getAttribute("id");%>
<%int div = (int) request.getAttribute("div");%>

<!doctype html>
<html lang="en">
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
            <li>
                <a href="<%= request.getContextPath() %>/DetailsIndisponibilite">
                    <i class="ti-line-dashed"></i>
                    <p>Indisponiblité</p>
                </a>
            </li>
        </ul>
    </div>
</div>
<div class="wrapper">
    <div class="main-panel">
        <div class="col-md-12">
            <h3></h3>
        </div>

        <div id="test1">
        <div class="content">
            <div class="container-fluid">
                <div class="row">
                    <div class="col-lg-8 col-md-7">
                        <div class="card">
                            <div class="header">
                                <h4 class="title">Ajouter une scène /<a  href="<%= request.getContextPath() %>/ListScene?id=<%=id%>&div=1"> Revenir a la liste</a></h4>
                            </div>
                            <div class="content">
                                <form action="<%= request.getContextPath() %>/NouveauScene" method="post">
                                    <input type="hidden" value="<%=id%>" name="idfilm">

                                    <div class="row">
                                        <div class="col-md-5">
                                            <div class="form-group">
                                                <label>Auteur</label>
                                                <input rows="2" type="text" name="auteur" class="form-control border-input" placeholder="Auteur"*>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="row">
                                        <div class="col-md-5">
                                            <div class="form-group">
                                                <label>Plateau</label>
                                                <select name = "idplateau" class="form-control border-input">
                                                    <%for(Plateau p: plateau) {%>
                                                    <option value="<%=p.getId()%>"><%=p.getNomPlateau()%></option>
                                                    <%}%>
                                                </select>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="row">
                                        <div class="col-md-5">
                                            <div class="form-group">
                                                <label>Scène</label>
                                                <textarea rows="2" type="text" name="nomScene" class="form-control border-input" placeholder="description"></textarea>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="row">
                                        <div class="col-md-5">
                                            <div class="form-group">
                                                <label>Debut</label>
                                                <input rows="2" type="time" step="1" name="debut" class="form-control border-input" placeholder="description">
                                            </div>
                                        </div>
                                    </div>

                                    <div class="row">
                                        <div class="col-md-5">
                                            <div class="form-group">
                                                <label>Fin</label>
                                                <input rows="2" type="time" step="1" name="fin" class="form-control border-input" placeholder="description">
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
                    </div>
                </div>
            </div>
        </div>
        </div>


        <div id="test2">
            <div class="content">
                <div class="container-fluid">
                    <div class="row">
                        <div class="col-md-12">
                            <div class="card card-plain">
                                <div class="header">
                                    <h4 class="title">les scènes</h4>
                                    <p class="category"><a href="<%= request.getContextPath() %>/ListScene?id=<%=id%>&div=2">Ajouter d'autres scènes</a></p>
                                </div>
                                <br>
                                <br>
                                <h4 class="title">Faire une recherche</h4>
                                <form action="<%= request.getContextPath() %>/Recherche" method="get">
                                <div class="row">
                                    <div class="col-md-3">
                                        <div class="form-group">
                                            <input type="hidden" value="<%=id%>" name="idfilm">
                                            <input type="text" name="scene" class="form-control border-input" placeholder="Scene">
                                        </div>
                                    </div>
                                    <div class="col-md-2" style="margin-left: -31px">
                                        <div class="form-group">
                                            <select name = "idplateau" class="form-control border-input">
                                                <option value="0" selected>Choisir Plateau</option>
                                                <%for(Plateau p: plateau) {%>
                                                <option value="<%=p.getId()%>"><%=p.getNomPlateau()%></option>
                                                <%}%>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="col-md-2">
                                        <div class="form-group">
                                            <input type="submit" class="form-control border-input" value="Rechercher" style="color: #2e6da4">
                                        </div>
                                    </div>
                                </div>
                            </form>

                                <div class="content table-responsive table-full-width">
                                    <table class="table table-hover">
                                        <thead>
                                        <th>Nom scene</th>
                                        <th>Auteur</th>
                                        <th>Plateau</th>
                                        <th>Debut</th>
                                        <th>Fin</th>
                                        <th></th>
                                        </thead>
                                        <tbody>
                                        <%for(Scene s:scene){%>
                                        <tr>
                                            <td><%=s.getNomScene()%></td>
                                            <td><%=s.getAuteur()%></td>
                                            <td><%=s.getPlateau().getNomPlateau()%></td>
                                            <td><%=s.getDebut()%></td>
                                            <td><%=s.getFin()%></td>
                                            <td><a href="ListeTache?id=<%=s.getId()%>&div=1">Voir detail</a></td>
                                        </tr>
                                        <%}%>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>


                    </div>
                </div>
            </div>
        </div>

        <jsp:include page="footer.jsp"/>
    </div>
</div>
</body>
</html>

    <script>
        function cacher() {
            id = <%=div%>;
            var test1 = document.getElementById("test1");
            var test2 = document.getElementById("test2");
            if (id == 1){
                test1.style.display = "none";
            }
            if (id == 2){
                test2.style.display = "none";
            }
        }

        window.onload = function() {
            cacher();
        };
    </script>
