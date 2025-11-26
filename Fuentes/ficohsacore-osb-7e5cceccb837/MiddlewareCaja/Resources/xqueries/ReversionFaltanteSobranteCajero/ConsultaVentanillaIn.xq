(:: pragma bea:global-element-parameter parameter="$autenticacionRequestHeader" element="ns2:AutenticacionRequestHeader" location="../../xsds/General/Autenticacion.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$reversionFaltanteSobranteCajero" element="ns1:reversionFaltanteSobranteCajero" location="../../xsds/ReversionFaltanteSobranteCajero/ReversionFaltanteSobranteCajero.xsd" ::)
(:: pragma bea:global-element-return element="ns0:Consultadeventanilla" location="../../xsds/Core/XMLSchema_1632682327.xsd" ::)

declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/reversionFaltanteSobranteCajeroTypes";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/ReversionFaltanteSobranteCajero/ConsultaVentanillaIn/";

declare function xf:ConsultaVentanillaIn($autenticacionRequestHeader as element(ns2:AutenticacionRequestHeader),
    $reversionFaltanteSobranteCajero as element(ns1:reversionFaltanteSobranteCajero))
    as element(ns0:Consultadeventanilla) {
        <ns0:Consultadeventanilla>
            <WebRequestCommon>
                <userName>{ data($autenticacionRequestHeader/UserName) }</userName>
                <password>{ data($autenticacionRequestHeader/Password) }</password>
            </WebRequestCommon>
            <WSTELLERIDENQType>
                <enquiryInputCollection>
                    <columnName>@ID</columnName>
                    {
                        for $TELLER_ID in $reversionFaltanteSobranteCajero/TELLER_ID
                        return
                            <criteriaValue>{ concat("""", fn-bea:pad-left($TELLER_ID, 4, "0"), """") }</criteriaValue>
                    }
                    <operand>LK</operand>
                </enquiryInputCollection>
            </WSTELLERIDENQType>
        </ns0:Consultadeventanilla>
};

declare variable $autenticacionRequestHeader as element(ns2:AutenticacionRequestHeader) external;
declare variable $reversionFaltanteSobranteCajero as element(ns1:reversionFaltanteSobranteCajero) external;

xf:ConsultaVentanillaIn($autenticacionRequestHeader,
    $reversionFaltanteSobranteCajero)