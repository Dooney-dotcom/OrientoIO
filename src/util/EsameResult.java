package util;

public class EsameResult {
	private String nome;
	private String SSD;
	private Integer CFU;
	private Integer periodo;
	private Integer anno;
	private String linkEsame;
	
	//getters and setters
	
	public String getNome() {
		return nome;
	}
	public void setNome(String nome) {
		this.nome = nome;
	}
	public String getSSD() {
		return SSD;
	}
	public void setSSD(String sSO) {
		SSD = sSO;
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
	@Override
	public String toString() {
		return "EsameResult [nome=" + nome + ", SSD=" + SSD + ", CFU=" + CFU + ", periodo=" + periodo + ", anno=" + anno
				+ ", linkEsame=" + linkEsame + "]";
	}
	
	
}
