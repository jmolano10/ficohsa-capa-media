(:: pragma bea:global-element-parameter parameter="$autenticacionRequestHeader" element="ns1:AutenticacionRequestHeader" location="../../xsds/General/Autenticacion.xsd" ::)
(:: pragma bea:global-element-return element="ns0:Consultadecliente" location="../../xsds/ConsultasCliente/XMLSchema_1144838292.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/RegistrarRTE/ConsultaClienteIn/";

declare function xf:ConsultaClienteIn($autenticacionRequestHeader as element(ns1:AutenticacionRequestHeader),
    $clientID as xs:string)
    as element(ns0:Consultadecliente) {
        <ns0:Consultadecliente>
            <WebRequestCommon>
                <userName>{ data($autenticacionRequestHeader/UserName) }</userName>
                <password>{ data($autenticacionRequestHeader/Password) }</password>
            </WebRequestCommon>
            <WSCUSTOMERType>
                <enquiryInputCollection>
                    <columnName>LR.INDX.LEGALID</columnName>
                    <criteriaValue>{ $clientID }</criteriaValue>
                    <operand>EQ</operand>
                </enquiryInputCollection>
            </WSCUSTOMERType>
        </ns0:Consultadecliente>
};

declare variable $autenticacionRequestHeader as element(ns1:AutenticacionRequestHeader) external;
declare variable $clientID as xs:string external;

xf:ConsultaClienteIn($autenticacionRequestHeader,
    $clientID)