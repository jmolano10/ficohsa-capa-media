xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$outputParameters1" element="ns0:OutputParameters" location="../../../BusinessServices/DEI/consultaTiposImpuestos/xsd/consultaTiposImpuestos_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns1:consultaTiposImpuestosResponse" location="../xsd/ConsultaTiposImpuestosTypes.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaTiposImpuestos";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/tributosTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaTiposImpuestos/xq/consultaTiposImpuestosOUT/";

declare function xf:consultaTiposImpuestosOUT($outputParameters1 as element(ns0:OutputParameters))
    as element(ns1:consultaTiposImpuestosResponse) {
        <ns1:consultaTiposImpuestosResponse>
            <TYPES_TAXES>
            {
               for $tax at $index in $outputParameters1/ns0:PN_CODIGOIMPUESTO/ns0:PN_CODIGOIMPUESTO_ITEM
               return
                <TYPE_TAX>
                    <ID>{ data($tax ) }</ID>
                    <DESCRIPTION>{ data($outputParameters1/ns0:PV_DESCRIPCION/ns0:PV_DESCRIPCION_ITEM[$index]) }</DESCRIPTION>
                </TYPE_TAX>
            }   
            </TYPES_TAXES>
        </ns1:consultaTiposImpuestosResponse>
};

declare variable $outputParameters1 as element(ns0:OutputParameters) external;

xf:consultaTiposImpuestosOUT($outputParameters1)