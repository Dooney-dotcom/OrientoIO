package model;

import java.time.*;

public class Restrizione {

    private LocalDateTime scadenza;
    private TipoRestrizione tipoRestrizione;

    //Costruttore
    public Restrizione(){

    }

    //Getters and Setters
    public LocalDateTime getScadenza(){
        return this.scadenza;
    }
    public void setScadenza(LocalDateTime scadenza){
        this.scadenza = scadenza;
    }
    public TipoRestrizione getTipoRestrizione(){
        return this.tipoRestrizione;
    }
    public void setTipoRestrizione(TipoRestrizione tipoRestrizione){
        this.tipoRestrizione=tipoRestrizione;
    }
}