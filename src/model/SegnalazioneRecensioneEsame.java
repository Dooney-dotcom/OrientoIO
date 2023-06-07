package model;
import java.time.*;

public class SegnalazioneRecensioneEsame {

    private Utente utenteSegnalante;
	private RecensioneEsame recensioneSegnalata;
	
	private String id;
    private LocalDateTime timeStamp;
    private String TestoSegnalazione;
	
	
	public SegnalazioneRecensioneEsame() {

	}

    //GETTERS AND SETTERS
    public Utente getUtenteSegnalante() {
        return utenteSegnalante;
    }
    public void setUtenteSegnalante(Utente utenteSegnalante) {
        this.utenteSegnalante = utenteSegnalante;
    }
    public RecensioneEsame getRecensioneSegnalata() {
        return recensioneSegnalata;
    }
    public void setRecensioneSegnalata(RecensioneEsame recensioneSegnalata) {
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
