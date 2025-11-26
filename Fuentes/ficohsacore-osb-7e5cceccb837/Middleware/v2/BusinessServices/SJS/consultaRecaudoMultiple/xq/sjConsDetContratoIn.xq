(:: pragma bea:local-element-parameter parameter="$aGREEMENT1" type="ns1:consultaRecaudoMultiple/AGREEMENTS/AGREEMENT" location="../../../../Resources/ConsultaRecaudoMultiple/xsd/consultaRecaudoMultipleTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:consultaDetalleContratoRecaudos" location="../../../../Resources/ConsultaDetalleContratoRecaudos/xsd/consultaDetalleContratoRecaudosTypes.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaRecaudoMultipleTypes";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaDetalleContratoRecaudosTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/BusinessServices/SJS/consultaRecaudoMultiple/xq/consDetContratoIn/";

declare function xf:consDetContratoIn($aGREEMENT1 as element())
    as element(ns0:consultaDetalleContratoRecaudos) {
        <ns0:consultaDetalleContratoRecaudos>
            <CONTRACT_ID>{ data($aGREEMENT1/ID) }</CONTRACT_ID>
        </ns0:consultaDetalleContratoRecaudos>
};

declare variable $aGREEMENT1 as element() external;

xf:consDetContratoIn($aGREEMENT1)