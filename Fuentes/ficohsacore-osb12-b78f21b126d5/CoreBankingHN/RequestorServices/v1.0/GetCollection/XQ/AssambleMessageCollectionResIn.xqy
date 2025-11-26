xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns4="T24WebServicesImpl";
(:: import schema at "../../../../ProviderServices/XSD/GetCoreParameters/GetCoreParameters.xsd" ::)
declare namespace ns3="http://service.webserviceprovider.transporters.service.frametexx.com/";
(:: import schema at "../../../../ProviderServices/XSD/RouterConventions/XMLSchema_654181198.xsd" ::)
declare namespace ns2="http://www.ficohsa.com.hn/middleware.services/collectionContractDetailTypes";
(:: import schema at "../XSD/collectionContractDetailTypes.xsd" ::)
declare namespace ns1="http://www.ficohsa.com.hn/middleware.services/getCollectionTypes";
(:: import schema at "../../../../../MWBanking/Collection/RequestorServices/XSD/getCollectionTypes.xsd" ::)
declare namespace ns5="http://xmlns.oracle.com/pcbpel/adapter/db/sp/AssembleMessageCollection";
(:: import schema at "../../../../ProviderServices/XSD/AssembleMessageCollection/AssembleMessageCollection_sp.xsd" ::)

declare variable $GetCollectionRequest as element() (:: schema-element(ns1:getCollectionRequest) ::) external;
declare variable $CollectionContractDetailResponse as element() (:: schema-element(ns2:CollectionContractDetailResponse) ::) external;
declare variable $RouterConventionsResponse as element() (:: element(*, ns3:serviceResponse) ::) external;
declare variable $GetCoreParametersResponse as element() (:: schema-element(ns4:ConsultadeparametroscoreResponse) ::) external;

(: Función recursiva que retorna todos los nodos de $root. :) 
declare function local:get-nodes($root as element()?) as element()* {
	for $child in $root/*
	return
		if(not($child/text() [normalize-space(.) != '']) and $child/*) then (
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

declare function local:func($GetCollectionRequest as element() (:: schema-element(ns1:getCollectionRequest) ::), 
                            $CollectionContractDetailResponse as element() (:: schema-element(ns2:CollectionContractDetailResponse) ::), 
                            $RouterConventionsResponse as element() (:: element(*, ns3:serviceResponse) ::), 
                            $GetCoreParametersResponse as element() (:: schema-element(ns4:ConsultadeparametroscoreResponse) ::)) 
                            as element() (:: schema-element(ns5:InputParameters) ::) {
    <ns5:InputParameters>
        <ns5:CODIGO_CONTRATO>{fn:data($GetCollectionRequest/ns1:ContractId)}</ns5:CODIGO_CONTRATO>
        <ns5:TIPO_OPERACION>1</ns5:TIPO_OPERACION>
        <ns5:TIPO_PARAM>RES</ns5:TIPO_PARAM>
        <ns5:APLICACION>ENQ</ns5:APLICACION>
        <ns5:INFO>
        {
          for $nodo in local:get-nodes(local:remove-node($GetCollectionRequest, "AdditionalInfo"))
          return
            <ns5:INFO_ITEM>
                <ns5:NAME>{ fn:local-name($nodo) }</ns5:NAME>
                <ns5:VALUE>{ fn:string($nodo/text()) }</ns5:VALUE>
            </ns5:INFO_ITEM>
        }
        {
          for $nodo at $i in (local:get-nodes($GetCollectionRequest/ns1:AdditionalInfo))
          return
            <ns5:INFO_ITEM>
                <ns5:NAME>{ concat(fn:local-name($nodo), '_', $i) }</ns5:NAME>
                <ns5:VALUE>{ fn:string($nodo/text()) }</ns5:VALUE>
            </ns5:INFO_ITEM>
        }
        </ns5:INFO>
        <ns5:INFO_T24>
        {
          for $nodo in (local:get-nodes($CollectionContractDetailResponse), local:get-nodes($GetCoreParametersResponse))
          return
            <ns5:INFO_ITEM>
                <ns5:NAME>{ fn:local-name($nodo) }</ns5:NAME>
                <ns5:VALUE>{ fn:string($nodo/text()) }</ns5:VALUE>
            </ns5:INFO_ITEM>
        }
        </ns5:INFO_T24>
        <ns5:INFO_FLINK>
        {
          let $responseData := 
              if (fn:contains($RouterConventionsResponse/responseData, '?>'))then(
                  fn:substring-after($RouterConventionsResponse/responseData, '?>')
              )else(
                  fn:string($RouterConventionsResponse/responseData/text())
              )
          let $data := fn:root(fn-bea:inlinedXML($responseData)//primaryKey)
          return
            if($data instance of element() )then(
		for $nodo in local:get-nodes(local:remove-node($data, "moreParameters"))
                return
                    <ns5:INFO_ITEM>
                      <ns5:NAME>{ fn:local-name($nodo) }</ns5:NAME>
                      <ns5:VALUE>{ fn:string($nodo/text()) }</ns5:VALUE>
                    </ns5:INFO_ITEM>
            )else(
              fn:string($data)
            )
        }
        </ns5:INFO_FLINK>
        <ns5:INFO_MOREPARAM>
        {
            let $responseData := 
                if (fn:contains($RouterConventionsResponse/responseData, '?>'))then(
                  fn:substring-after($RouterConventionsResponse/responseData, '?>')
                )else(
                  fn:string($RouterConventionsResponse/responseData/text())
                )
            let $data := fn-bea:inlinedXML($responseData)//moreParameters
            return
	        if($data instance of element() )then(
                    for $nodo in (local:get-nodes(local:remove-node($data, "moreParameters")))
                    return
                        if(fn:string($nodo/@fieldName) != "")then(
                            <ns5:INFO_ITEM>
                                <ns5:NAME>{ fn:string($nodo/@fieldName) }</ns5:NAME>
                                <ns5:VALUE>{ fn:string($nodo/text()) }</ns5:VALUE>
                            </ns5:INFO_ITEM>
                        )else()
                ) else ()
        }
        </ns5:INFO_MOREPARAM>
    </ns5:InputParameters>
};

local:func($GetCollectionRequest, $CollectionContractDetailResponse, $RouterConventionsResponse, $GetCoreParametersResponse)