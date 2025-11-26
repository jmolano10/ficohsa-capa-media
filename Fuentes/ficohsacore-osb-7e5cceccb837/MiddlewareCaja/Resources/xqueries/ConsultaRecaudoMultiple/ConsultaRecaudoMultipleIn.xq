(:: pragma bea:global-element-parameter parameter="$autenticacionRequestHeader" element="ns2:AutenticacionRequestHeader" location="../../xsds/General/Autenticacion.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$consultaRecaudoMultiple" element="ns1:consultaRecaudoMultiple" location="../../xsds/ConsultaRecaudoMultiple/ConsultaRecaudoMultiple.xsd" ::)
(:: pragma bea:global-element-return element="ns0:Consultadedetallederecaudo" location="../../xsds/Recaudos/XMLSchema_-1599652964.xsd" ::)

declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaRecaudoMultipleTypes";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/ConsultaRecaudoMultiple/ConsultaRecaudoMultipleIn/";

declare function xf:ConsultaRecaudoMultipleIn($autenticacionRequestHeader as element(ns2:AutenticacionRequestHeader),
    $consultaRecaudoMultiple as element(ns1:consultaRecaudoMultiple))
    as element(ns0:Consultadedetallederecaudo) {
        <ns0:Consultadedetallederecaudo>
            <WebRequestCommon>
                <userName>{ data($autenticacionRequestHeader/UserName) }</userName>
                <password>{ data($autenticacionRequestHeader/Password) }</password>
            </WebRequestCommon>
            <LATAMAGWSPENDINGBILLSType>
                <enquiryInputCollection>
                    <columnName>AGR.CONTRACT.ID</columnName>
                    <criteriaValue>{ data($consultaRecaudoMultiple/CONTRACT_ID) }</criteriaValue>
                    <operand>EQ</operand>
                </enquiryInputCollection>
                <enquiryInputCollection>
                    <columnName>DEBTOR.CODE</columnName>
                    <criteriaValue>{ data($consultaRecaudoMultiple/DEBTOR_CODE) }</criteriaValue>
                    <operand>EQ</operand>
                </enquiryInputCollection>
                <enquiryInputCollection>
                    <columnName>TXN.CCY</columnName>
                    <criteriaValue>{ data($consultaRecaudoMultiple/CURRENCY) }</criteriaValue>
                    <operand>EQ</operand>
                </enquiryInputCollection>
                <enquiryInputCollection>
                    <columnName>CHANNEL.IND</columnName>
                    <criteriaValue>OTHER</criteriaValue>
                    <operand>EQ</operand>
                </enquiryInputCollection>                                              
            </LATAMAGWSPENDINGBILLSType>
        </ns0:Consultadedetallederecaudo>
};

declare variable $autenticacionRequestHeader as element(ns2:AutenticacionRequestHeader) external;
declare variable $consultaRecaudoMultiple as element(ns1:consultaRecaudoMultiple) external;

xf:ConsultaRecaudoMultipleIn($autenticacionRequestHeader,
    $consultaRecaudoMultiple)