(:: pragma bea:global-element-parameter parameter="$consultaEstadoChequeCertificado" element="ns0:consultaEstadoChequeCertificado" location="../../xsds/ConsultaEstadoChequeCertificado/ConsultaEstadoChequeCertificado.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaEstadoChequeCertificadoTypes";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/ConsultaEstadoChequeCertificado/ConsultaEstadoChequeCertificadoValidate/";

declare function xf:ConsultaEstadoChequeCertificadoValidate($consultaEstadoChequeCertificado as element(ns0:consultaEstadoChequeCertificado))
    as xs:string {
        if (fn:string($consultaEstadoChequeCertificado/ACCOUNT_NUMBER/text()) = "" or 
        	fn:string($consultaEstadoChequeCertificado/CHEQUE_NUMBER/text()) = "") then (
        	"REQUIRED FIELDS NOT SUPPLIED"		
        ) else (
        	""
        )
};

declare variable $consultaEstadoChequeCertificado as element(ns0:consultaEstadoChequeCertificado) external;

xf:ConsultaEstadoChequeCertificadoValidate($consultaEstadoChequeCertificado)