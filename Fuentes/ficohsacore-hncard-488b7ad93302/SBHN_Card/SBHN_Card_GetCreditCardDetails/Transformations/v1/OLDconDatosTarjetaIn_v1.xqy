xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultaDatosTarjetaCredito" element="ns0:consultaDatosTarjetaCredito" location="../../ConsultaDatosTarjetaCredito/xsd/consultaDatosTarjetaCreditoTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../BusinessServices/MasterDataHN/conDatoTarjetas_v2/xsd/conDatoTarjetas_v2_sp.xsd" ::)

declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/conDatoTarjetas_v2";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaDatosTarjetaCreditoTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/MasterDataHN/xq/conDatosTarjetaIn_v2/";

declare function xf:conDatosTarjetaIn_v2($consultaDatosTarjetaCredito as element(ns0:consultaDatosTarjetaCredito),
    $codigoPais as xs:string)
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            <ns1:Pais>{ $codigoPais }</ns1:Pais>
            {
           	 	if(data($consultaDatosTarjetaCredito/ORG) != "") then (
            		<ns0:Org>{ data($consultaDatosTarjetaCredito/ORG) }</ns0:Org>
            	)else()
            }  
            <ns1:NumTarjeta>{ data($consultaDatosTarjetaCredito/CARD_NUMBER) }</ns1:NumTarjeta>
        </ns1:InputParameters>
};

declare variable $consultaDatosTarjetaCredito as element(ns0:consultaDatosTarjetaCredito) external;
declare variable $codigoPais as xs:string external;

xf:conDatosTarjetaIn_v2($consultaDatosTarjetaCredito,
    $codigoPais)