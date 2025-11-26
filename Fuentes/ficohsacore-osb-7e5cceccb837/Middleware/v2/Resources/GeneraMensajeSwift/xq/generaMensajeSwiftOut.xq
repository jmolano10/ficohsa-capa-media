(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns1:OutputParameters" location="../../../BusinessServices/PWS/generaMensajeSwift/xsd/generaMensajeSwift_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns0:generaMensajeSwiftResponse" location="../xsd/generaMensajeSwiftTypes.xsd" ::)

declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/generaMensajeSwift";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/generaMensajeSwiftTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/GeneraMensajeSwift/xq/generaMensajeSwiftOut/";

declare function xf:generaMensajeSwiftOut($outputParameters as element(ns1:OutputParameters),
    $uniqueReference as xs:string)
    as element(ns0:generaMensajeSwiftResponse) {
        <ns0:generaMensajeSwiftResponse>
            {
                for $PV_REFERENCIA_SWIFT in $outputParameters/ns1:PV_REFERENCIA_SWIFT
                return
                    <REFERENCE_SWIFT>{ data($PV_REFERENCIA_SWIFT) }</REFERENCE_SWIFT>
            }
            <UNIQUE_REFERENCE>{ $uniqueReference }</UNIQUE_REFERENCE>
        </ns0:generaMensajeSwiftResponse>
};

declare variable $outputParameters as element(ns1:OutputParameters) external;
declare variable $uniqueReference as xs:string external;

xf:generaMensajeSwiftOut($outputParameters,
    $uniqueReference)