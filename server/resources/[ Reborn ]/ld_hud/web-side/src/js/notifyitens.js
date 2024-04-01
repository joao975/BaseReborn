$(document).ready(function(){
	window.addEventListener("message",function(event){
		let html = ""
		const serverDirect = event.data.diretory;
		if (event.data.mode == 'RECEBEU') {
			html = "<div id='showitem'><div class=\"img\"><div class=\"inner\"><img width=\"40\" height=\"40\" src='"+serverDirect+"/"+event.data.item+".png' onerror=`this.onerror=null;this.src='https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSVUlqCtI1EqLkv0Tt2MyIo3qdZgJl9aPsn1Q&usqp=CAU';`></div></div><div class=\"linecontent\"><div class=\"line\"></div><div class=\"circle\"><span>.</span></div><div class=\"line\"></div></div><div class=\"desc\"><p>Recebido</p><br><span style=\"display: block;\"><verde>+"+event.data.numero+"x </verde> "+event.data.mensagem+"</span></div></div>"
		}

		if (event.data.mode == 'REMOVIDO') {
			html = "<div id='showitem'><div class=\"img\"><div class=\"inner\"><img width=\"40\" height=\"40\" src='"+serverDirect+"/"+event.data.item+".png' onerror=`this.onerror=null;this.src='https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSVUlqCtI1EqLkv0Tt2MyIo3qdZgJl9aPsn1Q&usqp=CAU';`></div></div><div class=\"linecontent\"><div class=\"line\"></div><div class=\"circle\"><span>.</span></div><div class=\"line\"></div></div><div class=\"desc\"><p>Removido</p><br><span style=\"display: block;\"><vermelho>-"+event.data.numero+"x </vermelho> "+event.data.mensagem+"</span></div></div>"
		}

		$(html).fadeIn(500).appendTo("#notifyitens").delay(5000).fadeOut(500);
	})
});