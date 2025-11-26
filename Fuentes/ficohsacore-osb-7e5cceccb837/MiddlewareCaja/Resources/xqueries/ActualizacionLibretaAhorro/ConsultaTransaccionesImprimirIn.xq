(:: pragma bea:global-element-parameter parameter="$autenticacionRequestHeader" element="ns2:AutenticacionRequestHeader" location="../../xsds/General/Autenticacion.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$actualizacionLibretaAhorro" element="ns1:actualizacionLibretaAhorro" location="../../xsds/ActualizacionLibretaAhorro/ActualizacionLibretaAhorro.xsd" ::)
(:: pragma bea:global-element-return element="ns0:TellerPassbookEnquiry" location="../../xsds/BkFicPBookEnq/XMLSchema_-1374990530.xsd" ::)

declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/actualizacionLibretaAhorroTypes";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/ActualizacionLibretaAhorro/ConsultaTransaccionesImprimirIn/";

declare function xf:ConsultaTransaccionesImprimirIn($autenticacionRequestHeader as element(ns2:AutenticacionRequestHeader),
    $actualizacionLibretaAhorro as element(ns1:actualizacionLibretaAhorro))
    as element(ns0:TellerPassbookEnquiry) {
        <ns0:TellerPassbookEnquiry>
            <WebRequestCommon>
                <userName>{ data($autenticacionRequestHeader/UserName) }</userName>
                <password>{ data($autenticacionRequestHeader/Password) }</password>
            </WebRequestCommon>
            <NOFILETTTWSEXPType>
                <enquiryInputCollection>
                    <columnName>ACCOUNT.NO</columnName>
                    <criteriaValue>{ data($actualizacionLibretaAhorro/ACCOUNT_NUMBER) }</criteriaValue>
                    <operand>EQ</operand>
                </enquiryInputCollection>
            </NOFILETTTWSEXPType>
        </ns0:TellerPassbookEnquiry>
};

declare variable $autenticacionRequestHeader as element(ns2:AutenticacionRequestHeader) external;
declare variable $actualizacionLibretaAhorro as element(ns1:actualizacionLibretaAhorro) external;

xf:ConsultaTransaccionesImprimirIn($autenticacionRequestHeader,
    $actualizacionLibretaAhorro)