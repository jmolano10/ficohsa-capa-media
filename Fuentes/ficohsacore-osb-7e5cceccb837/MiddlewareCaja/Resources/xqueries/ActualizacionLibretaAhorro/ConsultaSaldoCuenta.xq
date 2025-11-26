(:: pragma bea:global-element-parameter parameter="$autenticacionRequestHeader" element="ns2:AutenticacionRequestHeader" location="../../xsds/General/Autenticacion.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$actualizacionLibretaAhorro" element="ns1:actualizacionLibretaAhorro" location="../../xsds/ActualizacionLibretaAhorro/ActualizacionLibretaAhorro.xsd" ::)
(:: pragma bea:global-element-return element="ns0:Consultadesaldodecuenta" location="../../xsds/ConsultasCuenta/XMLSchema_378991004.xsd" ::)

declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/actualizacionLibretaAhorroTypes";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/ActualizacionLibretaAhorro/ConsultaSaldoCuenta/";

declare function xf:ConsultaSaldoCuenta($autenticacionRequestHeader as element(ns2:AutenticacionRequestHeader),
    $actualizacionLibretaAhorro as element(ns1:actualizacionLibretaAhorro))
    as element(ns0:Consultadesaldodecuenta) {
        <ns0:Consultadesaldodecuenta>
            <WebRequestCommon>
                <userName>{ data($autenticacionRequestHeader/UserName) }</userName>
                <password>{ data($autenticacionRequestHeader/Password) }</password>
            </WebRequestCommon>
            <WSFICOACCTBASICDETAILSType>
                <enquiryInputCollection>
                    <columnName>@ID</columnName>
                    <criteriaValue>{ data($actualizacionLibretaAhorro/ACCOUNT_NUMBER) }</criteriaValue>
                    <operand>EQ</operand>
                </enquiryInputCollection>
            </WSFICOACCTBASICDETAILSType>
        </ns0:Consultadesaldodecuenta>
};

declare variable $autenticacionRequestHeader as element(ns2:AutenticacionRequestHeader) external;
declare variable $actualizacionLibretaAhorro as element(ns1:actualizacionLibretaAhorro) external;

xf:ConsultaSaldoCuenta($autenticacionRequestHeader,
    $actualizacionLibretaAhorro)