<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@page import="java.util.*,com.example.film.model.*"%>
<%List<Action> action = (List<Action>)request.getAttribute("action");%>
<%List<Personnage> pers = (List<Personnage>)request.getAttribute("personnage");%>
<%List<Tache> tache = (List<Tache>)request.getAttribute("tache");%>
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
                                    <h4 class="title">Ajouter un action /<a  href="<%= request.getContextPath() %>/ListeTache?id=<%=id%>&div=1"> Revenir a la liste</a></h4>
                                </div>
                                <div class="content">
                                    <form>
                                        <input type="hidden" id="idscene" name="idscene" value="<%=id%>">
                                        <div class="row">
                                            <div class="col-md-5">
                                                <div class="form-group">
                                                    <label>Personnage</label>
                                                    <select id="idpers" name="idpers" class="form-control border-input">
                                                        <%for(Personnage ps : pers){%>
                                                        <option value="<%=ps.getId()%>"><%=ps.getNomPersonnage()%></option>
                                                        <%}%>
                                                    </select>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="row">
                                            <div class="col-md-5">
                                                <div class="form-group">
                                                    <label>Personnage</label>
                                                    <select id="idaction" name="idaction" class="form-control border-input">
                                                        <%for(Action ac: action){%>
                                                        <option value="<%=ac.getId()%>"><%=ac.getNomType()%></option>
                                                        <%}%>
                                                    </select>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="row">
                                            <div class="col-md-5">
                                                <div class="form-group">
                                                    <label>Scène</label>
                                                    <textarea rows="2" type="text" id="dialogue" name="dialogue" class="form-control border-input" placeholder="dialogue"></textarea>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="row">
                                            <div class="col-md-5">
                                                <div class="form-group">
                                                    <label>Debut</label>
                                                    <input rows="2" type="time" id="duree" name="duree" class="form-control border-input" placeholder="duree">
                                                </div>
                                            </div>
                                        </div>

                                        <br>
                                        <div class="text-center">
                                            <button type="submit" onclick={AjouterTache()} class="btn btn-info btn-fill btn-wd">Ajouter</button>
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
                                    <h4 class="title">Details du scène</h4>
                                    <p class="category"><a href="<%= request.getContextPath() %>/ListeTache?id=<%=id%>&div=2">Ajouter d'autres actions</a></p>
                                </div>
                                <div class="content table-responsive table-full-width">
                                    <table class="table table-hover">
                                        <thead>
                                        <th>Scene</th>
                                        <th>Personnage</th>
                                        <th>Action</th>
                                        <th>Dialogue</th>
                                        <th>Duree</th>
                                        </thead>
                                        <tbody>
                                        <%for(Tache t:tache){%>
                                        <tr>
                                            <td><%=t.getScene().getNomScene()%></td>
                                            <td><%=t.getPersonnage().getNomPersonnage()%></td>
                                            <td><%=t.getAction().getNomType()%></td>
                                            <td><%=t.getDescription()%></td>
                                            <td><%=t.getDuree()%></td>
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

      <script>
          function AjouterTache(){
              let formActuStatus = new FormData();
              console.log(document.getElementById("duree").value + ":00");
              formActuStatus.append('idscene', document.getElementById("idscene").value);
              formActuStatus.append('idpers',document.getElementById("idpers").value);
              formActuStatus.append('idaction',document.getElementById("idaction").value);
              formActuStatus.append('description',document.getElementById("dialogue").value);
              formActuStatus.append('duree',document.getElementById("duree").value + ":00");
              fetch('<%=request.getContextPath()%>/NouveauTache', {
                  method: 'POST',
                  body: formActuStatus
              });
          }
      </script>
  </body>
</html>
