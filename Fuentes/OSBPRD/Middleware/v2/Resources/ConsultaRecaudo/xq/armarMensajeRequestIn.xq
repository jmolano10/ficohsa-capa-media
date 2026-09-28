(:: pragma bea:global-element-parameter parameter="$RequestHeader" element="ns4:RequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$consultaRecaudo" element="ns1:consultaRecaudo" location="../../../../Business_Resources/recaudos/consultaRecaudo/consultaRecaudoTypes.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$consultaDetalleContratoRecaudosResponse" element="ns0:consultaDetalleContratoRecaudosResponse" location="../../../BusinessServices/OSB/ConsultaDetalleContratoRecaudo_v2/xsd/XMLSchema_-1149530574.xsd" ::)
(:: pragma bea:global-element-return element="ns3:InputParameters" location="../../../BusinessServices/armarMensajeRecaudo/xsd/FLINK_OSB_K_RECAUDOS_REF_ONLINE_OSB_ARMAR_MENSAJE.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$consultadeparametroscoreResponse" element="ns2:ConsultadeparametroscoreResponse" location="../../../../Business_Resources/Core/Resources/XMLSchema_1632682327.xsd" ::)

declare namespace ns4 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns3 = "http://xmlns.oracle.com/pcbpel/adapter/db/FLINK/OSB_K_RECAUDOS_REF_ONLINE/OSB_ARMAR_MENSAJE/";
declare namespace ns2 = "T24WebServicesImpl";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaRecaudoTypes";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaDetalleContratoRecaudosTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaRecaudo/armarMensajeRequestIn/";

(: Función recursiva que retorna todos los nodos de $root. :) 
declare function get-nodes($root as element()?) as element()* {
	for $child in $root/*
	return
		if( not($child/text() [normalize-space(.) != '']) and $child/*) then (
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

declare function xf:consultaRecaudoArmarMensajeRequestIn($RequestHeader as element(ns4:RequestHeader),
    $consultaRecaudo as element(ns1:consultaRecaudo),
    $consultaDetalleContratoRecaudosResponse as element(ns0:consultaDetalleContratoRecaudosResponse),
    $consultadeparametroscoreResponse as element(ns2:ConsultadeparametroscoreResponse))
    as element(ns3:InputParameters) {
        <ns3:InputParameters>
            <ns3:CODIGO_CONTRATO>{ data($consultaRecaudo/CONTRACT_ID) }</ns3:CODIGO_CONTRATO>
            <ns3:TIPO_OPERACION>1</ns3:TIPO_OPERACION>
            <ns3:TIPO_PARAM>REQ</ns3:TIPO_PARAM>
            <ns3:APLICACION>ENQ</ns3:APLICACION>
            
            (: Se arma arreglo con la información proveniente del Request hecho al proxy y el esquema de autenticación :)
            <ns3:INFO>
	            {
	            	for $nodo in (get-nodes(remove-node($RequestHeader, "Password")), get-nodes(remove-node($consultaRecaudo, "ADDITIONAL_INFO")))
	            	return
		                <ns3:DATA>
		                    <ns3:NAME>{ fn:local-name($nodo) }</ns3:NAME>
		                    <ns3:VALUE>{ fn:string($nodo/text()) }</ns3:VALUE>
		                </ns3:DATA>
	            }
	            (: La sección ADDITIONAL_INFO se envía con un consecutivo :)
	            {
	            	for $nodo at $i in (get-nodes($consultaRecaudo/ADDITIONAL_INFO))
	            	return
		                <ns3:DATA>
		                    <ns3:NAME>{ concat(fn:local-name($nodo), '_', $i) }</ns3:NAME>
		                    <ns3:VALUE>{ fn:string($nodo/text()) }</ns3:VALUE>
		                </ns3:DATA>
	            }
            </ns3:INFO>
            
            (: Se arma arreglo con la información de la consulta de detalle de recaudo en T24 y la consulta de parámetros del core :)
            <ns3:INFO_T24>
                {
                    for $nodo in (get-nodes($consultaDetalleContratoRecaudosResponse), get-nodes($consultadeparametroscoreResponse))
                    return
                    	<ns3:DATA>
		                    <ns3:NAME>{ fn:local-name($nodo) }</ns3:NAME>
		                    <ns3:VALUE>{ fn:string($nodo/text()) }</ns3:VALUE>
                        </ns3:DATA>
                }
            </ns3:INFO_T24>
        </ns3:InputParameters>
};

declare variable $RequestHeader as element(ns4:RequestHeader) external;
declare variable $consultaRecaudo as element(ns1:consultaRecaudo) external;
declare variable $consultaDetalleContratoRecaudosResponse as element(ns0:consultaDetalleContratoRecaudosResponse) external;
declare variable $consultadeparametroscoreResponse as element(ns2:ConsultadeparametroscoreResponse) external;

xf:consultaRecaudoArmarMensajeRequestIn($RequestHeader,
    $consultaRecaudo,
    $consultaDetalleContratoRecaudosResponse,
    $consultadeparametroscoreResponse)