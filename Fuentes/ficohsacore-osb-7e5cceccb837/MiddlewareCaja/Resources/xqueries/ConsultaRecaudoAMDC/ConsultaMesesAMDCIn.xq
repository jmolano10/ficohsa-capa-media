(:: pragma bea:global-element-parameter parameter="$autenticacionRequestHeader" element="ns2:AutenticacionRequestHeader" location="../../xsds/General/Autenticacion.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$consultaRecaudoAMDC" element="ns0:consultaRecaudoAMDC" location="../../xsds/ConsultaRecaudoAMDC/ConsultaRecaudoAMDC.xsd" ::)
(:: pragma bea:global-element-return element="ns1:Consultadedetrecaudoamdcmeses" location="../../xsds/Recaudos/XMLSchema_-1599652964.xsd" ::)

declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "T24WebServicesImpl";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaRecaudoAMDCTypes";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/ConsultaRecaudoAMDC/ConsultaMesesAMDCIn/";

declare function xf:ConsultaMesesAMDCIn($autenticacionRequestHeader as element(ns2:AutenticacionRequestHeader),
    $consultaRecaudoAMDC as element(ns0:consultaRecaudoAMDC))
    as element(ns1:Consultadedetrecaudoamdcmeses) {
        <ns1:Consultadedetrecaudoamdcmeses>
            <WebRequestCommon>
                <userName>{ data($autenticacionRequestHeader/UserName) }</userName>
                <password>{ data($autenticacionRequestHeader/Password) }</password>
            </WebRequestCommon>
            <LATAMAGWSPROPMONTHSType>
                <enquiryInputCollection>
                    <columnName>AGR.CONTRACT.ID</columnName>
                    <criteriaValue>{ data($consultaRecaudoAMDC/CONTRACT_ID) }</criteriaValue>
                    <operand>EQ</operand>
                </enquiryInputCollection>
                <enquiryInputCollection>
                    <columnName>LAND.VALUE.NO</columnName>
                    <criteriaValue>{ data($consultaRecaudoAMDC/DEBTOR_CODE) }</criteriaValue>
                    <operand>EQ</operand>
                </enquiryInputCollection>
                <enquiryInputCollection>
                    <columnName>YEAR.TO.PAY</columnName>
                    <criteriaValue>{ data($consultaRecaudoAMDC/YEAR_TO_PAY) }</criteriaValue>
                    <operand>EQ</operand>
                </enquiryInputCollection>                                
            </LATAMAGWSPROPMONTHSType>
        </ns1:Consultadedetrecaudoamdcmeses>
};

declare variable $autenticacionRequestHeader as element(ns2:AutenticacionRequestHeader) external;
declare variable $consultaRecaudoAMDC as element(ns0:consultaRecaudoAMDC) external;

xf:ConsultaMesesAMDCIn($autenticacionRequestHeader,
    $consultaRecaudoAMDC)