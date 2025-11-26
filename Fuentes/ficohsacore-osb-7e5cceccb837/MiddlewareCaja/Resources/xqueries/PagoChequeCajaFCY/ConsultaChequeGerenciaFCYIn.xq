(:: pragma bea:global-element-parameter parameter="$autenticacionRequestHeader" element="ns2:AutenticacionRequestHeader" location="../../xsds/General/Autenticacion.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$pagoChequeCajaFCY" element="ns1:pagoChequeCajaFCY" location="../../xsds/PagoChequeCajaFCY/PagoChequeCajaFCY.xsd" ::)
(:: pragma bea:global-element-return element="ns0:ConsultadechequedegerenciaFCY" location="../../xsds/ChequeGerencia/XMLSchema_-1805424041.xsd" ::)

declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/pagoChequeCajaFCYTypes";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/PagoChequeCajaFCY/ConsultaChequeGerenciaFCYIn/";

declare function xf:ConsultaChequeGerenciaFCYIn($autenticacionRequestHeader as element(ns2:AutenticacionRequestHeader),
    $pagoChequeCajaFCY as element(ns1:pagoChequeCajaFCY))
    as element(ns0:ConsultadechequedegerenciaFCY) {
        <ns0:ConsultadechequedegerenciaFCY>
            <WebRequestCommon>
                <userName>{ data($autenticacionRequestHeader/UserName) }</userName>
                <password>{ data($autenticacionRequestHeader/Password) }</password>
            </WebRequestCommon>
            <FICOHNFCYDRAFTDETAILSWSType>
                <enquiryInputCollection>
                    <columnName>CHEQUE.NUMBER</columnName>
                    <criteriaValue>{ data($pagoChequeCajaFCY/CHECK_NUMBER) }</criteriaValue>
                    <operand>EQ</operand>
                </enquiryInputCollection>
                <enquiryInputCollection>
                    <columnName>CURRENCY</columnName>
                    <criteriaValue>{ data($pagoChequeCajaFCY/CHECK_CURRENCY) }</criteriaValue>
                    <operand>EQ</operand>
                </enquiryInputCollection>
                <enquiryInputCollection>
                    <columnName>AMOUNT</columnName>
                    <criteriaValue>{ data($pagoChequeCajaFCY/CHECK_AMOUNT) }</criteriaValue>
                    <operand>EQ</operand>
                </enquiryInputCollection>
            </FICOHNFCYDRAFTDETAILSWSType>
        </ns0:ConsultadechequedegerenciaFCY>
};

declare variable $autenticacionRequestHeader as element(ns2:AutenticacionRequestHeader) external;
declare variable $pagoChequeCajaFCY as element(ns1:pagoChequeCajaFCY) external;

xf:ConsultaChequeGerenciaFCYIn($autenticacionRequestHeader,
    $pagoChequeCajaFCY)