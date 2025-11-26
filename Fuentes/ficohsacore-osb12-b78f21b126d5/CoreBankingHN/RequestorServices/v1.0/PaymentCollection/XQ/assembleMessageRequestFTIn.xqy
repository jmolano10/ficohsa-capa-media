xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns3="T24WebServicesImpl";
(:: import schema at "../../../../ProviderServices/XSD/CoreBS/XMLSchema_1628019553.xsd" ::)
declare namespace ns2="http://www.ficohsa.com.hn/middleware.services/collectionContractDetailTypes";
(:: import schema at "../../GetCollection/XSD/collectionContractDetailTypes.xsd" ::)
declare namespace ns1="http://www.ficohsa.com.hn/middleware.services/paymentCollectionTypes";
(:: import schema at "../../../../../MWBanking/Collection/RequestorServices/XSD/paymentCollectionTypes.xsd" ::)
declare namespace ns5="http://xmlns.oracle.com/pcbpel/adapter/db/sp/AssembleMessageCollection";
(:: import schema at "../../../../ProviderServices/XSD/AssembleMessageCollection/AssembleMessageCollection_sp.xsd" ::)
declare namespace ns4="http://xmlns.oracle.com/pcbpel/adapter/db/sp/GetRelationOperationCollection";
(:: import schema at "../../../../ProviderServices/XSD/GetRelationOperationCollection/GetRelationOperationCollection_sp.xsd" ::)

declare variable $status as element() external;
declare variable $fundsTransferType as element() external;
declare variable $paymentCollectionRequest as element() (:: schema-element(ns1:paymentCollectionRequest) ::) external;
declare variable $getCollectionContractDetailResponse as element() (:: schema-element(ns2:CollectionContractDetailResponse) ::) external;
declare variable $getCoreParametersResponse as element() (:: schema-element(ns3:ConsultadeparametroscoreResponse) ::) external;
declare variable $getRelationOperationCollectionresponse as element() (:: schema-element(ns4:OutputParameters) ::) external;

(: Función recursiva que retorna todos los nodos de $root. :) 
declare function local:get-nodes($root as element()?) as element()* {
	for $child in $root/*
	return
		if( not($child/text() [normalize-space(.) != '']) and $child/*) then (
			 local:get-nodes($child)
			
		) else (
			$child
		)	
};

(: Devuelve el nodo de entrada sin el elemento a borrar :)
declare function local:remove-node($elements as element()*,
	$name as xs:string*) as element()* {
	
	for $element in $elements
	return
		element
			{node-name($element)}
			{$element/@*,
			 $element/node()[not(name()=$name)]}
};

declare function local:func($status as element(), 
                            $fundsTransferType as element(), 
                            $paymentCollectionRequest as element() (:: schema-element(ns1:paymentCollectionRequest) ::), 
                            $getCollectionContractDetailResponse as element() (:: schema-element(ns2:CollectionContractDetailResponse) ::), 
                            $getCoreParametersResponse as element() (:: schema-element(ns3:ConsultadeparametroscoreResponse) ::), 
                            $getRelationOperationCollectionresponse as element() (:: schema-element(ns4:OutputParameters) ::)) 
                            as element() (:: schema-element(ns5:InputParameters) ::) {
    <ns5:InputParameters>
          <ns3:CODIGO_CONTRATO>{ data($paymentCollectionRequest/ns1:ContractId) }</ns3:CODIGO_CONTRATO>
            <ns3:TIPO_OPERACION>2</ns3:TIPO_OPERACION>
            <ns3:TIPO_PARAM>REQ</ns3:TIPO_PARAM>
            <ns3:APLICACION>FT</ns3:APLICACION>
            
            (: Se arma arreglo con la información proveniente del Request hecho al proxy, el esquema de autenticación y la información 
               devuelta por el servicio de ConsultaRecaudoReferenciadoEnLinea (BD) :)
            <ns3:INFO>
	            {
	            	for $nodo in local:get-nodes(local:remove-node($paymentCollectionRequest, "AdditionalInfo"))
	            	return
		                <ns3:DATA>
		                    <ns3:NAME>{ fn:local-name($nodo) }</ns3:NAME>
		                    <ns3:VALUE>{ fn:string($nodo/text()) }</ns3:VALUE>
		                </ns3:DATA>
	            }
	            (: Se envía la información de consultaRelacionOperacionRecuados con consecutivo :)
	            {
	            	for $nodo in local:remove-node($getRelationOperationCollectionresponse/*,("CODIGO_ERROR","MENSAJE_ERROR"))
	            	return
	            		for $child at $i in  local:get-nodes($nodo)
	            		return
			                <ns3:DATA>
			                    <ns3:NAME>{ concat(fn:local-name($nodo), '_', $i) }</ns3:NAME>
			                    <ns3:VALUE>{ fn:string($child/text()) }</ns3:VALUE>
			                </ns3:DATA>
	            }	            
	            (: La sección ADDITIONAL_INFO se envía con un consecutivo :)
	            {
	            	for $nodo at $i in (local:get-nodes($paymentCollectionRequest/ns1:AdditionalInfo))
	            	return
		                <ns3:DATA>
		                    <ns3:NAME>{ concat(fn:local-name($nodo), '_', $i) }</ns3:NAME>
		                    <ns3:VALUE>{ fn:string($nodo/text()) }</ns3:VALUE>
		                </ns3:DATA>
	            }
            </ns3:INFO>
            
            (: Se arma arreglo con la información de la consulta de detalle de recaudo en T24, la respuesta de pago referenciado, el starus del pago referenciado y la consulta de parámetros del core :)
            <ns3:INFO_T24>
                {
                    for $nodo in (local:get-nodes($getCollectionContractDetailResponse), local:get-nodes($fundsTransferType), local:get-nodes($status), local:get-nodes($getCoreParametersResponse))
                    return
                    	<ns3:DATA>
		                    <ns3:NAME>{ fn:local-name($nodo) }</ns3:NAME>
		                    <ns3:VALUE>{ fn:string($nodo/text()) }</ns3:VALUE>
                        </ns3:DATA>
                }
            </ns3:INFO_T24>
    </ns5:InputParameters>
};

local:func($status, $fundsTransferType, $paymentCollectionRequest, $getCollectionContractDetailResponse, $getCoreParametersResponse, $getRelationOperationCollectionresponse)