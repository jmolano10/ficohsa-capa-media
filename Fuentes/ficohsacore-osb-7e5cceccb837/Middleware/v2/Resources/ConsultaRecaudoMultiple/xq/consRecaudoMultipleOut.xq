(:: pragma bea:global-element-parameter parameter="$consultaRecaudoMultipleResponse1" element="ns0:consultaRecaudoMultipleResponse" location="../../../BusinessServices/SJS/consultaRecaudoMultiple/xsd/sjConsultaRecaudoMultipleTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:consultaRecaudoMultipleResponse" location="../xsd/consultaRecaudoMultipleTypes.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaRecaudoMultipleTypes";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/sjConsultaRecaudoMultipleTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaRecaudoMultiple/xq/consRecaudoMultipleOut/";

declare function xf:consRecaudoMultipleOut($consultaRecaudoMultipleResponse1 as element(ns0:consultaRecaudoMultipleResponse))
    as element(ns1:consultaRecaudoMultipleResponse) {
        <ns1:consultaRecaudoMultipleResponse>
            <AGREEMENTS>{ $consultaRecaudoMultipleResponse1/AGREEMENTS/@* , $consultaRecaudoMultipleResponse1/AGREEMENTS/node() }</AGREEMENTS>
        </ns1:consultaRecaudoMultipleResponse>
};

declare variable $consultaRecaudoMultipleResponse1 as element(ns0:consultaRecaudoMultipleResponse) external;

xf:consRecaudoMultipleOut($consultaRecaudoMultipleResponse1)