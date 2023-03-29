
package com.example.film.dao;

import com.example.film.model.Film;
import com.example.film.model.Personnage;
import com.example.film.model.Plateau;
import org.hibernate.*;
import org.hibernate.criterion.Example;
import org.hibernate.criterion.Order;
import java.io.Serializable;
import java.time.LocalTime;
import java.util.HashMap;
import java.util.List;

import org.hibernate.criterion.MatchMode;
import org.hibernate.criterion.Restrictions;
import org.hibernate.query.Query;

public class HibernateDAO {

    private SessionFactory sessionFactory;


    public void addSceneValider(int idFilm, int idScene, String daty){
        Session session = null;
        Transaction transaction = null;
        try {
            session = sessionFactory.openSession();
            transaction = session.beginTransaction();
            String sql = "insert into FilmValider (idFilm, idScene, daty) values (:idFilm, :idScene, DATE (:daty))";
            Query query = session.createNativeQuery(sql);
            query.setParameter("idFilm", idFilm);
            query.setParameter("idScene", idScene);
            query.setParameter("daty", daty);
            query.executeUpdate();
            session.getTransaction().commit();
        }catch (HibernateException e){
            e.printStackTrace();
        }
    }

    public List<Personnage> GetAllPerso(int id){
        Session session = sessionFactory.openSession();
        String sql = "select distinct p.nom from scene join tache t on scene.idscene = t.idscene join personnage p on t.idpers = p.idpers where idfilm="+id;
        Query query = session.createSQLQuery(sql);
        List<Personnage> ans = query.getResultList();
        return ans;
    }

    public List<Plateau> GetAllPlateau(int id){
        Session session = sessionFactory.openSession();
        String sql = "select distinct p.nom_plateau from scene join plateau p on p.idplateau = scene.idplateau where idfilm="+id;
        Query query = session.createSQLQuery(sql);
        List<Plateau> ans = query.getResultList();
        return ans;
    }

    public void AddIndispoPerso(int idPerso, String debut, String fin){
        Session session = null;
        Transaction transaction = null;
        try {
            session = sessionFactory.openSession();
            transaction = session.beginTransaction();
            String sql = "insert into IndispoPerso (idperso,debut,fin) values (:idperso, DATE(:debut), DATE(:fin))";
            Query query = session.createNativeQuery(sql);
            query.setParameter("idperso", idPerso);
            query.setParameter("debut", debut);
            query.setParameter("fin", fin);
            query.executeUpdate();
            session.getTransaction().commit();
        }catch (HibernateException e){
            e.printStackTrace();
        }
    }

    public void AddIndispoPlateau(int idPlateau, String debut, String fin){
        Session session = null;
        Transaction transaction = null;
        try {
            session = sessionFactory.openSession();
            transaction = session.beginTransaction();
            String sql = "insert into IndispoPlateau (idplateau,debut,fin) values (:idplateau, DATE(:debut), DATE(:fin))";
            Query query = session.createNativeQuery(sql);
            query.setParameter("idplateau", idPlateau);
            query.setParameter("debut", debut);
            query.setParameter("fin", fin);
            query.executeUpdate();
            session.getTransaction().commit();
        }catch (HibernateException e){
            e.printStackTrace();
        }
    }

    public List<Film> pagination(int page, int size) {
        Session session = sessionFactory.openSession();
        session.beginTransaction();
        Query<Film> query = session.createQuery("from Film", Film.class);
        query.setFirstResult((page - 1) * size);
        query.setMaxResults(size);
        List<Film> events = query.getResultList();
        session.getTransaction().commit();
        session.close();
        return events;
    }

    public <T> T create(T entity) {
        Session session = sessionFactory.openSession();
        Transaction transaction = session.beginTransaction();
        session.saveOrUpdate(entity);
        transaction.commit();
        session.close();
        return entity;
    }
    public<T> List<T> findQuery(Class<T> tClass,String query){
        Session session = sessionFactory.openSession();
        List<T> results = session.createNativeQuery(query,tClass).list();
        session.close();
        return results;
    }

    public <T> T findById(Class<T> clazz, Serializable id) {
        Session session = sessionFactory.openSession();
        T entity = (T) session.get(clazz, id);
        session.close();
        return entity;
    }

    public <T> List<T> findAll(Class<T> tClass) {
        Session session = sessionFactory.openSession();
        List<T> results = session.createCriteria(tClass).list();
        session.close();
        return results;
    }

    public <T> List<T> findWhere(T entity) {
        Session session = sessionFactory.openSession();
        Example example = Example.create(entity).ignoreCase();
        List<T> results = session.createCriteria(entity.getClass()).add(example).list();
        session.close();
        return results;
    }

    public <T> List<T> recherche(T entity,String mot){
        Session session= null;
        List<T> list = null;
        try{
            session = this.sessionFactory.openSession();
            list = session.createCriteria(entity.getClass())
                    .add(
                            Restrictions.or(
                                    Restrictions.ilike("titre",mot, MatchMode.ANYWHERE),
                                    Restrictions.ilike("body",mot,MatchMode.ANYWHERE)
                            )
                    ).list();
        }catch (Exception e){e.printStackTrace();}
        return list;
    }

    public <T> List<T> findField(Class<T> tClass, String field, String value) {
        Session session = sessionFactory.openSession();
        Criteria crit = session.createCriteria(tClass);
        crit.add(Restrictions.eq(field, value));
        List<T> results = crit.list();
        return results;
    }

    public <T> List<T> findField(Class<T> tClass, String field, Integer value) {
        Session session = sessionFactory.openSession();
        Criteria crit = session.createCriteria(tClass);
        crit.add(Restrictions.eq(field, value));
        List<T> results = crit.list();
        return results;
    }

    public <T> List<T> paginateWhere(T entity, int offset, int size) {
        Session session = sessionFactory.openSession();
        Example example = Example.create(entity).ignoreCase();
        List<T> results = session.createCriteria(entity.getClass())
            .add(example)
            .setFirstResult(offset)
            .setMaxResults(offset + size).list();
        session.close();
        return results;
    }

    public <T> List<T> paginate(Class<T> clazz, int offset, int size) {
        Session session = sessionFactory.openSession();
        List<T> results = session.createCriteria(clazz)
            .setFirstResult(offset)
            .setMaxResults(offset + size).list();
        session.close();
        return results;
    }

    public <T> List<T> paginate(Class<T> clazz, int offset, int size, String orderBy, boolean orderAsc) {
        Session session = sessionFactory.openSession();
        Order order = (orderAsc) ? Order.asc(orderBy) : Order.desc(orderBy);
        List<T> results = session.createCriteria(clazz)
            .addOrder(order)
            .setFirstResult(offset)
            .setMaxResults(offset + size).list();
        session.close();
        return results;
    }

    public void deleteById(Class tClass, Serializable id) {
        delete(findById(tClass, id));
    }

    public void delete(Object entity) {
        Session session = sessionFactory.openSession();
        Transaction transaction = session.beginTransaction();
        session.delete(entity);
        transaction.commit();
        session.close();
    }

    public <T> T update(T entity) {
        Session session = sessionFactory.openSession();
        Transaction transaction = session.beginTransaction();
        session.saveOrUpdate(entity);
        transaction.commit();
        session.close();
        return entity;
    }

    public SessionFactory getSessionFactory() {
        return sessionFactory;
    }

    public void setSessionFactory(SessionFactory sessionFactory) {
        this.sessionFactory = sessionFactory;
    }

}
