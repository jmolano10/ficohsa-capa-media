xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns2="T24WebServicesImpl";
(:: import schema at "../../../../ProviderServices/XSD/GetCoreParameters/GetCoreParameters.xsd", 
                     "../../../../ProviderServices/XSD/ContractsAgreements/ContractsAgreements.xsd" ::)
declare namespace ns1="http://www.ficohsa.com.hn/middleware.services/getCollectionTypes";
(:: import schema at "../../../../../MWBanking/Collection/RequestorServices/XSD/getCollectionTypes.xsd" ::)
declare namespace ns3="http://xmlns.oracle.com/pcbpel/adapter/db/sp/AssembleMessageCollection";
(:: import schema at "../../../../ProviderServices/XSD/AssembleMessageCollection/AssembleMessageCollection_sp.xsd" ::)

declare variable $GetCollectionRequest as element() (:: schema-element(ns1:getCollectionRequest) ::) external;
declare variable $GetCoreParamsResponse as element() (:: schema-element(ns2:ConsultadeparametroscoreResponse) ::) external;
declare variable $ContractAgreementsResponse as element() (:: schema-element(ns2:ConsultadetallecontratorecaudoResponse) ::) external;
declare variable $UserName as xs:string external;
declare variable $Password as xs:string external;
declare variable $Sourcebank as xs:string external;
declare variable $DestinationBank as xs:string external;

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

declare function local:func($GetCollectionRequest as element() (:: schema-element(ns1:getCollectionRequest) ::), 
                            $GetCoreParamsResponse as element() (:: schema-element(ns2:ConsultadeparametroscoreResponse) ::), 
                            $ContractAgreementsResponse as element() (:: schema-element(ns2:ConsultadetallecontratorecaudoResponse) ::), 
                            $UserName as xs:string, 
                            $Password as xs:string, 
                            $Sourcebank as xs:string, 
                            $DestinationBank as xs:string) 
                            as element() (:: schema-element(ns3:InputParameters) ::) {
    <ns3:InputParameters>
        <ns3:CODIGO_CONTRATO>{fn:data($GetCollectionRequest/ns1:ContractId)}</ns3:CODIGO_CONTRATO>
        <ns3:TIPO_OPERACION>1</ns3:TIPO_OPERACION>
        <ns3:TIPO_PARAM>REQ</ns3:TIPO_PARAM>
        <ns3:APLICACION>ENQ</ns3:APLICACION>
        <ns3:INFO>
            <ns3:INFO_ITEM>
                <ns3:NAME>UserName</ns3:NAME>
                <ns3:VALUE>{fn:data($UserName)}</ns3:VALUE>
            </ns3:INFO_ITEM>
            <ns3:INFO_ITEM>
                <ns3:NAME>Password</ns3:NAME>
                <ns3:VALUE>{fn:data($Password)}</ns3:VALUE>
            </ns3:INFO_ITEM>
            <ns3:INFO_ITEM>
                <ns3:NAME>SourceBank</ns3:NAME>
                <ns3:VALUE>{fn:data($Sourcebank)}</ns3:VALUE>
            </ns3:INFO_ITEM>
            <ns3:INFO_ITEM>
                <ns3:NAME>DestinationBank</ns3:NAME>
                <ns3:VALUE>{fn:data($DestinationBank)}</ns3:VALUE>
            </ns3:INFO_ITEM>
            <ns3:INFO_ITEM>
                <ns3:NAME>ContractId</ns3:NAME>
                <ns3:VALUE>{fn:data($GetCollectionRequest/ns1:ContractId)}</ns3:VALUE>
            </ns3:INFO_ITEM>
            <ns3:INFO_ITEM>
                <ns3:NAME>DebtorCode</ns3:NAME>
                <ns3:VALUE>{fn:data($GetCollectionRequest/ns1:DebtorCode)}</ns3:VALUE>
            </ns3:INFO_ITEM>
            <ns3:INFO_ITEM>
                <ns3:NAME>Currency</ns3:NAME>
                <ns3:VALUE>{fn:data($GetCollectionRequest/ns1:Currency)}</ns3:VALUE>
            </ns3:INFO_ITEM>
            <ns3:INFO_ITEM>
                <ns3:NAME>BillAmount</ns3:NAME>
                <ns3:VALUE>{fn:data($GetCollectionRequest/ns1:BillAmount)}</ns3:VALUE>
            </ns3:INFO_ITEM>
            <ns3:INFO_ITEM>
                <ns3:NAME>BillDate</ns3:NAME>
                <ns3:VALUE>{fn:data($GetCollectionRequest/ns1:BillDate)}</ns3:VALUE>
            </ns3:INFO_ITEM>
            <ns3:INFO_ITEM>
                <ns3:NAME>BillReturnType</ns3:NAME>
                <ns3:VALUE>{fn:data($GetCollectionRequest/ns1:BillReturnType)}</ns3:VALUE>
            </ns3:INFO_ITEM>
            <ns3:INFO_ITEM>
                <ns3:NAME>ExtendedCollection</ns3:NAME>
                <ns3:VALUE>{fn:data($GetCollectionRequest/ns1:ExtendedCollection)}</ns3:VALUE>
            </ns3:INFO_ITEM>
            {
              for $nodo at $i in (local:get-nodes($GetCollectionRequest/ns1:AdditionalInfo))
              return
                  <ns3:INFO_ITEM>
                    <ns3:NAME>{ concat(fn:local-name($nodo), '_', $i) }</ns3:NAME>
                    <ns3:VALUE>{ fn:string($nodo/text()) }</ns3:VALUE>
                  </ns3:INFO_ITEM>
            }>
        </ns3:INFO>
        <ns3:INFO_T24>
            {
                for $nodo in (local:get-nodes($ContractAgreementsResponse), local:get-nodes($GetCoreParamsResponse))
                return
                    <ns3:INFO_ITEM>
                        <ns3:NAME>{ fn:local-name($nodo) }</ns3:NAME>
                        <ns3:VALUE>{ fn:string($nodo/text()) }</ns3:VALUE>
                    </ns3:INFO_ITEM>
            }
        </ns3:INFO_T24>
    </ns3:InputParameters>
};

local:func($GetCollectionRequest, $GetCoreParamsResponse, $ContractAgreementsResponse, $UserName, $Password, $Sourcebank, $DestinationBank)