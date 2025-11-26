xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="T24WebServicesImpl";
(:: import schema at "../../../../ProviderServices/XSD/PayRemittances/XMLSchema_-1855765488.xsd" ::)
declare namespace ns2="http://www.ficohsa.com.hn/middleware.services/payRemittancesTypes";
(:: import schema at "../../../../../MWBanking/Remittances/RequestorServices/XSD/payRemittancesTypes.xsd" ::)
declare namespace ns3="http://xmlns.oracle.com/pcbpel/adapter/db/sp/ArmarMensajeRecaudosBS";
(:: import schema at "../../../../ProviderServices/XSD/PayRemittances/ArmarMensajeRecaudosBS_sp.xsd" ::)

declare namespace xq="http://www.w3.org/2005/xquery-local-functions";


declare variable $userName as xs:string external;
declare variable $pagoderemesaFTResponse1 as element() (:: schema-element(ns1:PagoderemesaFTResponse) ::) external;
declare variable $pagoRemesas1 as element() (:: schema-element(ns2:pagoRemesas) ::) external;

(: Función recursiva que retorna todos los nodos de $root. :) 
declare function xq:get-nodes($root as element()?) as element()* {
	for $child in $root/*
	return
		if( not($child/text() [fn:normalize-space(.) != '']) and $child/*) then (
			 xq:get-nodes($child)
			
		) else (
			$child
		)	
};

(: Devuelve el nodo de entrada sin el elemento a borrar :)
declare function xq:remove-node($elements as element()*,
	$name as xs:string*) as element()* {
	
	for $element in $elements
	return
		element
			{fn:node-name($element)}
			{$element/@*,
			 $element/node()[fn:not(fn:name()=$name)]}
};

(: Devuelve la fecha de vencimiento del ID del beneficiario :)
declare function xq:expiration-date($date as xs:string) as xs:string {
	let $expirationDate := fn:concat(xs:int(fn:substring($date, 1, 4)) + 100,  fn:substring($date, 5, 2) ,    fn:substring($date, 7, 2))
	
	return
		$expirationDate
};

(: Devuelve la conversion de la letra Ñ a \u00d1 para WU y Vigo :)
declare function xq:convert-text($value as xs:string, $tipoRem as xs:string) as xs:string {
        let $convertText := fn:matches($value, 'Ñ')
	return
	if (($tipoRem = '5242535.001' or $tipoRem = '5242535.002') and $convertText = fn:true()) then(
		fn:concat(fn:substring-before($value,'Ñ'),'\u00d1',fn:substring-after($value, 'Ñ'))
	)else(
		$value
	)
};



declare function xq:armarMensajeRequestFTIn($pagoderemesaFTResponse1 as element() (:: schema-element(ns1:PagoderemesaFTResponse) ::), 
                                            $pagoRemesas1 as element() (:: schema-element(ns2:pagoRemesas) ::),$userName as xs:string) 
                                            as element() (:: schema-element(ns3:InputParameters) ::) {
    <ns3:InputParameters>
        <ns3:CODIGO_CONTRATO>{ data($pagoRemesas1/ns2:REMITTER_ID) }</ns3:CODIGO_CONTRATO>
        <ns3:TIPO_OPERACION>2</ns3:TIPO_OPERACION>
        <ns3:TIPO_PARAM>REQ</ns3:TIPO_PARAM>
        <ns3:APLICACION>FT</ns3:APLICACION>
        <ns3:INFO>
        <ns3:INFO_ITEM>
        <ns3:NAME>UserName</ns3:NAME>
        <ns3:VALUE>{$userName}</ns3:VALUE>
		</ns3:INFO_ITEM>        
            	{
                for $nodo in xq:get-nodes($pagoRemesas1)
                return        
            <ns3:INFO_ITEM>
                <ns3:NAME>{ fn:local-name($nodo) }</ns3:NAME>
                <ns3:VALUE>{ fn:string($nodo/text()) }</ns3:VALUE>
            </ns3:INFO_ITEM>
                }
            	{
                for  $INFO in $pagoRemesas1/ns2:ADDITIONAL_INFO/ns2:INFO
                return        
            <ns3:INFO_ITEM>
                <ns3:NAME>{ $INFO/ns2:NAME/text() }</ns3:NAME>
                <ns3:VALUE>{ xq:convert-text($INFO/ns2:VALUE/text(), fn:data($pagoRemesas1/ns2:REMITTER_ID)) }</ns3:VALUE>
            </ns3:INFO_ITEM>
                }    
            	{    
            <ns3:INFO_ITEM>
                <ns3:NAME>ID_EXPIRATION_DATE</ns3:NAME>
                <ns3:VALUE>{ xq:expiration-date($pagoRemesas1/ns2:BENEFICIARY_INFO/ns2:DATE_OF_BIRTH/text())}</ns3:VALUE>
            </ns3:INFO_ITEM>
            }
        </ns3:INFO>
        <ns3:INFO_T24>
		        {
		     		for $nodo in (xq:get-nodes($pagoderemesaFTResponse1))
		     		return        
            <ns3:INFO_ITEM>
                <ns3:NAME>{ fn:local-name($nodo)}</ns3:NAME>
                <ns3:VALUE>{fn:string($nodo/text()) }</ns3:VALUE>
            </ns3:INFO_ITEM>
            }
        </ns3:INFO_T24>
 
    </ns3:InputParameters>
};

xq:armarMensajeRequestFTIn($pagoderemesaFTResponse1, $pagoRemesas1,$userName)
