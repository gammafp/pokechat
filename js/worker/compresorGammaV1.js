self.addEventListener('message', function(e) {

	var salida = '';
	if(e.data.tipo === 'comprime') {
		salida = compresorGamma.comprimir(e.data.datos);
	} else {
		salida = compresorGamma.decomprimir(e.data.datos);
	}
	// Retorno
	self.postMessage(salida); 
}, false);

// Funcion de compresion

var compresorGamma = (function() {
	this._separadores = ["|", "-"]; // Compartido
	
	function comprimir(cadena) {
		var arreglo = cadena.split(''); 
		var buscar = ["A", "/"]; 
		var indices = [];
		var salida = '';
		for(var bus = 0; bus < buscar.length; bus++) {
			
			for(var i = 0; i < arreglo.length; i++) {
					// Comparará si cohincide con la letra buscada
					if(buscar[bus] == arreglo[i]) {
						indices.push(i);
					} else {
						// Comparará si solo hay una igualdad y si la hay pues no la cuenta y se guarda
						if(indices.length === 1) {
							salida += arreglo[indices[indices.length - 1]];
							indices = [];
						} else if(indices.length >= 2){
							// Si hay mas de dos igualdades las contará y separará
							salida +=  this._separadores[0] + buscar[bus] + '-' + indices.length + this._separadores[0];
				
							indices = [];
						} 
							// Si se rompe la igualdad se guarda la letra que no es igual
							salida += arreglo[i];
							indices = [];
					}
			}	

			arreglo = salida;
			salida = '';
		}
		return arreglo;
	}

	function decomprimir(cadena) {
		if(cadena != undefined) {
			var arreglo = cadena.split(this._separadores[0]);
			var arregloDos = [];
			var salida = '';
			// Usa los separadores para separarlos por arrays
			for(var i = 0; i < arreglo.length; i++) {
				arregloDos.push(arreglo[i].split(this._separadores[1]));
			}
			// Usa el segundo separador para contar las letras iguales procurando que no existan otras letras
			for(var x = 0; x < arregloDos.length; x++) {
				if(arregloDos[x][1] >= 1) {
					for( var y = 0; y < arregloDos[x][1]; y++) {
						salida += arregloDos[x][0];
					}
				} else {
					salida += arregloDos[x][0];
				}
			}
			return(salida);
		}
		return true;		
	}
	
	return {
		decomprimir: function(string) {
			return decomprimir(string);
		},
		comprimir: function(string) {
			return comprimir(string);
		}
	}
	
})();