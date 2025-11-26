(:: pragma bea:global-element-parameter parameter="$consultaChequesPagados" element="ns0:consultaChequesPagados" location="consultaChequesPagadosTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaChequesPagadosTypes";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/consultaCheque/ConsultaChequesPagados/consultaChequesPagadosValidate/";

declare function xf:consultaChequesPagadosValidate($consultaChequesPagados as element(ns0:consultaChequesPagados))
    as xs:string {
        if (fn:string($consultaChequesPagados/TRANSACTION_DATE/text()) = "" ) then (
        	"REQUIRED FIELDS NOT SUPPLIED"
        	
        ) else (
        	""
        	
        )
};

declare variable $consultaChequesPagados as element(ns0:consultaChequesPagados) external;

xf:consultaChequesPagadosValidate($consultaChequesPagados)