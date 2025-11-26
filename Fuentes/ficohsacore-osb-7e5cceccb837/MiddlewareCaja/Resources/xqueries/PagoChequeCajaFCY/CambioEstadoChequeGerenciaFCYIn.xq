(:: pragma bea:global-element-parameter parameter="$autenticacionRequestHeader" element="ns2:AutenticacionRequestHeader" location="../../xsds/General/Autenticacion.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$pagoChequeCajaFCY" element="ns1:pagoChequeCajaFCY" location="../../xsds/PagoChequeCajaFCY/PagoChequeCajaFCY.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$consultadechequedegerenciaFCYResponse" element="ns0:ConsultadechequedegerenciaFCYResponse" location="../../xsds/ChequeGerencia/XMLSchema_-1805424041.xsd" ::)
(:: pragma bea:global-element-return element="ns0:CambioestadochqgerenciaFCY" location="../../xsds/ChequeGerencia/XMLSchema_-1805424041.xsd" ::)

declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/pagoChequeCajaFCYTypes";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/PagoChequeCajaFCY/CambioEstadoChequeGerenciaFCYIn/";

declare function xf:CambioEstadoChequeGerenciaFCYIn($autenticacionRequestHeader as element(ns2:AutenticacionRequestHeader),
    $pagoChequeCajaFCY as element(ns1:pagoChequeCajaFCY),
    $consultadechequedegerenciaFCYResponse as element(ns0:ConsultadechequedegerenciaFCYResponse))
    as element(ns0:CambioestadochqgerenciaFCY) {
        <ns0:CambioestadochqgerenciaFCY>
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
            <FICOFCYDRAFTDETAILSFICOHNINPUTWSType id = "{ concat(fn:string($consultadechequedegerenciaFCYResponse/FICOHNFCYDRAFTDETAILSWSType[1]/gFICOHNFCYDRAFTDETAILSWSDetailType/mFICOHNFCYDRAFTDETAILSWSDetailType[1]/Nostro/text()),".", fn:string($pagoChequeCajaFCY/CHECK_NUMBER/text())) }">
                <ChequeStatus>LOCALLY.PAID</ChequeStatus>
            </FICOFCYDRAFTDETAILSFICOHNINPUTWSType>
        </ns0:CambioestadochqgerenciaFCY>
};

declare variable $autenticacionRequestHeader as element(ns2:AutenticacionRequestHeader) external;
declare variable $pagoChequeCajaFCY as element(ns1:pagoChequeCajaFCY) external;
declare variable $consultadechequedegerenciaFCYResponse as element(ns0:ConsultadechequedegerenciaFCYResponse) external;

xf:CambioEstadoChequeGerenciaFCYIn($autenticacionRequestHeader,
    $pagoChequeCajaFCY,
    $consultadechequedegerenciaFCYResponse)