package model;

public class LuogoPreferito {
    
    private String nomeLuogo;
    private String indirizzo;

    //Costruttore
    public LuogoPreferito(){}

    //Getters and Setters
    public void setNomeLuogo(String nomeLuogo){
        this.nomeLuogo=nomeLuogo;
    }

    public String getNomeLuogo(){
        return this.nomeLuogo;
    }

    public void setIndirizzo(String indirizzo){
        this.indirizzo=indirizzo;
    }

    public String getIndirizzo(){
        return this.indirizzo;
    }
}