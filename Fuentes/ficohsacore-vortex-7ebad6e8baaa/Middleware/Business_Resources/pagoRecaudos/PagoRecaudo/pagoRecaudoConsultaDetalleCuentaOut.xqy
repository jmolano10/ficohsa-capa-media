xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultadedetallesdelacuentaResponse" element="ns0:ConsultadedetallesdelacuentaResponse" location="../../ConsultasCuenta/Resources/XMLSchema_378991004.xsd" ::)

declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/pagoRecaudos/PagoRecaudo/pagoRecaudoConsultaDetalleCuentaOut/";

declare function xf:pagoRecaudoConsultaDetalleCuentaOut($consultadedetallesdelacuentaResponse as element(ns0:ConsultadedetallesdelacuentaResponse))
    as xs:string {
        if (fn:string($consultadedetallesdelacuentaResponse/WSACCOUNTLISTType[1]/gWSACCOUNTLISTDetailType/mWSACCOUNTLISTDetailType[1]/ALTACCTID/text()) != "") then (
        	fn:string($consultadedetallesdelacuentaResponse/WSACCOUNTLISTType[1]/gWSACCOUNTLISTDetailType/mWSACCOUNTLISTDetailType[1]/ALTACCTID/text())
        ) else (
        	fn:string($consultadedetallesdelacuentaResponse/WSACCOUNTLISTType[1]/gWSACCOUNTLISTDetailType/mWSACCOUNTLISTDetailType[1]/ID/text())
        )
};

declare variable $consultadedetallesdelacuentaResponse as element(ns0:ConsultadedetallesdelacuentaResponse) external;

xf:pagoRecaudoConsultaDetalleCuentaOut($consultadedetallesdelacuentaResponse)