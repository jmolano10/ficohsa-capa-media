(:: pragma bea:global-element-parameter parameter="$pagoRecaudo" element="ns2:pagoRecaudo" location="../../../../Business_Resources/pagoRecaudos/PagoRecaudo/pagoRecaudoTypes.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$consultaDetalleContratoRecaudosResponse" element="ns1:consultaDetalleContratoRecaudosResponse" location="../../../BusinessServices/OSB/ConsultaDetalleContratoRecaudo_v2/xsd/XMLSchema_-1149530574.xsd" ::)
(:: pragma bea:schema-type-parameter parameter="$tELLERType" type="ns4:TELLERType" location="../../../../Business_Resources/pagoRecaudos/Resources/XMLSchema_-258408779.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$serviceResponse" type="ns0:serviceResponse" location="../../../BusinessServices/enrutadorConvenios/xsd/XMLSchema_-1423180259.xsd" ::)
(:: pragma bea:global-element-return element="ns3:InputParameters" location="../../../BusinessServices/armarMensajeRecaudo/xsd/FLINK_OSB_K_RECAUDOS_REF_ONLINE_OSB_ARMAR_MENSAJE.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$consultadeparametroscoreResponse" element="ns4:ConsultadeparametroscoreResponse" location="../../../../Business_Resources/Core/Resources/XMLSchema_1632682327.xsd" ::)

declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/pagoRecaudoTypes";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaDetalleContratoRecaudosTypes";
declare namespace ns3 = "http://xmlns.oracle.com/pcbpel/adapter/db/FLINK/OSB_K_RECAUDOS_REF_ONLINE/OSB_ARMAR_MENSAJE/";
declare namespace ns0 = "http://service.webserviceprovider.transporters.service.frametexx.com/";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/PagoRecaudo/xq/armarMensajeResponseTTIn/";
declare namespace ns4 = "T24WebServicesImpl";

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

declare function xf:pagoRecaudoArmarMensajeResponseTTIn($pagoRecaudo as element(ns2:pagoRecaudo),
    $consultaDetalleContratoRecaudosResponse as element(ns1:consultaDetalleContratoRecaudosResponse),
    $tELLERType as element(),
    $serviceResponse as element(),
    $consultadeparametroscoreResponse as element(ns4:ConsultadeparametroscoreResponse))
    as element(ns3:InputParameters) {
        <ns3:InputParameters>
            <ns3:CODIGO_CONTRATO>{ data($pagoRecaudo/CONTRACT_ID) }</ns3:CODIGO_CONTRATO>
            <ns3:TIPO_OPERACION>2</ns3:TIPO_OPERACION>
            <ns3:TIPO_PARAM>RES</ns3:TIPO_PARAM>
            <ns3:APLICACION>TT</ns3:APLICACION>
            
            (: Se arma arreglo con la información proveniente del Request hecho al proxy :)
            <ns3:INFO>
		            {
	            	for $nodo in get-nodes(remove-node($pagoRecaudo, "ADDITIONAL_INFO"))
	            	return
		                <ns3:DATA>
		                    <ns3:NAME>{ fn:local-name($nodo) }</ns3:NAME>
		                    <ns3:VALUE>{ fn:string($nodo/text()) }</ns3:VALUE>
		                </ns3:DATA>
	            }
	            (: La sección ADDITIONAL_INFO se envía con un consecutivo :)
	            {
	            	for $nodo at $i in (get-nodes($pagoRecaudo/ADDITIONAL_INFO))
	            	return
		                <ns3:DATA>
		                    <ns3:NAME>{ concat(fn:local-name($nodo), '_', $i) }</ns3:NAME>
		                    <ns3:VALUE>{ fn:string($nodo/text()) }</ns3:VALUE>
		                </ns3:DATA>
	            }
            </ns3:INFO>
            
            (: Se arma arreglo con la información de la consulta de detalle de recaudo en T24, la respuesta de pago referenciado y la consulta de parámetros del core :)
            <ns3:INFO_T24>
                {
                    for $nodo in (get-nodes($consultaDetalleContratoRecaudosResponse), get-nodes($tELLERType), get-nodes($consultadeparametroscoreResponse))
                    return
                    	<ns3:DATA>
		                    <ns3:NAME>{ fn:local-name($nodo) }</ns3:NAME>
		                    <ns3:VALUE>{ fn:string($nodo/text()) }</ns3:VALUE>
                        </ns3:DATA>
                }
            </ns3:INFO_T24>
            
            (: Se arma arreglo con la información proveniente del responseData devuelto por Flink. No se tiene encuenta la sección moreParameters :)
            <ns3:INFO_FLINK>
	            {
	            	let $responseData := fn-bea:inlinedXML($serviceResponse/responseData)
	            	
	            	let $data := fn-bea:inlinedXML($responseData)
	            	return
	            		if($data instance of element() ) then (
			            	for $nodo in (get-nodes(remove-node($data, "moreParameters")))
			            	return
				                <ns3:DATA>
				                    <ns3:NAME>{ fn:local-name($nodo) }</ns3:NAME>
				                    <ns3:VALUE>{ fn:string($nodo/text()) }</ns3:VALUE>
				                </ns3:DATA>
						) else (fn:string($data))
	            }
            </ns3:INFO_FLINK>
            
            (: Se arma arreglo con la información proveniente del responseData devuelto por Flink, únicamene se procesa la sección moreParameters :)
            <ns3:INFO_MOREPARAM>
	            {
	            	let $responseData := fn-bea:inlinedXML($serviceResponse/responseData)
	            	
	            	let $data := fn-bea:inlinedXML($responseData)//moreParameters
	            	return
	            		if($data instance of element() ) then (
			            	for $nodo in (get-nodes(remove-node($data, "moreParameters")))
			            	return
			            		if(fn:string($nodo/@fieldName) != "") then (
					                <ns3:DATA>
					                    <ns3:NAME>{ fn:string($nodo/@fieldName) }</ns3:NAME>
					                    <ns3:VALUE>{ fn:string($nodo/text()) }</ns3:VALUE>
					                </ns3:DATA>
								) else ()
						) else ()
	            }
            </ns3:INFO_MOREPARAM>
        </ns3:InputParameters>
};

declare variable $pagoRecaudo as element(ns2:pagoRecaudo) external;
declare variable $consultaDetalleContratoRecaudosResponse as element(ns1:consultaDetalleContratoRecaudosResponse) external;
declare variable $tELLERType as element() external;
declare variable $serviceResponse as element() external;
declare variable $consultadeparametroscoreResponse as element(ns4:ConsultadeparametroscoreResponse) external;

xf:pagoRecaudoArmarMensajeResponseTTIn($pagoRecaudo,
    $consultaDetalleContratoRecaudosResponse,
    $tELLERType,
    $serviceResponse,
    $consultadeparametroscoreResponse)