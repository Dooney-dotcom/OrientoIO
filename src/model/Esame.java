package model;
import java.util.ArrayList;
import java.util.List;

public class Esame {

	private List<RecensioneEsame> recensioni;
	
	private String nome;
	private String SSO;
	private Integer CFU;
	private Integer periodo;
	private Integer anno;
	private String linkEsame;
	
	
	public Esame() {
		this.recensioni = new ArrayList<RecensioneEsame>();
	}
	
	
	//getters and setters
	public List<RecensioneEsame> getRecensioni(){
		return recensioni;
	}
	public void setRecensioni(List<RecensioneEsame> recensioni) {
		this.recensioni = recensioni;
	}
	
	
	
	public String getNome() {
		return nome;
	}
	public void setNome(String nome) {
		this.nome = nome;
	}
	public String getSSO() {
		return SSO;
	}
	public void setSSO(String sSO) {
		SSO = sSO;
	}
	public Integer getCFU() {
		return CFU;
	}
	public void setCFU(Integer cFU) {
		CFU = cFU;
	}
	public Integer getPeriodo() {
		return periodo;
	}
	public void setPeriodo(Integer periodo) {
		this.periodo = periodo;
	}
	public Integer getAnno() {
		return anno;
	}
	public void setAnno(Integer anno) {
		this.anno = anno;
	}
	public String getLinkEsame() {
		return linkEsame;
	}
	public void setLinkEsame(String linkEsame) {
		this.linkEsame = linkEsame;
	}
	
	

	//metodi
	public void recensisciEsame(RecensioneEsame recensioneEsame) {
		this.recensioni.add(recensioneEsame);
	}


	
}
