<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultadefechadelsistemaResponse1" element="ns0:ConsultadefechadelsistemaResponse" location="../Resources/XMLSchema_1632682327.xsd" ::)
(:: pragma bea:global-element-return element="ns1:consultaFechaSistemaResponse" location="consultaFechaSistemaTypes.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaFechaSistemaTypes";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/Core/consultaFechaSistema/consultaFechaSistemaOut/";

declare function xf:consultaFechaSistemaOut($consultadefechadelsistemaResponse1 as element(ns0:ConsultadefechadelsistemaResponse))
    as element(ns1:consultaFechaSistemaResponse) {
        <ns1:consultaFechaSistemaResponse>
            <ns1:consultaFechaSistemaResponseType>
                {
                    for $mWSDATESDetailType in $consultadefechadelsistemaResponse1/WSDATESType[1]/gWSDATESDetailType/mWSDATESDetailType
                    return
                        <ns1:consultaFechaSistemaResponseRecordType>
                            {
                                for $TODAY in $mWSDATESDetailType/TODAY
                                return
                                    <WORKING_DATE>{ data($TODAY) }</WORKING_DATE>
                            }
                            {
                                for $JULIANDATE in $mWSDATESDetailType/JULIANDATE
                                return
                                    <JULIAN_DATE>{ data($JULIANDATE) }</JULIAN_DATE>
                            }
                            {
                                for $NEXTWORKINGDAY in $mWSDATESDetailType/NEXTWORKINGDAY
                                return
                                    <NEXT_WORKING_DATE>{ data($NEXTWORKINGDAY) }</NEXT_WORKING_DATE>
                            }
                        </ns1:consultaFechaSistemaResponseRecordType>
                }
            </ns1:consultaFechaSistemaResponseType>
        </ns1:consultaFechaSistemaResponse>
};

declare variable $consultadefechadelsistemaResponse1 as element(ns0:ConsultadefechadelsistemaResponse) external;

xf:consultaFechaSistemaOut($consultadefechadelsistemaResponse1)]]></con:xquery>
    <con:dependency location="../Resources/XMLSchema_1632682327.xsd">
        <con:schema ref="Middleware/Business_Resources/Core/Resources/XMLSchema_1632682327"/>
    </con:dependency>
    <con:dependency location="consultaFechaSistemaTypes.xsd">
        <con:schema ref="Middleware/Business_Resources/Core/consultaFechaSistema/consultaFechaSistemaTypes"/>
    </con:dependency>
</con:xqueryEntry>