(:: pragma bea:global-element-parameter parameter="$consultaCuentaOCategoria" element="ns0:consultaCuentaOCategoria" location="../../xsds/ConsultaCuentaOCategoria/ConsultaCuentaOCategoria.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaCuentaOCategoriaTypes";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/ConsultaCuentaOCategoria/ConsultaCuentaOCategoriaValidate/";

declare function xf:ConsultaCuentaOCategoriaValidate($consultaCuentaOCategoria as element(ns0:consultaCuentaOCategoria))
    as xs:string {
        if(fn:string($consultaCuentaOCategoria/ACCOUNT_NUMBER/text()) = "" ) then (
        	"REQUIRED FIELDS NOT SUPPLIED"
        ) else (
        	""
        ) 
};

declare variable $consultaCuentaOCategoria as element(ns0:consultaCuentaOCategoria) external;

xf:ConsultaCuentaOCategoriaValidate($consultaCuentaOCategoria)