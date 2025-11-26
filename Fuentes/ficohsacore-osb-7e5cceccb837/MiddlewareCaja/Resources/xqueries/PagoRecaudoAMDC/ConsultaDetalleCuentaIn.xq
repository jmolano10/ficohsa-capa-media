(:: pragma bea:global-element-parameter parameter="$pagoRecaudoAMDCResponse" element="ns0:pagoRecaudoAMDCResponse" location="../../xsds/PagoRecaudoAMDC/PagoRecaudoAMDC.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$autenticacionRequestHeader" element="ns2:AutenticacionRequestHeader" location="../../xsds/General/Autenticacion.xsd" ::)
(:: pragma bea:global-element-return element="ns1:Consultadedetallesdelacuenta" location="../../xsds/ConsultasCuenta/XMLSchema_378991004.xsd" ::)

declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "T24WebServicesImpl";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/pagoRecaudoAMDCTypes";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/PagoRecaudoAMDC/ConsultaDetalleCuentaIn/";

declare function xf:ConsultaDetalleCuentaIn($pagoRecaudoAMDCResponse as element(ns0:pagoRecaudoAMDCResponse),
    $autenticacionRequestHeader as element(ns2:AutenticacionRequestHeader))
    as element(ns1:Consultadedetallesdelacuenta) {
        <ns1:Consultadedetallesdelacuenta>
            <WebRequestCommon>
                <userName>{ data($autenticacionRequestHeader/UserName) }</userName>
                <password>{ data($autenticacionRequestHeader/Password) }</password>
            </WebRequestCommon>
            <WSACCOUNTLISTType>
                <enquiryInputCollection>
                    <columnName>@ID</columnName>
                    {
                        for $DEBIT_ACCOUNT in $pagoRecaudoAMDCResponse/PAYMENT_INFORMATION/DEBIT_ACCOUNT
                        return
                            <criteriaValue>{ data($DEBIT_ACCOUNT) }</criteriaValue>
                    }
                    <operand>EQ</operand>
                </enquiryInputCollection>
            </WSACCOUNTLISTType>
        </ns1:Consultadedetallesdelacuenta>
};

declare variable $pagoRecaudoAMDCResponse as element(ns0:pagoRecaudoAMDCResponse) external;
declare variable $autenticacionRequestHeader as element(ns2:AutenticacionRequestHeader) external;

xf:ConsultaDetalleCuentaIn($pagoRecaudoAMDCResponse,
    $autenticacionRequestHeader)