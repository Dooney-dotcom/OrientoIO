/**
 * 
 */
function callback(xhr){
	//verifica dello stato
	if(xhr.readyState===2){
		//e.innerHtml="Richiesta inviata..."
	}else if(xhr.readyState===3){
		//e.innerHtml="Ricezione della risposta..."
	}else if(xhr.readyState===4){
		
		//verifica della risposta del server
		if(xhr.status===200){
			console.log("Restrizione modificata con successo...");
			//OK...
		}
	}
}//callback

function sendIFrame(){
	alert("Il tuo browser non è supportato. Cambia browser e riprova...");
}//IFrame

function sendJson(uri, xhr){
	
	xhr.onreadystatechange=function(){callback(xhr)};
	
	try{
		xhr.open("GET", uri, true);
	}catch(e){
		alert(e);
	}
	xhr.send(null);
}//Ajax

function convalida(uri){
	var xhr=myGetXmlHttpRequest();
	console.log("Inizializzazzione convalida...");
	if(xhr)
		sendJson(uri, xhr);
	else 
		sendIFrame();
}