xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns3="T24WebServicesImpl";
(:: import schema at "../../../../ProviderServices/XSD/CoreBS/XMLSchema_1628019553.xsd" ::)
declare namespace ns2="http://service.webserviceprovider.transporters.service.frametexx.com/";
(:: import schema at "../../../../ProviderServices/XSD/RouterConventions/XMLSchema_654181198.xsd" ::)
declare namespace ns1="http://www.ficohsa.com.hn/middleware.services/paymentCollectionTypes";
(:: import schema at "../../../../../MWBanking/Collection/RequestorServices/XSD/paymentCollectionTypes.xsd" ::)
declare namespace ns4="http://xmlns.oracle.com/pcbpel/adapter/db/FLINK/OSB_K_DISTR_CPTOS_RECAUDOS/OSB_DISTRIBUIR_CONCEPTOS/";
(:: import schema at "../../../../ProviderServices/XSD/CollectionConceptDistribution/XMLSchema_-288564345.xsd" ::)

declare variable $paymentCollectionRequest as element() (:: schema-element(ns1:paymentCollectionRequest) ::) external;
declare variable $transactionId as xs:string external;
declare variable $serviceResponse as element() (:: schema-element(ns2:serviceResponse) ::) external;
declare variable $getCoreParametersResponse as element() (:: schema-element(ns3:ConsultadeparametroscoreResponse) ::) external;

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

declare function local:func($paymentCollectionRequest as element() (:: schema-element(ns1:paymentCollectionRequest) ::), 
                            $transactionId as xs:string, 
                            $serviceResponse as element() (:: schema-element(ns2:serviceResponse) ::), 
                            $getCoreParametersResponse as element() (:: schema-element(ns3:ConsultadeparametroscoreResponse) ::)) 
                            as element() (:: schema-element(ns4:InputParameters) ::) {
    <ns4:InputParameters>
          <ns1:CODIGO_CONTRATO>{ data($paymentCollectionRequest/ns1:ContractId) }</ns1:CODIGO_CONTRATO>
			<ns1:CODIGO_DEUDOR>{ data($paymentCollectionRequest/ns1:DebtorCode) }</ns1:CODIGO_DEUDOR>
			<ns1:ID_TRANSACCION>{ $transactionId }</ns1:ID_TRANSACCION>
			<ns1:MONEDA_PAGO>{ data($paymentCollectionRequest/ns1:PaymentInformation/ns1:PaymentCurrency) }</ns1:MONEDA_PAGO>
			<ns1:MONTO_PAGO>{ data($paymentCollectionRequest/ns1:PaymentInformation/ns1:PaymentAmount) }</ns1:MONTO_PAGO>
			<ns1:TASA_COMPRA>{ data($getCoreParametersResponse/WSCOREPARAMETERSType[1]/gWSCOREPARAMETERSDetailType/mWSCOREPARAMETERSDetailType[1]/BUYRATE) }</ns1:TASA_COMPRA>
			<ns1:TASA_VENTA>{ data($getCoreParametersResponse/WSCOREPARAMETERSType[1]/gWSCOREPARAMETERSDetailType/mWSCOREPARAMETERSDetailType[1]/SELLRATE) }</ns1:TASA_VENTA>
			
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
			            	for $nodo in (local:get-nodes(local:remove-node($data, "moreParameters")))
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
			            	for $nodo in (local:get-nodes(local:remove-node($data, "moreParameters")))
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
    </ns4:InputParameters>
};

local:func($paymentCollectionRequest, $transactionId, $serviceResponse, $getCoreParametersResponse)