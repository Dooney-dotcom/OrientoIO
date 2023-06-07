package model;
import java.util.ArrayList;
import java.util.List;

public class StudenteUniversitario extends Utente{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private int id;
	private PianoFormativo pianoFormativo;
	private List<RecensioneEsame> recensioniEsami;
	private RecensioneCorso recensioneCorso;
	private InformazioniCitta infoCitta;
	private CittaUniversitaria citta;
	private Restrizione restrizione;
	private Libretto libretto;
	
	
	public StudenteUniversitario() {
		super();
		this.recensioniEsami = new ArrayList<RecensioneEsame>();
		
	}

	
	public int getId() {
		return id;
	}


	public void setId(int id) {
		this.id = id;
	}


	public PianoFormativo getPianoFormativo() {
		return pianoFormativo;
	}
	public void setPianoFormativo(PianoFormativo pianoFormativo) {
		this.pianoFormativo = pianoFormativo;
	}
	public List<RecensioneEsame> getRecensioniEsami(){
		return this.recensioniEsami;
	}
	public void setRecensioniEsami(List<RecensioneEsame> recensioniEsami){
		this.recensioniEsami = recensioniEsami;
	}
	public RecensioneCorso getRecensioneCorso(){
		return this.recensioneCorso;
	}
	public void setRecensioneCorso(RecensioneCorso recensioneCorso){
		this.recensioneCorso = recensioneCorso;
	}
	public void setInfoCitta(InformazioniCitta i){
		this.infoCitta=i;
	}
	public InformazioniCitta getInfoCitta(){
		return this.infoCitta;
	}
	public void setCitta(CittaUniversitaria c){
		this.citta=c;
	}
	public CittaUniversitaria getCitta(){
		return this.citta;
	}
	public void setRestrizione(Restrizione restrizione){
		this.restrizione=restrizione;
	}
	public Restrizione getRestrizione(){
		return this.restrizione;
	}



	public Libretto getLibretto() {
		return libretto;
	}



	public void setLibretto(Libretto libretto) {
		this.libretto = libretto;
	}
}
