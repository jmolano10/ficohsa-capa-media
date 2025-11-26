(:: pragma bea:global-element-parameter parameter="$autenticacionRequestHeader" element="ns2:AutenticacionRequestHeader" location="../../xsds/General/Autenticacion.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$cancelacionCuentaAhorros" element="ns1:cancelacionCuentaAhorros" location="../../xsds/CancelacionCuentaAhorros/CancelacionCuentaAhorros.xsd" ::)
(:: pragma bea:global-element-return element="ns0:Cancelaciondecuentaparte1" location="../../xsds/CancelacionCuenta/XMLSchema_1790235882.xsd" ::)

declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/cancelacionCuentaAhorrosTypes";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/CancelacionCuentaAhorros/CancelacionCuentaAhorrosParte1In/";

declare function xf:CancelacionCuentaAhorrosParte1In($autenticacionRequestHeader as element(ns2:AutenticacionRequestHeader),
    $cancelacionCuentaAhorros as element(ns1:cancelacionCuentaAhorros))
    as element(ns0:Cancelaciondecuentaparte1) {
        <ns0:Cancelaciondecuentaparte1>
            <WebRequestCommon>
                <userName>{ data($autenticacionRequestHeader/UserName) }</userName>
                <password>{ data($autenticacionRequestHeader/Password) }</password>
            </WebRequestCommon>
            <OfsFunction>
                <noOfAuth>1</noOfAuth>
            </OfsFunction>
            <ACCOUNTCLOSUREFICOHNCAJATTType id = "{ data($cancelacionCuentaAhorros/ACCOUNT_NUMBER) }">
                <CLOSEONLINE>Y</CLOSEONLINE>
                <CLOSEMODE>T</CLOSEMODE>
                <HNCACTA>{ data($cancelacionCuentaAhorros/CANCEL_MOTIVE) }</HNCACTA>
            </ACCOUNTCLOSUREFICOHNCAJATTType>
        </ns0:Cancelaciondecuentaparte1>
};

declare variable $autenticacionRequestHeader as element(ns2:AutenticacionRequestHeader) external;
declare variable $cancelacionCuentaAhorros as element(ns1:cancelacionCuentaAhorros) external;

xf:CancelacionCuentaAhorrosParte1In($autenticacionRequestHeader,
    $cancelacionCuentaAhorros)