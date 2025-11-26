(:: pragma bea:global-element-parameter parameter="$autenticacionRequestHeader" element="ns2:AutenticacionRequestHeader" location="../../xsds/General/Autenticacion.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$pagoRemesas" element="ns1:pagoRemesas" location="../../xsds/PagoRemesas/PagoRemesas.xsd" ::)
(:: pragma bea:global-element-return element="ns0:Consultaderemesa" location="../../xsds/Remesas/XMLSchema_-1855765488.xsd" ::)

declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/pagoRemesasTypes";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/PagoRemesas/ConsultaRemesaIn/";

declare function xf:ConsultaRemesaIn($autenticacionRequestHeader as element(ns2:AutenticacionRequestHeader),
    $pagoRemesas as element(ns1:pagoRemesas))
    as element(ns0:Consultaderemesa) {
        <ns0:Consultaderemesa>
            <WebRequestCommon>
                <userName>{ data($autenticacionRequestHeader/UserName) }</userName>
                <password>{ data($autenticacionRequestHeader/Password) }</password>
            </WebRequestCommon>
            <WSLATAMAGREMITTANCEINFOType>
                <enquiryInputCollection>
                    <columnName>REMITTANCE.KEY</columnName>
                    <criteriaValue>{ data($pagoRemesas/REMITTANCE_ID) }</criteriaValue>
                    <operand>EQ</operand>
                </enquiryInputCollection>
            </WSLATAMAGREMITTANCEINFOType>
        </ns0:Consultaderemesa>
};

declare variable $autenticacionRequestHeader as element(ns2:AutenticacionRequestHeader) external;
declare variable $pagoRemesas as element(ns1:pagoRemesas) external;

xf:ConsultaRemesaIn($autenticacionRequestHeader,
    $pagoRemesas)