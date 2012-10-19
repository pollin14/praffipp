// JavaScript Document
function currency_old(value, decimals, separators) {
	/*
El primer parámetro debe ser un número (cualquier valor inválido regresa “0.00″). Este es el único parámetro obligatorio.

El segundo parámetro es el número de decimales (por defecto 2) y el tercero es un arreglo con los separadores en este orden: Separador de miles, separador de millones, separador de decimales. Por defecto es ['.', "'", ','] que es el que se usa en Colombia.

Algunos ejemplos:

currency(NaN); // "0.00"
currency(0); // "0.00"
currency(123456567.89); // "123'456.567,89"
currency(-123456567.89); // "-123'456.567,89"
currency(1234.56, 1); // "1.234,5"
currency(1234.56, 1, [',', "'", '.']); // "1,234.5"

*/
	//signo=(value.slice(0,1)=="-" ? "-":"");
	decimals = decimals >= 0 ? parseInt(decimals, 0) : 2;
	separators = separators || ['.', ",", ','];
	var number = (parseFloat(value) || 0).toFixed(decimals);
	if (number.length <= (3 + decimals))
		return number.replace('.', separators[separators.length - 1]);
	var parts = number.split(/[-.]/);
	value = parts[parts.length > 1 ? parts.length - 2 : 0];
	var result = value.substr(value.length - 3, 3) + (parts.length > 1 ?
		separators[separators.length - 1] + parts[parts.length - 1] : '');
	var start = value.length - 6;
	var idx = 0;
	while (start > -3) {
		result = (start > 0 ? value.substr(start, 3) : value.substr(0, 3 + start))
		+ separators[idx] + result;
		idx = (++idx) % 2;
		start -= 3;
	}
	return (parts.length == 3 ? '-' : '') + result;
//return signo+result;
}

function currency(num,prefix){
	prefix = prefix || '';
	negativo = num<0;
	num += '';
	var splitStr = num.split('.');
	var splitLeft = splitStr[0];
	var splitRight = splitStr.length > 1 ? '.' + splitStr[1] : '';
	var regx = /(\d+)(\d{3})/;
	while (regx.test(splitLeft)) {
		splitLeft = splitLeft.replace(regx, '$1' + ',' + '$2');
	}
	formateado = prefix + splitLeft + splitRight;
	if (negativo) {
		formateado="-"+formateado;
	}
	return formateado;
}

function davalor(n){
	if (n==""){
		return 0;
	}
	else {
		n=n.replace(/'/g,"");
		n=n.replace(/,/g,"");
		return parseFloat(n);
	}
}

function suma(rf,pf,orf){
	rf=davalor(rf);
	pf=davalor(pf);
	orf=davalor(orf);
	return rf+pf+orf;
}

function dif(rf,pf,orf){
	rf=davalor(rf);
	pf=davalor(pf);
	orf=davalor(orf);
	return rf+pf-orf;
}

/*
 * 
 * @param num_cols numero de columnas que se leeran
 * @param nom_form nombre del form
 * @param rubro fila o rubro sobre el cual se sumara. Default = 5
 * @param limite si es true se lanza el evento onchange de la ultima columna.
 */
function suma_horizontal(nom_form,rubro,num_cols,limite){
	num_cols = (typeof num_cols === 'undefined')? 5: num_cols;
	limite = (typeof limite === 'undefined')? false:limite;
	
	var form = document.forms[nom_form];
	var si=0;
	for(var i=1; i<num_cols ;i++){
		si+= davalor(form.elements[rubro +i].value);
	}
	form.elements[rubro+num_cols].value = currency(si);		
	
	if (limite){
		var last_column =form.elements[rubro+num_cols];
		last_column.onchange(); // forzamos el evento onchange del ultimo elemento.
	}
}

/*
 *df = Disponibilidad financiera.
 */

function df_calc(trim,nom_form,idx,gpo){
	var form = document.forms[nom_form];
	
	var ti = form.elements[gpo+"ti"+trim].value;
	var te = form.elements[gpo+"te"+trim].value;
	var si = form.elements["r"+idx+"_"+trim].value;
	
	//form.elements[gpo+"df"+trim].value=0;
	//alert(trim + " - " +idx + " - " + gpo)() //2-1-e
	form.elements[gpo+"df"+trim].value=dif(si,ti,te);
		//  form.elements[gpo+"df"+trim].value=currency(form.elements[gpo+"df"+trim].value, 0, [',', ",", '.']);
		//  form.elements["r"+idx+"_"+trim].value=currency(davalor(form.elements["r"+idx+"_"+trim].value), 0, [',', ",", '.']);
	form.elements[gpo+"df"+trim].value = currency(form.elements[gpo+"df"+trim].value);
	form.elements["r"+idx+"_"+trim].value = currency(davalor(form.elements["r"+idx+"_"+trim].value));
}

/*
 * ti = total de ingresos
 */
function ti_calc(x,Nom_Form,idx,gpo){
	var form = document.forms[Nom_Form];
	idx=idx-1;
	form.elements[gpo+"ti"+x].value=0;
	form.elements[gpo+"ti"+x].value=
	suma(form.elements["r"+(idx+2)+"_"+x].value,
		form.elements["r"+(idx+3)+"_"+x].value,
		form.elements["r"+(idx+4)+"_"+x].value);
	suma_horizontal(Nom_Form,"r"+(idx+2)+"_");
	suma_horizontal(Nom_Form,"r"+(idx+3)+"_");
	suma_horizontal(Nom_Form,"r"+(idx+4)+"_");
	suma_horizontal(Nom_Form,gpo+"ti");
	df_calc(x,Nom_Form,(idx+1),gpo);
	//alert(gpo +"df");
	suma_horizontal(Nom_Form,gpo+"df",4);
	//  form.elements[gpo+"ti"+x].value=currency(form.elements[gpo+"ti"+x].value, 0, [',', ",", '.']);
	//  form.elements["r"+(idx+2)+"_"+x].value=currency(davalor(form.elements["r"+(idx+2)+"_"+x].value), 0, [',', ",", '.']);
	//  form.elements["r"+(idx+3)+"_"+x].value=currency(davalor(form.elements["r"+(idx+3)+"_"+x].value), 0, [',', ",", '.']);
	//  form.elements["r"+(idx+4)+"_"+x].value=currency(davalor(form.elements["r"+(idx+4)+"_"+x].value), 0, [',', ",", '.']);

	form.elements[gpo+"ti"+x].value=currency(davalor(form.elements[gpo+"ti"+x].value));
	form.elements["r"+(idx+2)+"_"+x].value=currency(davalor(form.elements["r"+(idx+2)+"_"+x].value));
	form.elements["r"+(idx+3)+"_"+x].value=currency(davalor(form.elements["r"+(idx+3)+"_"+x].value));
	form.elements["r"+(idx+4)+"_"+x].value=currency(davalor(form.elements["r"+(idx+4)+"_"+x].value));
}

/*
 * Suma todos los egresos de la columna del trimestre actual y el resultado
 * lo muestra en el campo TETE (Total de Egresos para el Trimestre Elegido).
 * Ademas suma el total de cada trimestre por rubro y lo muestra el
 * AC (Acumulado del ejercicio).
 * 
 * Descripcion del funcionamiento viejo:
 * Obtenemos todos los campos capturados del trimestre actual y actualiza
 * el valor del TETE correspondiente con la suma de estos.
 * 
 * Descripcion del funcionamiento nuevo:
 * Suma todos los egresos de la columna del trimestre acual o elegido, pero
 * solo aquellos que son editables, es decir, aquellos que no tiene definida la
 * proiedad readyonly, y muestra el resultado en TETE
 * 
 * @param nom_form nombre del fomulario sobre el cual se realizara el calculo.
 * @param idx
 * @param gpo grupo
 * @param e
 * @param trim trim actual
 * @param input_this el objeto (input) que llamo a la funcion.
 */

function te_calc(trim,nom_form,idx,gpo,e,input_this){
	
	var form = document.forms[nom_form];
	var tete = form.elements[gpo + "te" + trim ];
	
	var fin=e+idx+5;
	var egresos = 0;
	var contenedor = null;
	var egresos_del_sub = 0;
  
	for (var i=idx+4; i<fin;i++){
		var rubro ="r"+ i +"_"+trim;
		if ( ! form.elements[rubro].getAttribute('readonly') ){
			egresos += davalor(form.elements[rubro].value);
			egresos_del_sub += davalor(form.elements[rubro].value);
			if(contenedor != null){//no tiene hijos
				contenedor.value = egresos_del_sub;
			}
		}else{
			contenedor = form.elements[rubro];
			egresos_del_sub = 0;
		}
	}
	//Actualizamos el AE del rubro que se modifico.
	//Ademas verificamos el limite de egresos de cada rubron en su
	//ultima columna (parametro true). Este limite es pasado en tiempo
	//de compilacion en coldfusion.
	var tmp = input_this.name.substr(0, input_this.name.length -1);
	suma_horizontal(nom_form,tmp,5,true);
	
	tete.value = currency(egresos);
	
	//	alert(rubro);
	//	form.elements[rubro].value = currency(davalor(form.elements[rubro].value));
	
	df_calc(trim,nom_form,idx,gpo);
	//modificamos el SI (saldo inicial)
	suma_horizontal(nom_form,"r"+idx+"_",5);
//	suma_horizontal(nom_form,gpo+"df",4);
	suma_horizontal(nom_form,gpo+"te",5);
}

/*
 * @param limite maximo o minimo de los egresos de un rebro.
 * @param f_comp una funcion que recibe dos parametros donde 
 * el primero de ellos es el umbral y el segundo es el valor actual del
 * campo del Acumulado del Rubro. Esta debera regresar false, cuando
 * se quiera indicar un error.
 * @param este el objeto que mando a llamar la funcion (onchange)
 */
function limite(limite,f_comp,este){
	if( f_comp(limite,este.value)){
		este.setAttribute('class', 'suma resaltar')
	}else{
		este.setAttribute('class','suma')
	}
}

function HideShow(NomDiv,NomButton){
	if (document.getElementById(NomDiv).style.display == 'block'){
		document.getElementById(NomDiv).style.display = 'none'; 
		document.getElementById(NomButton).style.backgroundImage = '';
	}
	else {
		document.getElementById(NomDiv).style.display = 'block';
		document.getElementById(NomButton).style.backgroundImage = 'url(img/bgcolfooter.jpg)';
	}
}

function HideShow_Asig(){
	HideShow('Asignaciones','Btn_Asig');
}
function HideShow_Trans(){
	HideShow('Transferencias','Btn_Trans');
}
function HideShow_Movs(){
	HideShow('Movimientos','Btn_Movs');
}

function HideShow_Foro(){
	HideShow('Foro','Btn_Foro');
}

function HideShow_Cargar(){
	HideShow('Cargar','Btn_Cargar');
}
function HideShow_Pror(){
	HideShow('Prorroga','Btn_Pror');
}
function HideShow_UpLoad(){
	HideShow('UpLoad','Btn_UpLoad');
}
function HideShow_Calif(){
	HideShow('Dictaminar','Btn_Calif');
}
function HideShow_Administracion(){
	HideShow('Administracion','Btn_Administracion');
}

