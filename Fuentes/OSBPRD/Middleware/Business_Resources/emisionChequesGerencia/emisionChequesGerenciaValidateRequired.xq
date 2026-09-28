xquery version "1.0" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$emisionChequesGerencia" element="ns0:emisionChequesGerencia" location="emisionChequesGerenciaTypes.xsd" ::)

declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/emisionChequesGerencia/emisionChequesGerenciaValidationIn/";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/emisionChequesGerenciaTypes";

declare function xf:emisionChequesGerenciaValidationIn($emisionChequesGerencia as element(ns0:emisionChequesGerencia))
    as xs:boolean {
		if( fn:string($emisionChequesGerencia/DEBIT_ACCOUNT/text()) = "" or 
        	fn:string($emisionChequesGerencia/BENEFICIARY_NAME/text()) = "" or
        	fn:string($emisionChequesGerencia/AMOUNT/text()) = "" or
        	fn:string($emisionChequesGerencia/DESCRIPTION/text()) = "" or
        	fn:string($emisionChequesGerencia/WITHDRAWAL_BRANCH_ID/text()) = "" or
        	fn:string($emisionChequesGerencia/CHEQUE_CURRENCY/text()) = "" ) then (
        		xs:boolean("0")
        )
        else (
        	xs:boolean("1")
        )
};

declare variable $emisionChequesGerencia as element(ns0:emisionChequesGerencia) external;

xf:emisionChequesGerenciaValidationIn($emisionChequesGerencia)