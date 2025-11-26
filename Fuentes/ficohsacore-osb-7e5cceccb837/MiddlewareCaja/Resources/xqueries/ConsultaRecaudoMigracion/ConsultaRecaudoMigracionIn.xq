(:: pragma bea:global-element-parameter parameter="$autenticacionRequestHeader" element="ns2:AutenticacionRequestHeader" location="../../xsds/General/Autenticacion.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$consultaRecaudoMigracion" element="ns1:consultaRecaudoMigracion" location="../../xsds/ConsultaRecaudoMigracion/ConsultaRecaudoMigracion.xsd" ::)
(:: pragma bea:global-element-return element="ns0:Consultadedetrecaudomigracion" location="../../xsds/Recaudos/XMLSchema_-1599652964.xsd" ::)

declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaRecaudoMigracionTypes";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/ConsultaRecaudoMigracion/ConsultaRecaudoMigracionIn/";

declare function xf:ConsultaRecaudoMigracionIn($autenticacionRequestHeader as element(ns2:AutenticacionRequestHeader),
    $consultaRecaudoMigracion as element(ns1:consultaRecaudoMigracion))
    as element(ns0:Consultadedetrecaudomigracion) {
        <ns0:Consultadedetrecaudomigracion>
            <WebRequestCommon>
                <userName>{ data($autenticacionRequestHeader/UserName) }</userName>
                <password>{ data($autenticacionRequestHeader/Password) }</password>
            </WebRequestCommon>
            <LATAMAGEPPORTAPPOINTMENTType>
                <enquiryInputCollection>
                    <columnName>AGR.CONTRACT.ID</columnName>
                    <criteriaValue>{ data($consultaRecaudoMigracion/CONTRACT_ID) }</criteriaValue>
                    <operand>EQ</operand>
                </enquiryInputCollection>
                <enquiryInputCollection>
                    <columnName>ID.NUMBER</columnName>
                    <criteriaValue>{ data($consultaRecaudoMigracion/ORD_PARTY_ID) }</criteriaValue>
                    <operand>EQ</operand>
                </enquiryInputCollection>
				<enquiryInputCollection>
                    <columnName>ORD.PARTY.NAME</columnName>
                    <criteriaValue>{ data($consultaRecaudoMigracion/ORD_PARTY_NAME) }</criteriaValue>
                    <operand>EQ</operand>
                </enquiryInputCollection>
                <enquiryInputCollection>
                    <columnName>REQUEST.TYPE</columnName>
                    <criteriaValue>{ data($consultaRecaudoMigracion/REQUEST_TYPE) }</criteriaValue>
                    <operand>EQ</operand>
                </enquiryInputCollection>
                <enquiryInputCollection>
                    <columnName>REQ.CITY</columnName>
                    <criteriaValue>{ data($consultaRecaudoMigracion/REQUEST_CITY) }</criteriaValue>
                    <operand>EQ</operand>
                </enquiryInputCollection>
                <enquiryInputCollection>
                    <columnName>DURATION</columnName>
                    <criteriaValue>{ data($consultaRecaudoMigracion/PASSPORT_DURATION) }</criteriaValue>
                    <operand>EQ</operand>
                </enquiryInputCollection>
                <enquiryInputCollection>
                    <columnName>PAY.CCY</columnName>
                    <criteriaValue>{ data($consultaRecaudoMigracion/PAYMENT_CURRENCY) }</criteriaValue>
                    <operand>EQ</operand>
                </enquiryInputCollection>   
            </LATAMAGEPPORTAPPOINTMENTType>
        </ns0:Consultadedetrecaudomigracion>
};

declare variable $autenticacionRequestHeader as element(ns2:AutenticacionRequestHeader) external;
declare variable $consultaRecaudoMigracion as element(ns1:consultaRecaudoMigracion) external;

xf:ConsultaRecaudoMigracionIn($autenticacionRequestHeader,
    $consultaRecaudoMigracion)