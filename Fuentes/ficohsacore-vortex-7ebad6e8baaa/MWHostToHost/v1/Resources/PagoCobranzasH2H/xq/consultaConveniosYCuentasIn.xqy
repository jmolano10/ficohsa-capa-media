xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$pagoCobranzas" element="ns2:pagoCobranzas" location="../../CobranzasH2H/xsd/cobranzasH2HTypes.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$requestHeader" element="ns0:RequestHeader" location="../../EsquemasGenerales/headerElements.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../BusinessServices/INTFC/consultaConveniosYCuentasH2H/xsd/consultaConveniosYCuentasH2H_sp.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/cobranzasH2HTypes";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaConveniosYCuentasH2H";
declare namespace xf = "http://tempuri.org/MWHostToHost/v1/Resources/PagoCobranzasH2H/xq/consultaConveniosYCuentas/";

declare function xf:consultaConveniosYCuentas($pagoCobranzas as element(ns2:pagoCobranzas),
    $requestHeader as element(ns0:RequestHeader))
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            <ns1:PV_CODIGOCLIENTE>{ data($pagoCobranzas/CUSTOMER_ID) }</ns1:PV_CODIGOCLIENTE>
            {
                <ns1:PT_IDSERVICIO>
                    {
		                for $SERVICESID in distinct-values($pagoCobranzas/SERVICES/SERVICE/ID)
		                return		                    
		                	<ns1:PT_IDSERVICIO_ITEM>{ data($SERVICESID) }</ns1:PT_IDSERVICIO_ITEM>		                    
		            } 
                </ns1:PT_IDSERVICIO>
            }     
            <ns1:PV_CODIGOPAIS>{ data($requestHeader/Region/SourceBank) }</ns1:PV_CODIGOPAIS>
        </ns1:InputParameters>
};

declare variable $pagoCobranzas as element(ns2:pagoCobranzas) external;
declare variable $requestHeader as element(ns0:RequestHeader) external;

xf:consultaConveniosYCuentas($pagoCobranzas,
    $requestHeader)