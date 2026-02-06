xquery version "2004-draft";
(:: pragma bea:global-element-return element="ns1:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaRemesaPorNombreYMetodo/xq/consultaRemesaPorNombreEnrutadorHeaderOut/";

declare function xf:consultaRemesaPorNombreEnrutadorHeaderOut($parametersOut as element(*))
    as element(ns1:ResponseHeader) {
        <ns1:ResponseHeader>
        	<successIndicator>
            {
                if (fn:string($parametersOut/errorCode/text()) = "0") then 
                	"SUCCESS"
                else 
					"ERROR"
            }
            </successIndicator>
            {
                for $PV_ERROR in $parametersOut/errorMessage
                return
                    <messages>{ data($PV_ERROR) }</messages>
            }
        </ns1:ResponseHeader>
};

declare variable $parametersOut as element(*) external;

xf:consultaRemesaPorNombreEnrutadorHeaderOut($parametersOut)