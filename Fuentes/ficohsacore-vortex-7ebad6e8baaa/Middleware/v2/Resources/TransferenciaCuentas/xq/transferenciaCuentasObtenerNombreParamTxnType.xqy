xquery version "2004-draft" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$requestHeader" element="ns0:RequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$transferenciaCuentasRequest" element="ns1:transferenciaCuentasRequest" location="../../../../Business_Resources/Transferencias/TransferenciasEntreCuentas/transferenciaCuentasType.xsd" ::)

declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/TransferenciaCuentas/xq/transferenciaCuentasObtenerNombreParamTxnType/";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/transferenciasType";

declare function xf:transferenciaCuentasObtenerNombreParamTxnType($requestHeader as element(ns0:RequestHeader),
    $transferenciaCuentasRequest as element(ns1:transferenciaCuentasRequest))
    as xs:string {
    	let $TRANSFER_DETAILS := fn:string($transferenciaCuentasRequest/TRANSFER_DETAILS/text())
    	let $USERNAME := upper-case(fn:string($requestHeader/Authentication/UserName/text()))
    	let $CUSTOM_TXN := upper-case(substring-before(substring-after($TRANSFER_DETAILS, '['),']'))
    	return
    		if ($CUSTOM_TXN != "") then (
    			concat("T24T057.",$CUSTOM_TXN,".TXNTYPE")
    		) else (
    			concat("T24T057.",$USERNAME,".TXNTYPE")
    		)
};

declare variable $requestHeader as element(ns0:RequestHeader) external;
declare variable $transferenciaCuentasRequest as element(ns1:transferenciaCuentasRequest) external;

xf:transferenciaCuentasObtenerNombreParamTxnType($requestHeader,
    $transferenciaCuentasRequest)