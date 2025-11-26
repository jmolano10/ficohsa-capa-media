(:: pragma bea:global-element-parameter parameter="$responseHeader1" element="ns2:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$validacionCuentaResponse1" element="ns1:validacionCuentaResponse" location="../../../../Business_Resources/validacionCuenta/ValidacionCuenta/validacionCuentaType.xsd" ::)
(:: pragma bea:global-element-return element="ns0:consultaCuentaResponse" location="../xsd/consultaCuentaCBTypes.xsd" ::)

declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/validacionCuentaType";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaCuentaCBTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaCuentaBC/xq/consultaCuentaCBOut/";

declare function xf:consultaCuentaBCOut($responseHeader1 as element(ns2:ResponseHeader),
    $validacionCuentaResponse1 as element(ns1:validacionCuentaResponse))
    as element(ns0:consultaCuentaResponse) {
		if (fn:upper-case(fn:string($responseHeader1/successIndicator/text())) = "SUCCESS") then (
	        <ns0:consultaCuentaResponse>
	            {
	                for $ACCOUNT_NUMBER in $validacionCuentaResponse1/ACCOUNT_NUMBER
	                return
	                    <ACCOUNT_NUMBER>{ data($ACCOUNT_NUMBER) }</ACCOUNT_NUMBER>
	            }
	            {
	                for $ACCOUNT_NAME in $validacionCuentaResponse1/ACCOUNT_NAME
	                return
	                    <ACCOUNT_NAME>{ data($ACCOUNT_NAME) }</ACCOUNT_NAME>
	            }
	            {
	                for $CURRENCY in $validacionCuentaResponse1/CURRENCY
	                return
	                    <CURRENCY>{ data($CURRENCY) }</CURRENCY>
	            }
	            {
	                for $ACCOUNT_STATUS in $validacionCuentaResponse1/ACCOUNT_STATUS
	                return
	                    <ACCOUNT_STATUS>{ data($ACCOUNT_STATUS) }</ACCOUNT_STATUS>
	            }
	            {
	                for $DEP_REF_ACCOUNT in $validacionCuentaResponse1/KV_PAIRS/PAIR/VALUE
	                return
	                    <DEP_REF_ACCOUNT>{ data($DEP_REF_ACCOUNT) }</DEP_REF_ACCOUNT>
	            }
	        </ns0:consultaCuentaResponse>
	    ) else (
	    	<ns0:consultaCuentaResponse/>
	    )
};

declare variable $responseHeader1 as element(ns2:ResponseHeader) external;
declare variable $validacionCuentaResponse1 as element(ns1:validacionCuentaResponse) external;

xf:consultaCuentaBCOut($responseHeader1,
    $validacionCuentaResponse1)