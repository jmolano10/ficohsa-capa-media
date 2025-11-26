(:: pragma bea:global-element-parameter parameter="$reversionCompletaTransaccion" element="ns0:reversionCompletaTransaccion" location="../../xsds/ReversionCompletaTransaccion/reversionCompletaTransaccionTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/reversionCompletaTransaccionTypes";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/ReversionCompletaTransaccion/ReversionCompletaTransaccionValidate/";

declare function xf:ReversionCompletaTransaccionValidate($reversionCompletaTransaccion as element(ns0:reversionCompletaTransaccion))
    as xs:string {
        if (fn:string($reversionCompletaTransaccion/TRANSACTION_ID/text()) = "" or fn:string($reversionCompletaTransaccion/TRANSACTION_TYPE/text()) = "" or 
        	fn:string($reversionCompletaTransaccion/AUTHORIZER/TELLERID/text()) = "" or fn:string($reversionCompletaTransaccion/AUTHORIZER/BRANCHCODE/text()) = "") then (
        	"CAMPOS REQUERIDOS NO SUMINISTRADOS"
        	        	
        ) else if (not (fn:string($reversionCompletaTransaccion/TRANSACTION_TYPE/text()) = ("ACCOUNT_DEPOSIT", "ACCOUNT_WITHDRAWAL", "CHEQUE_PAYMENT", "CREDIT_CARD_PAYMENT"))) then (
        	"TIPO DE TRANSACCIÓN NO SOPORTADA"
        	
        ) else if (fn:string($reversionCompletaTransaccion/TRANSACTION_TYPE/text()) = "ACCOUNT_WITHDRAWAL" and not(fn:substring(fn:string($reversionCompletaTransaccion/TRANSACTION_ID/text()), 1, 2) = ("FT", "TT"))) then (
        	"IDENTIFICADOR DE TRANSACCIÓN INVÁLIDO PARA EL TIPO DE TRANSACCIÓN"
         
        ) else (
        	""
        )
};

declare variable $reversionCompletaTransaccion as element(ns0:reversionCompletaTransaccion) external;

xf:ReversionCompletaTransaccionValidate($reversionCompletaTransaccion)