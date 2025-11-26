(:: pragma bea:global-element-parameter parameter="$autenticacionRequestHeader" element="ns2:AutenticacionRequestHeader" location="../../xsds/General/Autenticacion.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$depositoChequeCajaFCY" element="ns0:depositoChequeCajaFCY" location="../../xsds/DepositoChequeCajaFCY/DepositoChequeCajaFCY.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ConsultadechequedegerenciaFCY" location="../../xsds/ChequeGerencia/XMLSchema_-1805424041.xsd" ::)

declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "T24WebServicesImpl";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/depositoChequeCajaFCYTypes";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/DepositoChequeGerencia/ConsultaChequeGerenciaFCYIn/";

declare function xf:ConsultaChequeGerenciaFCYIn($autenticacionRequestHeader as element(ns2:AutenticacionRequestHeader),
    $depositoChequeCajaFCY as element(ns0:depositoChequeCajaFCY))
    as element(ns1:ConsultadechequedegerenciaFCY) {
        <ns1:ConsultadechequedegerenciaFCY>
            <WebRequestCommon>
                <userName>{ data($autenticacionRequestHeader/UserName) }</userName>
                <password>{ data($autenticacionRequestHeader/Password) }</password>
            </WebRequestCommon>
            <FICOHNFCYDRAFTDETAILSWSType>
                <enquiryInputCollection>
                    <columnName>CHEQUE.NUMBER</columnName>
                    <criteriaValue>{ data($depositoChequeCajaFCY/CHECK_NUMBER) }</criteriaValue>
                    <operand>EQ</operand>
                </enquiryInputCollection>
                <enquiryInputCollection>
                    <columnName>CURRENCY</columnName>
                    <criteriaValue>{ data($depositoChequeCajaFCY/CHECK_CURRENCY) }</criteriaValue>
                    <operand>EQ</operand>
                </enquiryInputCollection>
                <enquiryInputCollection>
                    <columnName>AMOUNT</columnName>
                    <criteriaValue>{ data($depositoChequeCajaFCY/CHECK_AMOUNT) }</criteriaValue>
                    <operand>EQ</operand>
                </enquiryInputCollection>
            </FICOHNFCYDRAFTDETAILSWSType>
        </ns1:ConsultadechequedegerenciaFCY>
};

declare variable $autenticacionRequestHeader as element(ns2:AutenticacionRequestHeader) external;
declare variable $depositoChequeCajaFCY as element(ns0:depositoChequeCajaFCY) external;

xf:ConsultaChequeGerenciaFCYIn($autenticacionRequestHeader,
    $depositoChequeCajaFCY)