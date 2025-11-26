(:: pragma bea:global-element-parameter parameter="$autenticacionRequestHeader" element="ns2:AutenticacionRequestHeader" location="../../xsds/General/Autenticacion.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$pagoRecaudo" element="ns1:pagoRecaudo" location="../../xsds/PagoRecaudo/PagoRecaudo.xsd" ::)
(:: pragma bea:global-element-return element="ns0:Consultadedetallederecaudo" location="../../xsds/Recaudos/XMLSchema_-1599652964.xsd" ::)

declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/pagoRecaudoTypes";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/PagoRecaudo/ConsultaDetalleRecaudoIn/";

declare function xf:ConsultaDetalleRecaudoIn($autenticacionRequestHeader as element(ns2:AutenticacionRequestHeader),
    $pagoRecaudo as element(ns1:pagoRecaudo))
    as element(ns0:Consultadedetallederecaudo) {
        <ns0:Consultadedetallederecaudo>
            <WebRequestCommon>
                <userName>{ data($autenticacionRequestHeader/UserName) }</userName>
                <password>{ data($autenticacionRequestHeader/Password) }</password>
            </WebRequestCommon>
            <LATAMAGWSPENDINGBILLSType>
                <enquiryInputCollection>
                    <columnName>AGR.CONTRACT.ID</columnName>
                    <criteriaValue>{ data($pagoRecaudo/CONTRACT_ID) }</criteriaValue>
                    <operand>EQ</operand>
                </enquiryInputCollection>
                <enquiryInputCollection>
                    <columnName>DEBTOR.CODE</columnName>
                    <criteriaValue>{ data($pagoRecaudo/DEBTOR_CODE) }</criteriaValue>
                    <operand>EQ</operand>
                </enquiryInputCollection>
                <enquiryInputCollection>
                    <columnName>TXN.CCY</columnName>
                    <criteriaValue>{ data($pagoRecaudo/PAYMENT_INFORMATION/PAYMENT_CURRENCY) }</criteriaValue>
                    <operand>EQ</operand>
                </enquiryInputCollection>
				<enquiryInputCollection>
                    <columnName>CHANNEL.IND</columnName>
                    <criteriaValue>ATM</criteriaValue>
                    <operand>EQ</operand>
                </enquiryInputCollection>                                            
            </LATAMAGWSPENDINGBILLSType>            
        </ns0:Consultadedetallederecaudo>
};

declare variable $autenticacionRequestHeader as element(ns2:AutenticacionRequestHeader) external;
declare variable $pagoRecaudo as element(ns1:pagoRecaudo) external;

xf:ConsultaDetalleRecaudoIn($autenticacionRequestHeader,
    $pagoRecaudo)