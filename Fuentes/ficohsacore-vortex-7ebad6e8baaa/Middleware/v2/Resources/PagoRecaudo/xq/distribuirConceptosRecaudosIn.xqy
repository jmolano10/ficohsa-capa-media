xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$pagoRecaudo" element="ns2:pagoRecaudo" location="../../../../Business_Resources/pagoRecaudos/PagoRecaudo/pagoRecaudoTypes.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$serviceResponse" type="ns0:serviceResponse" location="../../../BusinessServices/enrutadorConvenios/xsd/XMLSchema_-1423180259.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../BusinessServices/distribucionConceptosRecaudos/xsd/FLINK_OSB_K_DISTR_CPTOS_RECAUDOS_OSB_DISTRIBUIR_CONCEPTOS.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$consultadeparametroscoreResponse" element="ns3:ConsultadeparametroscoreResponse" location="../../../../Business_Resources/Core/Resources/XMLSchema_1632682327.xsd" ::)


declare namespace ns3 = "T24WebServicesImpl";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/pagoRecaudoTypes";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/FLINK/OSB_K_DISTR_CPTOS_RECAUDOS/OSB_DISTRIBUIR_CONCEPTOS/";
declare namespace ns0 = "http://service.webserviceprovider.transporters.service.frametexx.com/";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/PagoRecaudo/xq/distribuirConceptosRecaudosIn/";

(: Función recursiva que retorna todos los nodos de $root. :) 
declare function get-nodes($root as element()?) as element()* {
	for $child in $root/*
	return
		if(not($child/text() [normalize-space(.) != '']) and $child/*) then (
			 get-nodes($child)
			
		) else (
			$child
		)	
};

(: Devuelve el nodo de entrada sin el elemento a borrar :)
declare function remove-node($elements as element()*,
	$name as xs:string*) as element()* {
	
	for $element in $elements
	return
		element
			{node-name($element)}
			{$element/@*,
			 $element/node()[not(name()=$name)]}
};


declare function xf:distribuirConceptosRecaudosIn($pagoRecaudo as element(ns2:pagoRecaudo),
			$serviceResponse as element(),
			$transactionId as xs:string,
    		$consultadeparametroscoreResponse as element(ns3:ConsultadeparametroscoreResponse))
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            <ns1:CODIGO_CONTRATO>{ data($pagoRecaudo/CONTRACT_ID) }</ns1:CODIGO_CONTRATO>
			<ns1:CODIGO_DEUDOR>{ data($pagoRecaudo/DEBTOR_CODE) }</ns1:CODIGO_DEUDOR>
			<ns1:ID_TRANSACCION>{ $transactionId }</ns1:ID_TRANSACCION>
			<ns1:MONEDA_PAGO>{ data($pagoRecaudo/PAYMENT_INFORMATION/PAYMENT_CURRENCY) }</ns1:MONEDA_PAGO>
			<ns1:MONTO_PAGO>{ data($pagoRecaudo/PAYMENT_INFORMATION/PAYMENT_AMOUNT) }</ns1:MONTO_PAGO>
			<ns1:TASA_COMPRA>{ data($consultadeparametroscoreResponse/WSCOREPARAMETERSType[1]/gWSCOREPARAMETERSDetailType/mWSCOREPARAMETERSDetailType[1]/BUYRATE) }</ns1:TASA_COMPRA>
			<ns1:TASA_VENTA>{ data($consultadeparametroscoreResponse/WSCOREPARAMETERSType[1]/gWSCOREPARAMETERSDetailType/mWSCOREPARAMETERSDetailType[1]/SELLRATE) }</ns1:TASA_VENTA>
			
			(: Se arma arreglo con la información proveniente del responseData devuelto por Flink. No se tiene encuenta la sección moreParameters :)
            <ns1:INFO_FLINK>
	            {
	            	let $responseData := 
	            		if (fn:contains($serviceResponse/responseData, '?>')) then  (
	            			fn:substring-after($serviceResponse/responseData, '?>')
	            		) else (
	            			fn:string($serviceResponse/responseData/text())
		            	)
	            	let $data := fn-bea:inlinedXML($responseData)
	            	return
	            		if($data instance of element() ) then (
			            	for $nodo in (get-nodes(remove-node($data, "moreParameters")))
			            	return
				                <ns1:DATA>
				                    <ns1:NAME>{ fn:local-name($nodo) }</ns1:NAME>
				                    <ns1:VALUE>{ fn:string($nodo/text()) }</ns1:VALUE>
				                </ns1:DATA>
						) else (fn:string($data))
	            }
            </ns1:INFO_FLINK>
            
            (: Se arma arreglo con la información proveniente del responseData devuelto por Flink, únicamene se procesa la sección moreParameters :)
            <ns1:INFO_MOREPARAM>
	            {
	            	let $responseData := 
	            		if (fn:contains($serviceResponse/responseData, '?>')) then  (
	            			fn:substring-after($serviceResponse/responseData, '?>')
	            		) else (
	            			fn:string($serviceResponse/responseData/text())
		            	)
	            	let $data := fn-bea:inlinedXML($responseData)//moreParameters
	            	return
	            		if($data instance of element() ) then (
			            	for $nodo in (get-nodes(remove-node($data, "moreParameters")))
			            	return
			            		if(fn:string($nodo/@fieldName) != "") then (
					                <ns1:DATA>
					                    <ns1:NAME>{ fn:string($nodo/@fieldName) }</ns1:NAME>
					                    <ns1:VALUE>{ fn:string($nodo/text()) }</ns1:VALUE>
					                </ns1:DATA>
								) else ()
						) else ()
	            }
            </ns1:INFO_MOREPARAM>
        </ns1:InputParameters>

};

declare variable $pagoRecaudo as element(ns2:pagoRecaudo) external;
declare variable $serviceResponse as element() external;
declare variable $transactionId as xs:string external;
declare variable $consultadeparametroscoreResponse as element(ns3:ConsultadeparametroscoreResponse) external;

xf:distribuirConceptosRecaudosIn($pagoRecaudo, 
	$serviceResponse, 
	$transactionId, 
	$consultadeparametroscoreResponse)