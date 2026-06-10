<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$tarjetasdecreditoporclienteResponse" element="ns0:TarjetasdecreditoporclienteResponse" location="../../../../Business_Resources/consultasCliente/Resources/XMLSchema_1144838292.xsd" ::)
(:: pragma bea:global-element-return element="ns1:consultaProductoOnBaseResponse" location="../../ConsultaProductoOnBase/xsd/consultaProductoOnBaseTypes.xsd" ::)

declare namespace ns0 = "T24WebServicesImpl";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaProductoOnBaseTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaProductoOnBaseHN/xq/consultaProductoOnBaseTRCHNOut/";

declare function xf:consultaProductoOnBaseTRCHNOut($tarjetasdecreditoporclienteResponse as element(ns0:TarjetasdecreditoporclienteResponse),
		$creditNumber as xs:string)
    as element(ns1:consultaProductoOnBaseResponse) {
        <ns1:consultaProductoOnBaseResponse>
            {
	            for $tarjetaCredito in $tarjetasdecreditoporclienteResponse/FICOLISTCLIENTCARDCPType/gFICOLISTCLIENTCARDCPDetailType/mFICOLISTCLIENTCARDCPDetailType
                let $numTarjeta := fn:string($tarjetaCredito/CARDNO/text())
                return
	                if($creditNumber = $numTarjeta) then(
		                <PRODUCT_NAME>{ fn:string($tarjetaCredito/CARDNAME/text()) }</PRODUCT_NAME>,
		                <CURRENCY>HNL</CURRENCY>
		            )else()      
            }
            
            
        </ns1:consultaProductoOnBaseResponse>
};

declare variable $tarjetasdecreditoporclienteResponse as element(ns0:TarjetasdecreditoporclienteResponse) external;
declare variable $creditNumber as xs:string external;

xf:consultaProductoOnBaseTRCHNOut($tarjetasdecreditoporclienteResponse, $creditNumber)]]></con:xquery>
    <con:dependency location="../../../../Business_Resources/consultasCliente/Resources/XMLSchema_1144838292.xsd">
        <con:schema ref="Middleware/Business_Resources/consultasCliente/Resources/XMLSchema_1144838292"/>
    </con:dependency>
    <con:dependency location="../../ConsultaProductoOnBase/xsd/consultaProductoOnBaseTypes.xsd">
        <con:schema ref="Middleware/v2/Resources/ConsultaProductoOnBase/xsd/consultaProductoOnBaseTypes"/>
    </con:dependency>
</con:xqueryEntry>