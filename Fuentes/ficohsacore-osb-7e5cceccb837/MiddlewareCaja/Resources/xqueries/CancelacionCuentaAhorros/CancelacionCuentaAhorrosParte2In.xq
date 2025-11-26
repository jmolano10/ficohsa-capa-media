(:: pragma bea:global-element-parameter parameter="$autenticacionRequestHeader" element="ns1:AutenticacionRequestHeader" location="../../xsds/General/Autenticacion.xsd" ::)
(:: pragma bea:global-element-return element="ns0:Cancelaciondecuentaparte2" location="../../xsds/CancelacionCuenta/XMLSchema_1790235882.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/CancelacionCuentaAhorros/CancelacionCuentaAhorrosParte2In/";

declare function xf:CancelacionCuentaAhorrosParte2In($autenticacionRequestHeader as element(ns1:AutenticacionRequestHeader),
    $account as xs:string)
    as element(ns0:Cancelaciondecuentaparte2) {
        <ns0:Cancelaciondecuentaparte2>
            <WebRequestCommon>
                <userName>{ data($autenticacionRequestHeader/UserName) }</userName>
                <password>{ data($autenticacionRequestHeader/Password) }</password>
            </WebRequestCommon>
            <OfsFunction>
                <gtsControl/>
                <messageId/>
                <noOfAuth/>
                <replace/>
            </OfsFunction>
            <TELLERFICOHNACCTCLOSEType>
                <ACCOUNTNO>{ $account }</ACCOUNTNO>
            </TELLERFICOHNACCTCLOSEType>
        </ns0:Cancelaciondecuentaparte2>
};

declare variable $autenticacionRequestHeader as element(ns1:AutenticacionRequestHeader) external;
declare variable $account as xs:string external;

xf:CancelacionCuentaAhorrosParte2In($autenticacionRequestHeader,
    $account)