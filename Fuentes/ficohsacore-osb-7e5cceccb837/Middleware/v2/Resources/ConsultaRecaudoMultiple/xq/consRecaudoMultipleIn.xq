(:: pragma bea:global-element-parameter parameter="$consultaRecaudoMultiple1" element="ns1:consultaRecaudoMultiple" location="../xsd/consultaRecaudoMultipleTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:consultaRecaudoMultiple" location="../../../BusinessServices/SJS/consultaRecaudoMultiple/xsd/sjConsultaRecaudoMultipleTypes.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaRecaudoMultipleTypes";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/sjConsultaRecaudoMultipleTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaRecaudoMultiple/xq/consRecaudoMultipleIn/";

declare function xf:consRecaudoMultipleIn($consultaRecaudoMultiple1 as element(ns1:consultaRecaudoMultiple))
    as element(ns0:consultaRecaudoMultiple) {
        <ns0:consultaRecaudoMultiple>
            <AGREEMENTS>{ $consultaRecaudoMultiple1/AGREEMENTS/@* , $consultaRecaudoMultiple1/AGREEMENTS/node() }</AGREEMENTS>
        </ns0:consultaRecaudoMultiple>
};

declare variable $consultaRecaudoMultiple1 as element(ns1:consultaRecaudoMultiple) external;

xf:consRecaudoMultipleIn($consultaRecaudoMultiple1)