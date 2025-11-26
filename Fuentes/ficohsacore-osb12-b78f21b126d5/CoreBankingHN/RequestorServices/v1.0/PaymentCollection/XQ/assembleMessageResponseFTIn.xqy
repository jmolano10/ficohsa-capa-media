xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns4="T24WebServicesImpl";
(:: import schema at "../../../../ProviderServices/XSD/CoreBS/XMLSchema_1628019553.xsd" ::)
declare namespace ns1="http://service.webserviceprovider.transporters.service.frametexx.com/";
(:: import schema at "../../../../ProviderServices/XSD/RouterConventions/XMLSchema_654181198.xsd" ::)
declare namespace ns3="http://www.ficohsa.com.hn/middleware.services/collectionContractDetailTypes";
(:: import schema at "../../GetCollection/XSD/collectionContractDetailTypes.xsd" ::)
declare namespace ns2="http://www.ficohsa.com.hn/middleware.services/paymentCollectionTypes";
(:: import schema at "../../../../../MWBanking/Collection/RequestorServices/XSD/paymentCollectionTypes.xsd" ::)
declare namespace ns5="http://xmlns.oracle.com/pcbpel/adapter/db/sp/AssembleMessageCollection";
(:: import schema at "../../../../ProviderServices/XSD/AssembleMessageCollection/AssembleMessageCollection_sp.xsd" ::)

declare variable $fundsTransferType as element() external;
declare variable $serviceResponse as element() (:: schema-element(ns1:serviceResponse) ::) external;
declare variable $paymentCollectionRequest as element() (:: schema-element(ns2:paymentCollectionRequest) ::) external;
declare variable $getCollectionContractDetailResponse as element() (:: schema-element(ns3:CollectionContractDetailResponse) ::) external;
declare variable $getCoreParametersResponse as element() (:: schema-element(ns4:ConsultadeparametroscoreResponse) ::) external;

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


declare function local:func($local:fundsTransferType as element(), 
                            $serviceResponse as element() (:: schema-element(ns1:serviceResponse) ::), 
                            $paymentCollectionRequest as element() (:: schema-element(ns2:paymentCollectionRequest) ::), 
                            $getCollectionContractDetailResponse as element() (:: schema-element(ns3:CollectionContractDetailResponse) ::), 
                            $getCoreParametersResponse as element() (:: schema-element(ns4:ConsultadeparametroscoreResponse) ::)) 
                            as element() (:: schema-element(ns5:InputParameters) ::) {
    <ns5:InputParameters>
            <ns3:CODIGO_CONTRATO>{ data($paymentCollectionRequest/ns2:ContractId) }</ns3:CODIGO_CONTRATO>
            <ns3:TIPO_OPERACION>2</ns3:TIPO_OPERACION>
            <ns3:TIPO_PARAM>RES</ns3:TIPO_PARAM>
            <ns3:APLICACION>FT</ns3:APLICACION>
            
            (: Se arma arreglo con la información proveniente del Request hecho al proxy :)
            <ns3:INFO>
	            {
	            	for $nodo in local:get-nodes(local:remove-node($paymentCollectionRequest, "ADDITIONAL_INFO"))
	            	return
		                <ns3:DATA>
		                    <ns3:NAME>{ fn:local-name($nodo) }</ns3:NAME>
		                    <ns3:VALUE>{ fn:string($nodo/text()) }</ns3:VALUE>
		                </ns3:DATA>
	            }
	            (: La sección ADDITIONAL_INFO se envía con un consecutivo :)
	            {
	            	for $nodo at $i in (local:get-nodes($paymentCollectionRequest/ns2:AdditionalInfo))
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
                    for $nodo in (local:get-nodes($getCollectionContractDetailResponse), local:get-nodes($fundsTransferType), local:get-nodes($getCoreParametersResponse))
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
	            	(:let $responseData := fn-bea:inlinedXML($serviceResponse/responseData):)
	            	let $responseData := 
	            		if (fn:contains($serviceResponse/responseData, '?>')) then  (
	            			fn:substring-after($serviceResponse/responseData, '?>')
	            		) else (
	            			fn:string($serviceResponse/responseData/text())
		            	)
	            	let $data := fn-bea:inlinedXML($responseData)
	            	return
	            		if($data instance of element() ) then (
			            	for $nodo in (local:get-nodes(local:remove-node($data, "moreParameters")))
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
	            	(:let $responseData := fn-bea:inlinedXML($serviceResponse/responseData):)
	            	let $responseData := 
	            		if (fn:contains($serviceResponse/responseData, '?>')) then  (
	            			fn:substring-after($serviceResponse/responseData, '?>')
	            		) else (
	            			fn:string($serviceResponse/responseData/text())
		            	)
	            	let $data := fn-bea:inlinedXML($responseData)//moreParameters
	            	return
	            		if($data instance of element() ) then (
			            	for $nodo in (local:get-nodes(local:remove-node($data, "moreParameters")))
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
    </ns5:InputParameters>
};

local:func($fundsTransferType, $serviceResponse, $paymentCollectionRequest, $getCollectionContractDetailResponse, $getCoreParametersResponse)