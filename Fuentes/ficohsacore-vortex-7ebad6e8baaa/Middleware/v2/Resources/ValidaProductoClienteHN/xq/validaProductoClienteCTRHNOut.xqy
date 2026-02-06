xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$tarjetasdecreditoporclienteResponse" element="ns0:TarjetasdecreditoporclienteResponse" location="../../../../Business_Resources/consultasCliente/Resources/XMLSchema_1144838292.xsd" ::)
(:: pragma bea:global-element-return element="ns1:validaProductoClienteResponse" location="../../ValidaProductoCliente/xsd/validaProductoClienteTypes.xsd" ::)

declare namespace ns0 = "T24WebServicesImpl";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/validaProductoClienteTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ValidaProductoClienteHN/xq/validaProductoClienteCTRHNOut/";

declare function xf:validaProductoClienteCTRHNOut($tarjetasdecreditoporclienteResponse as element(ns0:TarjetasdecreditoporclienteResponse),
		$creditAccNumber as xs:string)
    as element(ns1:validaProductoClienteResponse) {
        <ns1:validaProductoClienteResponse>
            {
	            for $tarjetaCredito in $tarjetasdecreditoporclienteResponse/FICOLISTCLIENTCARDCPType/gFICOLISTCLIENTCARDCPDetailType/mFICOLISTCLIENTCARDCPDetailType
                let $numTarjeta := fn:string(replace($tarjetaCredito/ACCOUNTNO/text(), " /", ""))
                return
	                if($creditAccNumber = $numTarjeta) then(
		                <PRODUCT_NAME>{ fn:string($tarjetaCredito/CARDNAME/text()) }</PRODUCT_NAME>,
		                <CURRENCY>HNL</CURRENCY>
		            )else()      
            }
            
            
        </ns1:validaProductoClienteResponse>
};

declare variable $tarjetasdecreditoporclienteResponse as element(ns0:TarjetasdecreditoporclienteResponse) external;
declare variable $creditAccNumber as xs:string external;

xf:validaProductoClienteCTRHNOut($tarjetasdecreditoporclienteResponse, $creditAccNumber)