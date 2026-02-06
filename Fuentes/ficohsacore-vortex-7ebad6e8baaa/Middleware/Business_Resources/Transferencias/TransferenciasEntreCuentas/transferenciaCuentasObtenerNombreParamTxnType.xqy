xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$autenticacionRequestHeader" element="ns1:AutenticacionRequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$transferenciaCuentasRequest" element="ns0:transferenciaCuentasRequest" location="transferenciaCuentasType.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/transferenciasType";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/Transferencias/TransferenciasEntreCuentas/transferenciaCuentasObtenerNombreParamTxnType/";

declare function xf:transferenciaCuentasObtenerNombreParamTxnType($autenticacionRequestHeader as element(ns1:AutenticacionRequestHeader),
    $transferenciaCuentasRequest as element(ns0:transferenciaCuentasRequest))
    as xs:string {
    	let $TRANSFER_DETAILS := fn:string($transferenciaCuentasRequest/TRANSFER_DETAILS/text())
    	let $USERNAME := upper-case(fn:string($autenticacionRequestHeader/UserName/text()))
    	let $CUSTOM_TXN := upper-case(substring-before(substring-after($TRANSFER_DETAILS, '['),']'))
    	return
    		if ($CUSTOM_TXN != "") then (
    			concat("T24T057.",$CUSTOM_TXN,".TXNTYPE")
    		) else (
    			concat("T24T057.",$USERNAME,".TXNTYPE")
    		)
};

declare variable $autenticacionRequestHeader as element(ns1:AutenticacionRequestHeader) external;
declare variable $transferenciaCuentasRequest as element(ns0:transferenciaCuentasRequest) external;

xf:transferenciaCuentasObtenerNombreParamTxnType($autenticacionRequestHeader,
    $transferenciaCuentasRequest)