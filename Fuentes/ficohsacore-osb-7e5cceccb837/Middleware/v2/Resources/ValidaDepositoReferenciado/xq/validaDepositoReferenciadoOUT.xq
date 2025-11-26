(:: pragma bea:global-element-parameter parameter="$RSPValidaDepositoReferenciado" element="vdrsp:OutputParameters" location="../../../BusinessServices/ABK/validaDepositoReferenciado/xsd/validaDepositoReferenciado_sp.xsd" ::)
(:: pragma bea:global-element-return element="val:validaDepositoReferenciadoResponse" location="../xsd/validaDepositoReferenciadoTypes.xsd" ::)

xquery version "1.0" encoding "Cp1252";

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ValidaDepositoReferenciado/xq/ValidaDepositoReferenciadoOut/";
declare namespace soap-env = "http://schemas.xmlsoap.org/soap/envelope/";
declare namespace urn = "urn:infocorp.framework.services.common";
declare namespace urn1 = "urn:infocorp.framework.common";
declare namespace h = "urn:infocorp.framework.services.common"; 
declare namespace i = "http://www.w3.org/2001/XMLSchema-instance";
declare namespace wsa = "http://www.w3.org/2005/08/addressing";
declare namespace wsse = "http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-wssecurity-secext-1.0.xsd";
declare namespace wsu = "http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-wssecurity-utility-1.0.xsd";
declare namespace val = "http://www.ficohsa.com.hn/middleware.services/depositosReferenciadosTypes";
declare namespace vdrsp = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/validaDepositoReferenciado";


declare function xf:ValidaDepositoReferenciadoOut($RSPValidaDepositoReferenciado as element(vdrsp:OutputParameters))
    as element(val:validaDepositoReferenciadoResponse) {
      <val:validaDepositoReferenciadoResponse>
  	{
  		for $documentNumber in data($RSPValidaDepositoReferenciado/vdrsp:PV_NUMERO_DOCUMENTO)
  		return
  			<DOCUMENT_NUMBER>{ $documentNumber }</DOCUMENT_NUMBER>
  	}
  	{
  		for $account in data($RSPValidaDepositoReferenciado/vdrsp:PV_CUENTA)
  		return
  			<ACCOUNT>{ $account }</ACCOUNT>
  	}
<DEBTOR_INFOS>
  	{
  		for $x in 1 to fn:count($RSPValidaDepositoReferenciado/vdrsp:PT_CODIGO_DEUDOR/vdrsp:ITEM)
  		return
  			<DEBTOR_INFO>
				<ID>{ data($RSPValidaDepositoReferenciado/vdrsp:PT_CODIGO_DEUDOR/vdrsp:ITEM[$x]) }</ID>
				<NAME>{ data($RSPValidaDepositoReferenciado/vdrsp:PT_NOMBRE_DEUDOR/vdrsp:ITEM[$x]) }</NAME>
			</DEBTOR_INFO>
  	}
</DEBTOR_INFOS>
      </val:validaDepositoReferenciadoResponse>
};

declare variable $RSPValidaDepositoReferenciado as element(vdrsp:OutputParameters) external;

xf:ValidaDepositoReferenciadoOut($RSPValidaDepositoReferenciado)