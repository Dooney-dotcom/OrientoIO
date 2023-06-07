package model;

import java.util.ArrayList;
import java.util.List;

public class InformazioniCitta {

    private StudenteUniversitario studente;
    private String tipoAbitazione;
    private float affitto;
    private int valutazioneMezzi;
    private int livelloCulturale;
    private String recensioneCitta;
    private List<LuogoPreferito> listaLuoghiPreferiti;

    //Costruttore
    public InformazioniCitta(){
        this.listaLuoghiPreferiti=new ArrayList<LuogoPreferito>();
    }

    //Getters and Setters
    public void setStudente(StudenteUniversitario s){
        this.studente=s;
    }

    public StudenteUniversitario getStudente(){
        return this.studente;
    }

    public void setTipoAbitazione(String tipo){
        this.tipoAbitazione=tipo;
    }

    public String getTipoAbitazione(){
        return this.tipoAbitazione;
    }

    public void setAffitto(float a){
        this.affitto=a;
    }

    public float getAffitto(){
        return this.affitto;
    }

    public void setValutazioneMezzi(int val){
        this.valutazioneMezzi=val;
    }

    public int getValutazioneMezzi(){
        return this.valutazioneMezzi;
    }

    public void setLivelloCulturale(int val){
        this.livelloCulturale=val;
    }

    public int getLivelloCulturale(){
        return this.livelloCulturale;
    }

    public void setRecensioneCitta(String r){
        this.recensioneCitta=r;
    }

    public String getRecensioneCitta(){
        return this.recensioneCitta;
    }

    public void setListaLuoghiPreferiti(List<LuogoPreferito> l){
        this.listaLuoghiPreferiti=l;
    }

    public List<LuogoPreferito> getListaLuoghiPreferiti(){
        return this.listaLuoghiPreferiti;
    }

    //Metodi
    public boolean aggiungiLuogoPreferito(LuogoPreferito l){
        return this.listaLuoghiPreferiti.add(l);
    }
}