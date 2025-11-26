(:: pragma bea:global-element-parameter parameter="$RSPValidaDepositoReferenciado" element="vdrrsp:validaDepositoReferenciadoResponse" location="../../DepositosReferenciados/xsd/depositosReferenciadosTypes.xsd" ::)
(:: pragma bea:global-element-return element="val:validaDepositoReferenciadoCBResponse" location="../xsd/validaDepositoReferenciadoCBTypes.xsd" ::)

xquery version "1.0" encoding "Cp1252";

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ValidaDepositoReferenciadoCB/xq/ValidaDepositoReferenciadoCBOut/";
declare namespace soap-env = "http://schemas.xmlsoap.org/soap/envelope/";
declare namespace urn = "urn:infocorp.framework.services.common";
declare namespace urn1 = "urn:infocorp.framework.common";
declare namespace h = "urn:infocorp.framework.services.common"; 
declare namespace i = "http://www.w3.org/2001/XMLSchema-instance";
declare namespace wsa = "http://www.w3.org/2005/08/addressing";
declare namespace wsse = "http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-wssecurity-secext-1.0.xsd";
declare namespace wsu = "http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-wssecurity-utility-1.0.xsd";
declare namespace val = "http://www.ficohsa.com.hn/middleware.services/ValidaDepositoReferenciadoCBTypes";
declare namespace vdrrsp = "http://www.ficohsa.com.hn/middleware.services/depositosReferenciadosTypes";


declare function xf:ValidaDepositoReferenciadoCBOut($RSPValidaDepositoReferenciado as element(vdrrsp:validaDepositoReferenciadoResponse))
    as element(val:validaDepositoReferenciadoCBResponse) {
      <val:validaDepositoReferenciadoCBResponse>
  	{
  		for $documentNumber in data($RSPValidaDepositoReferenciado/DOCUMENT_NUMBER)
  		return
  			<DOCUMENT_NUMBER>{ $documentNumber }</DOCUMENT_NUMBER>
  	}
  	{
  		for $account in data($RSPValidaDepositoReferenciado/ACCOUNT)
  		return
  			<ACCOUNT>{ $account }</ACCOUNT>
  	}
  	{
  		for $debtorInfo in $RSPValidaDepositoReferenciado/DEBTOR_INFOS/DEBTOR_INFO
  		return
  			<DEBTOR_INFO>
				<ID>{ data($debtorInfo/ID) }</ID>
				<NAME>{ data($debtorInfo/NAME) }</NAME>
			</DEBTOR_INFO>
  	}
      </val:validaDepositoReferenciadoCBResponse>
};

declare variable $RSPValidaDepositoReferenciado as element(vdrrsp:validaDepositoReferenciadoResponse) external;

xf:ValidaDepositoReferenciadoCBOut($RSPValidaDepositoReferenciado)