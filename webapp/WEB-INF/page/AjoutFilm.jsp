<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%--
  Created by IntelliJ IDEA.
  User: mickl
  Date: 28/02/2023
  Time: 21:37
  To change this template use File | Settings | File Templates.
--%>
<!doctype html>
<html lang="en">
<body>
<jsp:include page="lien.jsp"/>
<div class="sidebar" data-background-color="white" data-active-color="danger" >
    <div class="sidebar-wrapper">
        <div class="logo">
            <a class="simple-text">
                F I L M
            </a>
        </div>
        <ul class="nav">
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
        <div class="content" id="test1">
            <div class="container-fluid">
                <div class="row">
                    <div class="col-lg-8 col-md-7">
                        <div class="card">
                            <div class="header">
                                <h4 class="title">Ajouter un film</h4>
                            </div>
                            <div class="content">
                                <form method="post" action="<%=request.getContextPath()%>/NouveauFilm" enctype="multipart/form-data">
                                    <div class="row">
                                        <div class="col-md-5">
                                            <div class="form-group">
                                                <label>Titre</label>
                                                <input type="text" name="film" class="form-control border-input" placeholder="Titre">
                                            </div>
                                        </div>
                                    </div>

                                    <div class="row">
                                        <div class="col-md-5">
                                            <div class="form-group">
                                                <label>Auteur</label>
                                                <input type="text" name="auteur" class="form-control border-input" placeholder="Auteur">
                                            </div>
                                        </div>
                                    </div>

                                    <div class="row">
                                        <div class="col-md-5">
                                            <div class="form-group">
                                                <label>Image</label>
                                                <input type="file" name="file" class="form-control border-input">
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

        <jsp:include page="footer.jsp"/>
    </div>
</div>

</body>
</html>

