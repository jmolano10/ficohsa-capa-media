xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultaTransSinPreQuality" element="ns1:consultaTransSinPreQuality" location="../xsd/consultaTransSinPreQualityTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/MasterData/conTransaccionesSinPreQ/xsd/conTransaccionesSinPreQ_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/conTransaccionesSinPreQ";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaTransSinPreQualityTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaTransSinPreQuality/xq/conTransaccionesSinPreQNIIn/";

declare function xf:conTransaccionesSinPreQNIIn($consultaTransSinPreQuality as element(ns1:consultaTransSinPreQuality),
    $CodigoPais as xs:string)
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:Pais>{ $CodigoPais }</ns0:Pais>
            {
            	for $org in $consultaTransSinPreQuality/ORG
            	return
            	if(string($org/text()) != "")then(
            		<ns0:Org>{ data($org) }</ns0:Org>
            	)else()
            }
            <ns0:NumCuenta>{ data($consultaTransSinPreQuality/ACCOUNT_NUMBER) }</ns0:NumCuenta>
            <ns0:Anio>{ data($consultaTransSinPreQuality/YEAR) }</ns0:Anio>
            <ns0:Mes>{ data($consultaTransSinPreQuality/MONTH) }</ns0:Mes>
        </ns0:InputParameters>
};

declare variable $consultaTransSinPreQuality as element(ns1:consultaTransSinPreQuality) external;
declare variable $CodigoPais as xs:string external;

xf:conTransaccionesSinPreQNIIn($consultaTransSinPreQuality,
    $CodigoPais)