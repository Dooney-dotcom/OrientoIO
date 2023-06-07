package model;
import java.time.*;

public class SegnalazioneRecensioneCorso {

    private Utente utenteSegnalante;
	private RecensioneCorso recensioneSegnalata;
	
	private String id;
    private LocalDateTime timeStamp;
    private String TestoSegnalazione;
	
	
	public SegnalazioneRecensioneCorso() {

	}

    //GETTERS AND SETTERS
    public Utente getUtenteSegnalante() {
        return utenteSegnalante;
    }
    public void setUtenteSegnalante(Utente utenteSegnalante) {
        this.utenteSegnalante = utenteSegnalante;
    }
    public RecensioneCorso getRecensioneSegnalata() {
        return recensioneSegnalata;
    }
    public void setRecensioneSegnalata(RecensioneCorso recensioneSegnalata) {
        this.recensioneSegnalata = recensioneSegnalata;
    }



    public String getId() {
        return id;
    }
    public void setId(String id) {
        this.id = id;
    }
    public LocalDateTime getTimeStamp() {
        return timeStamp;
    }
    public void setTimeStamp(LocalDateTime timeStamp) {
        this.timeStamp = timeStamp;
    }
    public String getTestoSegnalazione() {
        return TestoSegnalazione;
    }
    public void setTestoSegnalazione(String testoSegnalazione) {
        TestoSegnalazione = testoSegnalazione;
    }

}
